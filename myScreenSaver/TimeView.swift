//
//  TimeView.swift
//  myScreenSaver
//
//  Created by Diego Ibarra on 7/1/25.
//

import Cocoa

class TimeView: NSTextField {
	let settings = ScreenSaverSettings.shared
	private var counter = 0.0
	private let dateFormatter = DateFormatter()
	var dateValue: String = String()
	
	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		setup()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}
	
	private func setup() {
		drawsBackground = false
		isBezeled = false
		isBordered = false
		isEditable = false
		font = settings.font
		textColor = settings.fontColor
		stringValue = settings.dateFormatEven
	}
	
	func updateTime() {
		dateFormatter.dateFormat = timeFlash()
		let newDate = dateFormatter.string(from: Date())
		if newDate != dateValue {
			stringValue = newDate
		}
		dateValue = newDate
	}
	
	private func timeFlash() -> String {
		let countTo = round(1 / settings.animationFPS)
		counter += 1
		if counter < countTo / 2 {
			return settings.dateFormatEven
		} else if counter < countTo {
			return settings.dateFormatOdd
		} else {
			counter = 0.0
			return settings.dateFormatEven
		}
	}
	
	func resizeFont(for size: NSSize) {
		font = settings.font.withSize(size.width * 0.18)
	}
	
	func update(with color: NSColor?) {
		textColor = color
		updateTime()
	}
}
