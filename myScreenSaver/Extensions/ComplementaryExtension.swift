//
//  ComplementaryColor.swift
//  myScreenSaver
//
//  Created by Diego Ibarra on 7/6/25.
//

import Foundation

import Cocoa

extension NSColor {
	func withComplementary() -> NSColor? {
		guard let rgbColor = self.usingColorSpace(.deviceRGB) else { return nil }
		var hue: CGFloat = 0
		var saturation: CGFloat = 0
		var brightness: CGFloat = 0
		var alpha: CGFloat = 0
		rgbColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
		let compHue = fmod(hue + 0.5, 1.0)
		return NSColor(hue: compHue, saturation: saturation, brightness: brightness, alpha: alpha)
	}
}
