////
////  PongClass.swift
////  myScreenSaver
////
////  Created by Diego Ibarra on 7/29/25.
////
//
//import Cocoa
//import Foundation
//
//class PongObject {
//	
//	// MARK: - GLOBALS
//	var areaBounds: NSRect = .zero
//	var areaSize: CGSize = .zero
//	var initialMagnitude: CGFloat = .zero
//	var paddleHalfSize: CGSize = .zero
//	var paddlePosition: CGFloat = .zero
//	var paddleBottomOffset: CGFloat = .zero
//	var pongSize: CGFloat = .zero
//	var pongPosition: CGPoint = .zero
//	var pongVelocity: CGVector = .zero
//	
//	// MARK: - INITIALIZER FUNCS
//	init() {}
//	
//	func setup(with frame: NSRect) {
//		areaBounds = frame
//		areaSize = areaBounds.size
//		paddleHalfSize = areaSize.adjustSize(by: 17, yScale: 65)
//		paddleBottomOffset = paddleHalfSize.height * 10
//		pongSize = (paddleHalfSize.height * 2)
//		pongPosition = CGPoint(x: areaSize.width / 2, y: areaSize.height / 2)
//		paddlePosition = pongPosition.x
//		pongVelocity = initialVelocity()
//		initialMagnitude = 8
//	}
//	
//	func initialVelocity() -> CGVector {
//		let xVelocity = CGFloat.random(in: 2.5...3.5)
//		let xSign: CGFloat = Bool.random() ? 1 : -1
//		let yVelocity = sqrt(pow(inititalMagnitude, 2) - pow(xVelocity, 2))
//		let ySign: CGFloat = Bool.random() ? 1 : -1
//		return CGVector(dx: xVelocity * xSign, dy: yVelocity * ySign)
//	}
//	
//	
//	// MARK: - CONTROLLER METHODS
//	/// DRAW METHODS
//	func drawObjects(with color: NSColor) {
//		drawPong(with: color)
//		drawPaddle(with: color)
//	}
//	
//	func drawPong(with color: NSColor) {
//		let pongRect = NSRect(
//			x: (self.pongPosition.x - (self.pongSize / 2)),
//			y: (self.pongPosition.y - (self.pongSize / 2)),
//			width: self.pongSize,
//			height: self.pongSize)
//		let pongObject = NSBezierPath(rect: pongRect)
//		color.setFill()
//		pongObject.fill()
//	}
//	
//	func drawPaddle(with color: NSColor) {
//		let paddleRect = NSRect(
//			x: (self.paddlePosition - self.paddleHalfSize.width),
//			y: (self.paddleBottomOffset - self.paddleHalfSize.height),
//			width: (self.paddleHalfSize.width * 2),
//			height: (self.paddleHalfSize.height * 2))
//		let paddleObject = NSBezierPath(rect: paddleRect)
//		color.setFill()
//		paddleObject.fill()
//	}
//	
//	/// LOGIC METHODS
////	func pongIsOOB(_ bounds: NSRect) -> (xAxis: Bool, yAxis: Bool) {
////		let xAxisOOB = self.pongPosition.x - self.pongSize <= 0 || self.pongPosition.x + self.pongSize >= bounds.width
////		let yAxisOOB = self.pongPosition.y - self.pongSize <= 0 || self.pongPosition.y + self.pongSize >= bounds.height
////		return (xAxisOOB, yAxisOOB)
////	}
//	
//	func pongIsOOB(_ bounds: NSRect) -> (xAxis: Bool, yAxis: Bool) {
//		let halfSize = pongSize / 2
//		let xAxisOOB = pongPosition.x - halfSize <= 0 || pongPosition.x + halfSize >= bounds.width
//		let yAxisOOB = pongPosition.y - halfSize <= 0 || pongPosition.y + halfSize >= bounds.height
//		return (xAxisOOB, yAxisOOB)
//	}
//		
//	func pongPaddleContact() -> Bool {
////		let xRange = (paddlePosition - paddleHalfSize.width)..<(paddlePosition + paddleHalfSize.width)
////		let yRange = (paddleBottomOffset - paddleHalfSize.height)..<(paddleBottomOffset + paddleHalfSize.height)
////		return xRange.contains(pongPosition.x) && yRange.contains(pongPosition.y)
//		let xBounds = (
//			lower: paddlePosition - paddleHalfSize.width,
//			upper: paddlePosition + paddleHalfSize.width
//		)
//		let yBounds = (
//			lower: paddleBottomOffset - paddleHalfSize.height,
//			upper: paddleBottomOffset + paddleHalfSize.height
//		)
//		return pongPosition.x >= xBounds.lower && pongPosition.x <= xBounds.upper && pongPosition.y + pongSize >= yBounds.lower && pongPosition.y - pongSize <= yBounds.upper
//	}
//	
//	// MARK: - LIFECYCLE
//	func pongCycle() {
//		
//		/// CHECK CONDITIONS
//		let oobAxis = pongIsOOB(areaBounds)
//		if oobAxis.xAxis { self.pongVelocity.dx *= -1 }
//		if oobAxis.yAxis { self.pongVelocity.dy *= -1 }
//		
//		let paddleContact = pongPaddleContact()
//		if paddleContact { self.pongVelocity.dy *= -1 }
//		
//		/// UPDATE OBJECTS' POINTS
//		self.pongPosition.x += self.pongVelocity.dx
//		self.pongPosition.y += self.pongVelocity.dy
//		self.paddlePosition = self.pongPosition.x
//		
//		if self.pongPosition.x < self.paddleHalfSize.width {
//			self.paddlePosition = self.paddleHalfSize.width
//		}
//		
//		if self.pongPosition.x > areaBounds.width - paddleHalfSize.width {
//			self.paddlePosition = areaBounds.width - paddleHalfSize.width
//		}
//				
//	}
//
//}
//
////MyLogger().log(message: "w:\(paddleHalfSize.width) h:\(paddleHalfSize.height)", description: "paddleHalfSize")
////MyLogger().log(message: pongSize, description: "PongSize")
////MyLogger().log(message: paddleBottomOffset, description: "PaddleBottomOffset")

import Cocoa
import Foundation

class PongObject {
	// MARK: - Properties
	var areaBounds: NSRect = .zero
	var areaSize: CGSize = .zero
	var initialMagnitude: CGFloat = 8
	var paddleHalfSize: CGSize = .zero
	var paddlePosition: CGFloat = .zero
	var paddleBottomOffset: CGFloat = .zero
	var pongSize: CGFloat = .zero
	var pongPosition: CGPoint = .zero
	var pongVelocity: CGVector = .zero
	
	// MARK: - Setup
	init() {}
	
	func setup(with frame: NSRect) {
		areaBounds = frame
		areaSize = frame.size
		paddleHalfSize = areaSize.adjustSize(by: 17, yScale: 65)
		paddleBottomOffset = paddleHalfSize.height * 10
		pongSize = paddleHalfSize.height * 2
		pongPosition = CGPoint(x: areaSize.width / 2, y: areaSize.height / 2)
		paddlePosition = pongPosition.x
		pongVelocity = initialVelocity()
	}
	
	func initialVelocity() -> CGVector {
		let xVelocity = CGFloat.random(in: 2.5...3.5)
		let xSign: CGFloat = Bool.random() ? 1 : -1
		let yVelocity = sqrt(pow(initialMagnitude, 2) - pow(xVelocity, 2))
		let ySign: CGFloat = Bool.random() ? 1 : -1
		return CGVector(dx: xVelocity * xSign, dy: yVelocity * ySign)
	}
	
	// MARK: - Drawing
	var pongRect: NSRect {
		NSRect(
			x: pongPosition.x - pongSize / 2,
			y: pongPosition.y - pongSize / 2,
			width: pongSize,
			height: pongSize
		)
	}
	
	var paddleRect: NSRect {
		NSRect(
			x: paddlePosition - paddleHalfSize.width,
			y: paddleBottomOffset - paddleHalfSize.height,
			width: paddleHalfSize.width * 2,
			height: paddleHalfSize.height * 2
		)
	}
	
	func drawObjects(with color: NSColor) {
		color.setFill()
		NSBezierPath(rect: pongRect).fill()
		NSBezierPath(rect: paddleRect).fill()
	}
	
	// MARK: - Logic
	func pongIsOOB(_ bounds: NSRect) -> (xAxis: Bool, yAxis: Bool) {
		let halfSize = pongSize / 2
		let xAxisOOB = pongPosition.x - halfSize <= 0 || pongPosition.x + halfSize >= bounds.width
		let yAxisOOB = pongPosition.y - halfSize <= 0 || pongPosition.y + halfSize >= bounds.height
		return (xAxisOOB, yAxisOOB)
	}
	
	func pongPaddleContact() -> Bool {
		pongRect.intersects(paddleRect)
	}
	
	// MARK: - Lifecycle
	func pongCycle() {
		let oobAxis = pongIsOOB(areaBounds)
		if oobAxis.xAxis { pongVelocity.dx *= -1 }
		if oobAxis.yAxis { pongVelocity.dy *= -1 }
		
		if pongPaddleContact() { pongVelocity.dy *= -1 }
		
		pongPosition.x += pongVelocity.dx
		pongPosition.y += pongVelocity.dy
		paddlePosition = pongPosition.x
		
		paddlePosition = max(paddleHalfSize.width, min(paddlePosition, areaBounds.width - paddleHalfSize.width))
	}
}
