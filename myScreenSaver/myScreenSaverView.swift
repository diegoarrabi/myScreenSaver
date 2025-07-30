//
//  screensaverView.swift
//  myScreenSaver
//
//  Created by Diego Ibarra on 7/1/25.
//

import Cocoa
import ScreenSaver
import OSLog


class myScreenSaverView: ScreenSaverView {
	
	// MARK: - GLOBALS
	let displaySize = NSScreen.main?.frame.size
	let settings = ScreenSaverSettings.shared
	let wrapperView = NSStackView()
	let newVARIABLE: String = "newVARIABLE"
	let newINTEGER: Float = 00112233445566778899.01
	let colorSequence = ColorSequence()
	let timeView = TimeView()
	let textView = TextView()
	
	
	// MARK: - INITIALIZER FUNCS
	private func setup() {
		animationTimeInterval = settings.animationFPS
		configureViews()
		layoutViews()
		ballPosition = CGPoint(x: displaySize!.width / 2, y: displaySize!.height / 2)
		ballVelocity = initialVelocity()
	}
		
	func configureViews() {
		wrapperView.alignment = .centerX
		wrapperView.orientation = .vertical
		wrapperView.distribution = .equalCentering
		wrapperView.addArrangedSubview(timeView)
		addSubview(wrapperView)
	}
	
	func layoutViews() {
		wrapperView.translatesAutoresizingMaskIntoConstraints = false
		wrapperView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		wrapperView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
		wrapperView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		timeView.resizeFont(for: bounds.size)
	}
	
	
	// MARK: - INITIALIZATION
	override init?(frame: NSRect, isPreview: Bool) {
		super.init(frame: frame, isPreview: isPreview)
		setup()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}
	
	class override func performGammaFade() -> Bool {
		return true
	}
	
	func logValues() {
		let logString = String(repeating: "#", count: 50)
		os_log("%{public}@", logString)
		os_log("Ball Velocity: %{public}@", "\(ballVelocity)")
	}
	
	
	// MARK: - LIFECYCLE
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
		timeView.update(timeView.timeFlash())
		
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
		
		setNeedsDisplay(bounds)
	}
	
	
}

