//
//  PongSettings.swift
//  myScreenSaver
//
//  Created by Diego Ibarra on 7/1/25.
//

import Cocoa

@MainActor var ballPosition: CGPoint = .zero
@MainActor var ballVelocity: CGVector = .zero
@MainActor var paddlePosition: CGFloat = 0

let inititalMagnitude: CGFloat = 8
let ballRadius: CGFloat = 10
let paddleBottomOffset: CGFloat = 100
let paddleSize = NSSize(width: 120, height: 20)

@MainActor func drawBall(_ color: NSColor) {
	let ballRect = NSRect(x: ballPosition.x - (ballRadius / 2),
						  y: ballPosition.y - (ballRadius / 2),
						  width: ballRadius * 2,
						  height: ballRadius * 2)
	let ball = NSBezierPath(rect: ballRect )
//							xRadius: ballRadius,
//							yRadius: ballRadius)
	
//	let ball = NSBezierPath(roundedRect: ballRect,
//							xRadius: ballRadius,
//							yRadius: ballRadius)
	color.setFill()
	ball.fill()
}

@MainActor func drawPaddle(_ color: NSColor) {
	let paddleRect = NSRect(x: paddlePosition - (paddleSize.width / 2),
							y: paddleBottomOffset - (paddleSize.height / 2),
							width: paddleSize.width,
							height: paddleSize.height)
	let paddle = NSBezierPath(rect: paddleRect )
	color.setFill()
	paddle.fill()
}

func initialVelocity() -> CGVector {
	let xVelocity = CGFloat.random(in: 2.5...3.5)
	let xSign: CGFloat = Bool.random() ? 1 : -1
	let yVelocity = sqrt(pow(inititalMagnitude, 2) - pow(xVelocity, 2))
	let ySign: CGFloat = Bool.random() ? 1 : -1
	return CGVector(dx: xVelocity * xSign, dy: yVelocity * ySign)
}

@MainActor func ballIsOOB(_ bounds: NSRect) -> (xAxis: Bool, yAxis: Bool) {
	let xAxisOOB = ballPosition.x - ballRadius <= 0 ||
	ballPosition.x + ballRadius >= bounds.width
	let yAxisOOB = ballPosition.y - ballRadius <= 0 ||
	ballPosition.y + ballRadius >= bounds.height
	return (xAxisOOB, yAxisOOB)
}

@MainActor func ballHitPaddle() -> Bool {
	let xBounds = (lower: paddlePosition - (paddleSize.width / 2),
				   upper: paddlePosition + (paddleSize.width / 2))
	let yBounds = (lower: paddleBottomOffset - (paddleSize.height / 2),
				   upper: paddleBottomOffset + (paddleSize.height / 2))
	return ballPosition.x >= xBounds.lower &&
	ballPosition.x <= xBounds.upper &&
	ballPosition.y + ballRadius >= yBounds.lower &&
	ballPosition.y - ballRadius <= yBounds.upper
}

//0xProto
//adwaita
//blex
//cask
//feature
//jet
//mdio
//pita
