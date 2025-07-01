//
//  Settings.swift
//  myScreenSaver
//
//  Created by Diego Ibarra on 7/1/25.
//

import AppKit
import ScreenSaver

class Settings {
	let animationFPS: Double = 0.05
	let fontName: String = "JetBrainsMono-Medium"
	let fontExt: String = "otf"
	let fontColor = NSColor(red: 0.31, green: 0.55, blue: 0.56, alpha: 1.00)
	let dateFormatEven: String = "HH:mm:ss"
	let dateFormatOdd: String = "HH mm ss"
	let colorFadeDuration: Double = 0.5
	let bgColor: NSColor = .black
	
	static func loadFont(fontName: String, fontExt: String) {
		let bundle = Bundle(for: self)
		guard
			let url = bundle.url(forResource: fontName, withExtension: fontExt)
		else {
			fatalError("Could not load font: \(fontName).\(fontExt)")
		}
		var error: Unmanaged<CFError>? = nil
		CTFontManagerRegisterFontsForURL(url as CFURL, .process, &error)
		if error != nil {
			NSLog(String(describing: error))
		}
	}
}
