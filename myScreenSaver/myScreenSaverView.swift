////
////  screensaverView.swift
////  myScreenSaver
////
////  Created by Diego Ibarra on 7/1/25.
////
//
//import Cocoa
//import ScreenSaver
//import OSLog
//
//
//class myScreenSaverView: ScreenSaverView {
//	
//	// MARK: - GLOBALS
//	let settings = ScreenSaverSettings.shared
//	var displayRect: NSRect = .zero
//	var displaySize: CGSize = .zero
//	let wrapperView = NSStackView()
//	let pongObject = PongObject()
//	let timeView = TimeView()
//	let textView = TextView()
//	let colorSequence = ColorSequence()
//	var startedAnimating = false
//	var drawCounter = 0
//	
//	
//	// MARK: - INITIALIZER FUNCS
//	private func setup() {
//		animationTimeInterval = self.settings.animationFPS
//		self.displaySize = displayRect.size
//		pongObject.setup(with: displayRect)
//		configureViews()
//		timeView.resizeFont(for: displaySize)
//	}
//		
//	func configureViews() {
//		wrapperView.alignment = .centerX
//		wrapperView.orientation = .vertical
//		wrapperView.distribution = .equalCentering
//		wrapperView.addArrangedSubview(timeView)
//		addSubview(wrapperView)
//		wrapperView.translatesAutoresizingMaskIntoConstraints = false
//		wrapperView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//		wrapperView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
//		wrapperView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//	}
//	
//	// MARK: - INITIALIZATION
//	override init?(frame: NSRect, isPreview: Bool) {
//		self.displayRect = frame
//		super.init(frame: frame, isPreview: isPreview)
//		MyLogger().log(message: "Ran From Override init")
//	}
//	
//	required init?(coder: NSCoder) {
//		self.displayRect = .zero
//		super.init(coder: coder)
//	}
//	
//	override func viewDidMoveToWindow() {
//		super.viewDidMoveToWindow()
//		self.displayRect = self.bounds
//		setup()
//	}
//	// MARK: - LIFECYCLE
//	override func draw(_ rect: NSRect) {
//		if drawCounter <= 10 {
//			settings.backgroundColor.setFill()
//			self.bounds.fill()
//		}
////		settings.backgroundColor.setFill()
////		self.bounds.fill()
//		
//		let color = colorSequence.getColor()
//		let desaturatedColor = color.withSaturation(0.5) ?? color
//		let complementaryColor = desaturatedColor.withComplementary()
//
//		timeView.update(with: complementaryColor)
//		pongObject.drawObjects(with: desaturatedColor)
//	}
//	
//	override func animateOneFrame() {
//		pongObject.pongCycle()
//		setNeedsDisplay(self.bounds)
//	}
//}
//

import Cocoa
import ScreenSaver
import OSLog

class myScreenSaverView: ScreenSaverView {
	// MARK: - Properties
	let settings = ScreenSaverSettings.shared
	var displayRect: NSRect
	var displaySize: CGSize { displayRect.size }
	let wrapperView = NSStackView()
	let pongObject = PongObject()
	let timeView = TimeView()
	let textView = TextView()
	let colorSequence = ColorSequence()
	var startedAnimating = false
	var drawCounter = 0
	
	// MARK: - Initializers
	override init?(frame: NSRect, isPreview: Bool) {
		self.displayRect = frame
		super.init(frame: frame, isPreview: isPreview)
		configureViews()
		MyLogger().log(message: "Ran From Override init")
	}
	
	required init?(coder: NSCoder) {
		self.displayRect = .zero
		super.init(coder: coder)
		configureViews()
	}
	
	// MARK: - Setup
	private func setup() {
		animationTimeInterval = settings.animationFPS
		pongObject.setup(with: displayRect)
		timeView.resizeFont(for: displaySize)
	}
	
	private func configureViews() {
		wrapperView.alignment = .centerX
		wrapperView.orientation = .vertical
		wrapperView.distribution = .equalCentering
		wrapperView.addArrangedSubview(timeView)
		addSubview(wrapperView)
		wrapperView.translatesAutoresizingMaskIntoConstraints = false
		wrapperView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		wrapperView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
		wrapperView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
	}
	
	// MARK: - Lifecycle
	override func viewDidMoveToWindow() {
		super.viewDidMoveToWindow()
		displayRect = bounds
		setup()
	}
	
	override func draw(_ rect: NSRect) {
		if drawCounter <= 2 {
			settings.backgroundColor.setFill()
			NSBezierPath(rect: bounds).fill()
		}
		let desaturatedColor = colorSequence.getColor().withSaturation(0.5)
		let complementaryColor = desaturatedColor.withComplementary()
		timeView.update(with: complementaryColor)
		pongObject.drawObjects(with: desaturatedColor)
	}
	
	override func animateOneFrame() {
		pongObject.pongCycle()
		setNeedsDisplay(bounds)
	}
}
