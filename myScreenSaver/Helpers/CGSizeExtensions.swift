//
//  AdjustSize.swift
//  myScreenSaver
//
//  Created by Diego Ibarra on 7/30/25.
//

import Foundation

import CoreGraphics

extension CGSize {
	func adjustSize(by xScale: CGFloat, yScale: CGFloat? = nil) -> CGSize {
		var xSize: Int
		var ySize: Int
				
		xSize = Int((width / xScale).rounded(.down))
		if (yScale != nil) {
			ySize = Int((height / yScale!).rounded(.down))
		} else {
			ySize = Int((height / xScale).rounded(.down))
		}
		
		if xSize % 2 != 0 {
			xSize -= 1
		}
		if ySize % 2 != 0 {
			ySize -= 1
		}
		
		return CGSize(width: xSize/2, height: ySize/2)
		
	}
}


