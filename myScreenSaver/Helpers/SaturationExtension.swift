////
////  SaturationExtension.swift
////  myScreenSaver
////
////  Created by Diego Ibarra on 7/6/25.
////
//
//import Cocoa
//
//extension NSColor {
//	func withSaturation(_ newSaturation: CGFloat) -> NSColor? {
//		guard let hsbColor = self.usingColorSpace(.deviceRGB) else { return nil }
//		var hue: CGFloat = 0
//		var saturation: CGFloat = 0
//		var brightness: CGFloat = 0
//		var alpha: CGFloat = 0
//		hsbColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
//		return NSColor(hue: hue, saturation: newSaturation, brightness: brightness, alpha: alpha)
//	}
//}


import Cocoa

extension NSColor {
	func withSaturation(_ newSaturation: CGFloat) -> NSColor {
		guard let rgbColor = self.usingColorSpace(.deviceRGB) else { return self }
		var hue: CGFloat = 0
		var saturation: CGFloat = 0
		var brightness: CGFloat = 0
		var alpha: CGFloat = 0
		rgbColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
		if saturation == newSaturation { return self }
		return NSColor(hue: hue, saturation: newSaturation, brightness: brightness, alpha: alpha)
	}
}
