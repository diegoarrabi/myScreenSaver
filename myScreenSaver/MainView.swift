//
//  screensaverView.swift
//  myScreenSaver
//
//  Created by Diego Ibarra on 7/1/25.
//

import Cocoa
import OSLog
import ScreenSaver

class MainView: ScreenSaverView {
	// MARK: - Properties
	
	let settings = ScreenSaverSettings.shared
	var displayRect: NSRect
	let wrapperView = NSStackView()
	let pongObject = PongObject()
	let timeView = TimeView()
//	let textView = TextView()
	let colorSequence = ColorSequence()
	
	// MARK: - Initializers
	
	override init?(frame: NSRect, isPreview: Bool) {
		displayRect = frame
		super.init(frame: frame, isPreview: isPreview)
		setup()
		viewSetup()
	}
	
	required init?(coder: NSCoder) {
		displayRect = .zero
		super.init(coder: coder)
		setup()
		viewSetup()
	}
	
	override func viewDidMoveToWindow() {
		super.viewDidMoveToWindow()
		displayRect = bounds
		setup()
		viewSetup()
	}
	
	// MARK: - Setup
	
	private func setup() {
		animationTimeInterval = settings.animationFPS
		pongObject.setup(with: displayRect)
		timeView.resizeFont(for: displayRect.size)
	}
	
	private func viewSetup() {
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
	
	override func draw(_ rect: NSRect) {
		settings.backgroundColor.setFill()
		NSBezierPath(rect: bounds).fill()
		let color = colorSequence.getColor().withChanges(saturation: 0.5, brightness: 0.7)
		timeView.update(with: color.withComplementary())
		pongObject.drawObjects(with: color)
	}
	
	override func animateOneFrame() {
		pongObject.pongCycle()
		setNeedsDisplay(bounds)
	}
}
