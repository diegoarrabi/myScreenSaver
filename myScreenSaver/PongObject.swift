//
//  PongClass.swift
//  myScreenSaver
//
//  Created by Diego Ibarra on 7/29/25.
//

import Cocoa
import Foundation

class PongObject {
	// MARK: - Properties

	var initialMagnitude: CGFloat = 5
	var areaBounds: NSRect = .zero
	var paddleHalfSize: CGSize = .zero
	var paddleBottomOffset: CGFloat = .zero
	var pongSize: CGFloat = .zero
	var pongPosition: CGPoint = .zero
	var pongVelocity: CGVector = .zero

	// MARK: - Setup

	init() {}

	func setup(with frame: NSRect) {
		areaBounds = frame
		paddleHalfSize = areaBounds.size.adjustSize(by: 17, yScale: 65)
		
		paddleBottomOffset = paddleHalfSize.height * 10
		pongSize = paddleHalfSize.height * 2
		
		pongVelocity = initialVelocity()
		pongPosition = initialPosition()
	}

	func initialVelocity() -> CGVector {
		let xVelocity = CGFloat.random(in: 2.0 ... 3.0)
		let xSign: CGFloat = Bool.random() ? 1 : -1
		let yVelocity = sqrt(pow(initialMagnitude, 2) - pow(xVelocity, 2))
		let ySign: CGFloat = Bool.random() ? 1 : -1
		
		return CGVector(dx: xVelocity * xSign, dy: yVelocity * ySign)
	}

	func initialPosition() -> CGPoint {
		let yPosition = CGFloat.random(
			in: (paddleBottomOffset + pongSize) ... (areaBounds.maxY - pongSize)
		)
		let xPosition = CGFloat.random(
			in: pongSize ... (areaBounds.maxX - pongSize)
		)
		
		return CGPoint(x: xPosition, y: yPosition)
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
			x: pongPosition.x - paddleHalfSize.width,
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
		let yAxisOOB = pongPosition.y - halfSize <= (paddleBottomOffset + halfSize) || pongPosition.y + halfSize >= bounds.height
		
		return (xAxisOOB, yAxisOOB)
	}

	// MARK: - Lifecycle
	
	func pongCycle() {
		let oobAxis = pongIsOOB(areaBounds)
		if oobAxis.xAxis { pongVelocity.dx *= -1 }
		if oobAxis.yAxis { pongVelocity.dy *= -1 }
		
		pongPosition.x += pongVelocity.dx
		pongPosition.y += pongVelocity.dy
	}
}
