//
//  ComplementaryColor.swift
//  myScreenSaver
//
//  Created by Diego Ibarra on 7/6/25.
//

import Cocoa

extension NSColor {
	func withComplementary() -> NSColor {
		guard let rgbColor = self.usingColorSpace(.deviceRGB) else { return self }
		var hue: CGFloat = 0
		var saturation: CGFloat = 0
		var brightness: CGFloat = 0
		var alpha: CGFloat = 0
		rgbColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
		let complementaryHue = fmod(hue + 0.5, 1.0)
		return NSColor(hue: complementaryHue, saturation: saturation, brightness: brightness, alpha: alpha)
	}
	
	func withChanges(saturation newSaturation: CGFloat = 1.0, brightness newBrightness: CGFloat = 1.0) -> NSColor {
		guard let rgbColor = self.usingColorSpace(.deviceRGB) else { return self }
		var hue: CGFloat = 0
		var saturation: CGFloat = 0
		var brightness: CGFloat = 0
		var alpha: CGFloat = 0
		rgbColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
		if saturation == newSaturation { return self }
		return NSColor(hue: hue, saturation: newSaturation, brightness: newBrightness, alpha: alpha)
	}
}
