//
//  Settings.swift
//  myScreenSaver
//
//  Created by Diego Ibarra on 7/1/25.
//

import AppKit
import ScreenSaver

class Settings {
	
	let font: NSFont = NSFont(name: "SpaceMono-Regular", size: 0) ?? .systemFont(ofSize: 0)

	let animationFPS: Double = 0.05
	let fontColor = NSColor(red: 0.56, green: 0.64, blue: 0.68, alpha: 1.00)
	let dateFormatEven: String = "HH:mm:ss"
	let dateFormatOdd: String = "HH mm ss"
	let colorFadeDuration: Double = 0.5
	let bgColor: NSColor = .black
		
}
