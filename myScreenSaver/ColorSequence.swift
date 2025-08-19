//
//  ColorSequence.swift
//  myScreenSaver
//
//  Created by Diego Ibarra on 7/1/25.
//

import Cocoa

class ColorSequence {
	private let maxComponent: CGFloat = 255
	private let stepsPerCycle = 6.0
	private var count: Int
	private var red: CGFloat = 255
	private var green: CGFloat = 0
	private var blue: CGFloat = 0
	
	init() {
		count = Int(CGFloat.random(in: 0..<(maxComponent * stepsPerCycle)))
		updateColor(for: count)
	}
	
	private func updateColor(for count: Int) {
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
	
	func getColor() -> NSColor {
		count = (count + 1) % Int(maxComponent * CGFloat(stepsPerCycle))
		updateColor(for: count)
		return NSColor(
			calibratedRed: red / maxComponent,
			green: green / maxComponent,
			blue: blue / maxComponent,
			alpha: 1
		)
	}
}
