//
//  Settings.swift
//  myScreenSaver
//
//  Created by Diego Ibarra on 7/1/25.
//

import AppKit
import Foundation
import ScreenSaver

class Preferences: NSObject {
	
	static var shared: Preferences? = nil
	private let defaults: UserDefaults
	
	let fontName: String = "JetBrainsMono-Medium"
	let fontExt: String = "otf"
	
	override init() {
			// Configure Defaults for bundle
		defaults = ScreenSaverDefaults(forModuleWithName: Bundle(for: Preferences.self).bundleIdentifier!)!
		super.init()
		Preferences.shared = self
		Preferences.loadFont(fontName: fontName, fontExt: fontExt)
	}
	
	//	let animationFPS: Double = 0.05
	var animationFPS: Double {
			// Only use Regular Width Roman Fonts
		get { return (defaults.value(forKey: "AnimationFPS") as? Double) ?? 0.05 }
		set {
			defaults.setValue(newValue, forKey: "AnimationFPS")
			defaults.synchronize()
		}
	}
	
//	let backgroundColor: NSColor = .black
	var backgroundColor: NSColor {
		get { return (defaults.value(forKey: "BackgroundColor") as? NSColor) ?? .black }
		set {
			defaults.setValue(newValue, forKey: "BackgroundColor")
			defaults.synchronize()
		}
	}
	
	let fontColor = NSColor(red: 0.31, green: 0.55, blue: 0.56, alpha: 1.00)
	let dateFormatEven: String = "HH:mm:ss"
	let dateFormatOdd: String = "HH mm ss"
	let colorFadeDuration: Double = 0.5
	
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
