//
//  screensaverView.swift
//  myScreenSaver
//
//  Created by Diego Ibarra on 7/1/25.
//

import Cocoa
import ScreenSaver


class myScreenSaverView: ScreenSaverView {
	
	// MARK: - GLOBALS
	let settings = ScreenSaverSettings.shared
	let wrapperView = NSStackView()
	let colorSequence = ColorSequence()
	let timeView = TimeView()
	let textView = TextView()
	var ballPosition: CGPoint = CGPoint()
	var ballVelocity: CGVector = CGVector()
	var initialized = false
	


	// MARK: - INITIALIZER FUNCS
//	func getBallPosition() -> CGPoint {
//		return CGPoint(x: frame.width / 2, y: frame.height / 2)
//	}
	
//	func getBallVelocity() -> CGVector {
//		return initialVelocity()
//	}
	
	func configureViews() {
		wrapperView.alignment = .centerX
		wrapperView.orientation = .vertical
		wrapperView.distribution = .equalCentering
		wrapperView.addArrangedSubview(timeView)
		// wrapperView.addArrangedSubview(textView)
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
		animationTimeInterval = settings.animationFPS
		configureViews()
		layoutViews()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		animationTimeInterval = settings.animationFPS
		configureViews()
		layoutViews()
	}
	
	// MARK: - LIFECYCLE
	
	
	override func draw(_ rect: NSRect) {
		if(!self.initialized){
			initBallPaddle()
		}
		settings.backgroundColor.setFill()
		bounds.fill()
		let color = colorSequence.getColor()
		let desaturatedColor = color.withSaturation(0.5) ?? color
		let complementaryColor = desaturatedColor.withComplementary()
		drawBall(desaturatedColor)
		drawPaddle(desaturatedColor)
		timeView.updateColor(complementaryColor)
		
	}
	
	private func drawBallPaddle() {
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
		
		timeView.update(timeView.timeFlash())
	}
	
	private func initBallPaddle() {
		self.initialized = true
		ballPosition = CGPoint(x: frame.width / 2, y: frame.height / 2)
		ballVelocity = initialVelocity()
	}

	override func animateOneFrame() {
		super.animateOneFrame()
		setNeedsDisplay(bounds)
	}
	
	class override func performGammaFade() -> Bool {
		return true
	}
}
