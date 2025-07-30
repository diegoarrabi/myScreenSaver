////
////  TimeView.swift
////  myScreenSaver
////
////  Created by Diego Ibarra on 7/1/25.
////
//
//import Cocoa
//
//class TimeView: NSTextField {
//    let settings = ScreenSaverSettings.shared
//    var counter = 0.0
//    var timeKeeper = 0.0
//	var timeString = ""
//	var theTime = ""
//
//    override init(frame frameRect: NSRect) {
//        super.init(frame: frameRect)
//        setup()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setup()
//    }
//
//    func setup() {
//        drawsBackground = false
//        isBezeled = false
//        isBordered = false
//        isEditable = false
//        font = settings.font
//        textColor = settings.fontColor
//		stringValue = settings.dateFormatEven
//    }
//
//    func updateTime() {
//        let date = Date()
//        let formatter = DateFormatter()
//		formatter.dateFormat = timeFlash()
//        stringValue = formatter.string(from: date)
//    }
//
//    func timeFlash() -> String {
//        let countTo = round(1 / settings.animationFPS) + 5
//        counter += 1
//        if counter < countTo / 2 {
//            return settings.dateFormatEven
//        } else if counter < countTo {
//            return settings.dateFormatOdd
//        } else if counter == countTo {
//            counter = 0.0
//        }
//        return settings.dateFormatEven
//    }
//
//    func resizeFont(for size: NSSize) {
//        let newFontSize = size.width * 0.18
//        font = settings.font.withSize(newFontSize)
//    }
//
//    func update(with color: NSColor?) {
//        textColor = color
//		updateTime()
//    }
//}

import Cocoa

class TimeView: NSTextField {
	let settings = ScreenSaverSettings.shared
	private var counter = 0.0
	private let dateFormatter = DateFormatter()
	
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
		stringValue = dateFormatter.string(from: Date())
	}
	
	private func timeFlash() -> String {
		let countTo = round(1 / settings.animationFPS) + 5
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
