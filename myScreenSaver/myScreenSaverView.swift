//
//  screensaverView.swift
//  myScreenSaver
//
//  Created by Diego Ibarra on 7/1/25.
//

import Cocoa
import ScreenSaver
import os.log


class myScreenSaverView: ScreenSaverView {
	
	let settings = ScreenSaverSettings.shared

	let wrapperView = NSStackView()
	let colorSequence = ColorSequence()
	let timeView = TimeView()
	let textView = TextView()


	override init?(frame: NSRect, isPreview: Bool) {
		super.init(frame: frame, isPreview: isPreview)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func logValues() {
		os_log("############################################")
		os_log("############################################")
		os_log("############################################")
		os_log("Ball Velocity: %{public}@", "\(ballVelocity)")
	}
	
	override func viewDidMoveToWindow() {
		wantsLayer = true
		animationTimeInterval = settings.animationFPS
		configureViews()
		layoutViews()
		animateOneFrame()
		ballPosition = CGPoint(x: frame.width / 2, y: frame.height / 2)
		ballVelocity = initialVelocity()
		logValues()
	}
	
	func configureViews() {
		wrapperView.alignment = .centerX
		wrapperView.orientation = .vertical
		wrapperView.distribution = .equalCentering
		wrapperView.addArrangedSubview(timeView)
//		wrapperView.addArrangedSubview(textView)
		addSubview(wrapperView)
	}
	
	func layoutViews() {
		wrapperView.translatesAutoresizingMaskIntoConstraints = false
		wrapperView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		wrapperView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
		wrapperView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		timeView.resizeFont(for: bounds.size)
	}
	
	override func draw(_ rect: NSRect) {
		settings.backgroundColor.setFill()
		bounds.fill()
		let color = colorSequence.getColor()
		let desaturatedColor = color.withSaturation(0.5) ?? color
		let complementaryColor = desaturatedColor.withComplementary()
		drawBall(desaturatedColor)
		drawPaddle(desaturatedColor)
		timeView.updateColor(complementaryColor)
		
	}
	
	override func animateOneFrame() {
		let oobAxis = ballIsOOB(bounds)
		if oobAxis.xAxis {
			ballVelocity.dx *= -1
		}
		if oobAxis.yAxis {
			ballVelocity.dy *= -1
		}
		let paddleContact = ballHitPaddle()
		if paddleContact {
			ballVelocity.dy *= -1
		}
		ballPosition.x += ballVelocity.dx
		ballPosition.y += ballVelocity.dy
		paddlePosition = ballPosition.x
		
		if ballPosition.x < paddleSize.width / 2 {
			paddlePosition = paddleSize.width / 2
		}
		if ballPosition.x > bounds.width - paddleSize.width / 2 {
			paddlePosition = bounds.width - paddleSize.width / 2
		}
		
		let flasher = timeView.timeFlash()
		timeView.update(flasher)
		setNeedsDisplay(bounds)
	}
	
	class override func performGammaFade() -> Bool {
		return true
	}
}
