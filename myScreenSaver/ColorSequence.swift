////
////  ColorSequence.swift
////  myScreenSaver
////
////  Created by Diego Ibarra on 7/1/25.
////
//
//import Cocoa
//
//class ColorSequence {
//	
//	var red: Double = 255
//	var green: Double = 0
//	var blue: Double = 0
//	var count = round(CGFloat.random(in: 0...(255*6)))
//	
//	init() {
//		startColor()
//	}
//	
//	func startColor() {
//		if count < 255.0 {
//			red = 255
//			green = count
//			blue = 0
//		} else if count < 255*2 {
//			red = 255 - (count - (255*1))
//			green = 255
//			blue = 0
//		} else if count < 255*3 {
//			red =  0
//			green = 255
//			blue = (count - (255*2))
//		} else if count < 255*4 {
//			red  = 0
//			green = 255 - (count - (255*3))
//			blue = 255
//		} else if count < 255*5 {
//			red = (count - (255*4))
//			green = 0
//			blue = 255
//		} else if count < 255*6 {
//			red = 255
//			green = 0
//			blue = 255 - (count - (255*5))
//		} else if count == 255*6 {
//			red = 255
//			green = 0
//			blue = 0
//		}
//	}
//	
//	func update() -> (red: Double, green: Double, blue: Double) {
//		if count < 255.0 {
//			green += 1
//		} else if count < 255*2 {
//			red -= 1
//		} else if count < 255*3 {
//			blue += 1
//		} else if count < 255*4 {
//			green -= 1
//		} else if count < 255*5 {
//			red += 1
//		} else if count < 255*6 {
//			blue -= 1
//		} else if count == 255*6 {
//			green += 1
//			count = 0
//		}
//		count += 1
//		return ( red: (1/255) * red,
//				 green: (1/255) * green,
//				 blue: (1/255) * blue)
//	}
//	
//	func getColor() -> NSColor {
//		let components = update()
//		let color = NSColor(
//			calibratedRed: CGFloat(components.red),
//			green: CGFloat(components.green),
//			blue: CGFloat(components.blue),
//			alpha: 0.7)
//		
//		return color
//	}
//}


import Cocoa

class ColorSequence {
	private let maxComponent: CGFloat = 255
	private let stepsPerCycle = 6
	private var count: Int
	private var red: CGFloat = 255
	private var green: CGFloat = 0
	private var blue: CGFloat = 0
	
	init() {
		count = Int(CGFloat.random(in: 0..<(255 * 6)))
		setColor(for: count)
	}
	
	private func setColor(for count: Int) {
		let phase = count / Int(maxComponent)
		let value = CGFloat(count % Int(maxComponent))
		switch phase {
			case 0:
				red = maxComponent
				green = value
				blue = 0
			case 1:
				red = maxComponent - value
				green = maxComponent
				blue = 0
			case 2:
				red = 0
				green = maxComponent
				blue = value
			case 3:
				red = 0
				green = maxComponent - value
				blue = maxComponent
			case 4:
				red = value
				green = 0
				blue = maxComponent
			case 5:
				red = maxComponent
				green = 0
				blue = maxComponent - value
			default:
				red = maxComponent
				green = 0
				blue = 0
		}
	}
	
	func update() -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
		count = (count + 1) % Int(maxComponent * CGFloat(stepsPerCycle))
		setColor(for: count)
		return (red / maxComponent, green / maxComponent, blue / maxComponent)
	}
	
	func getColor() -> NSColor {
		let components = update()
		return NSColor(
			calibratedRed: components.red,
			green: components.green,
			blue: components.blue,
			alpha: 0.7
		)
	}
}
