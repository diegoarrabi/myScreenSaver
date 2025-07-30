//
//  TimeView.swift
//  myScreenSaver
//
//  Created by Diego Ibarra on 7/1/25.
//

import Cocoa

class TimeView: NSTextField {
    let settings = ScreenSaverSettings.shared
    var counter = 0.0
    var timeKeeper = 0.0

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
        font = settings.font
        textColor = settings.fontColor
    }

    func update(_ dateFormat: String) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let dateString = formatter.string(from: date)
        stringValue = dateString
    }

    func timeFlash() -> String {
        let countTo = round(1 / settings.animationFPS) + 5
        counter += 1
        if counter < countTo / 2 {
            return settings.dateFormatEven
        } else if counter < countTo {
            return settings.dateFormatOdd
        } else if counter == countTo {
            counter = 0.0
        }
        return settings.dateFormatEven
    }

    func resizeFont(for size: NSSize) {
        let newFontSize = size.width * 0.18
        font = settings.font.withSize(newFontSize)
    }

    func updateColor(_ color: NSColor?) {
        textColor = color
    }
}
