//
//  screensaverView.swift
//  myScreenSaver
//
//  Created by Diego Ibarra on 7/1/25.
//

import Cocoa
import ScreenSaver

class myScreenSaverView: ScreenSaverView {
	
	let wrapperView = NSStackView()
	let colorSequence = ColorSequence()
	let settings = Settings()
	let timeView = TimeView()


	override init?(frame: NSRect, isPreview: Bool) {
		super.init(frame: frame, isPreview: isPreview)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	

	override func viewDidMoveToWindow() {
		wantsLayer = true
		animationTimeInterval = settings.animationFPS
		loadFonts()
		configureViews()
		layoutViews()
		animateOneFrame()
		ballPosition = CGPoint(x: frame.width / 2, y: frame.height / 2)
		ballVelocity = initialVelocity()
	}
	
	func loadFonts() {
//		Settings.loadFont(fontName: settings.fontName, fontExt: settings.fontExt)
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
	
	override func draw(_ rect: NSRect) {
		settings.bgColor.setFill()
		bounds.fill()
		let color = colorSequence.getColor()
		let satColor = color.withSaturation(0.5) ?? color
		let comColor = satColor.withComplementary()
		drawBall(satColor)
		drawPaddle(satColor)
		timeView.updateColor(comColor)
		
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
