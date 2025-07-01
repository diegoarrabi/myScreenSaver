//
//  TimeView.swift
//  myScreenSaver
//
//  Created by Diego Ibarra on 7/1/25.
//

import Cocoa

class TimeView: NSTextField {
	
	let settings = Settings()
	var counter = 0.0
	var dateFormat = ""
	
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
		font = NSFont(name: settings.fontName, size: 0)
		textColor = settings.fontColor
	}
	
	func update(_ dateFormat: String) {
		let date = Date()
		let formatter = DateFormatter()
		formatter.dateFormat = dateFormat
		let dateString = formatter.string(from: date)
		stringValue = dateString
	}
	
	func timeFlash () -> String{
		let countTo = round(1/settings.animationFPS)
		counter += 1
		if counter < countTo/2 {
			dateFormat = settings.dateFormatEven
		} else if counter < countTo {
			dateFormat = settings.dateFormatOdd
		} else if counter == countTo {
			counter = 0.0
		}
		return dateFormat
	}
	
	func resizeFont(for size: NSSize) {
		let newFontSize = size.width * 0.18
		font = NSFont(name: settings.fontName, size: newFontSize)
	}
}
