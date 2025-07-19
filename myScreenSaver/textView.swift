//
//  textView.swift
//  myScreenSaver
//
//  Created by Diego Ibarra on 7/19/25.
//

import Cocoa

class TextView: NSTextField {
	
	let settings = ScreenSaverSettings.shared
	
	
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		setup()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}
	
	func setup() {
		drawsBackground = false
		isBezeled = false
		isBordered = false
		isEditable = false
		font = settings.font.withSize(CGFloat(18))
		textColor = .white
		update()
		
	}
	
	func update() {
		let date = Date()
		let formatter = DateFormatter()
		formatter.dateFormat = "MM dd yyyy"
		let dateString = formatter.string(from: date)
		stringValue = dateString
	}
	
}
