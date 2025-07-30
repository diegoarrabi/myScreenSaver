//
//  Settings.swift
//  myScreenSaver
//
//  Created by Diego Ibarra on 7/1/25.
//

import AppKit
import ScreenSaver

class ScreenSaverSettings {
	
	@MainActor static let shared = ScreenSaverSettings()
	
	let font: NSFont = NSFont(name: "CatV_6x12_9", size: 0) ?? .systemFont(ofSize: 0)

//	let font: NSFont = NSFont(name: "FeatureMono-Light", size: 0) ?? .systemFont(ofSize: 0)
//	let font: NSFont = NSFont(name: "FeatureMono-Medium", size: 0) ?? .systemFont(ofSize: 0)
//	let font: NSFont = NSFont(name: "FeatureMono-Regular", size: 0) ?? .systemFont(ofSize: 0)
//	let font: NSFont = NSFont(name: "MartianMono-SemiExpandedRegular", size: 0) ?? .systemFont(ofSize: 0)
//	let font: NSFont = NSFont(name: "PitagonSansMono-ExtraLight", size: 0) ?? .systemFont(ofSize: 0)
//	let font: NSFont = NSFont(name: "PitagonSansMono-Light", size: 0) ?? .systemFont(ofSize: 0)
//	let font: NSFont = NSFont(name: "PitagonSansMono-Medium", size: 0) ?? .systemFont(ofSize: 0)
//	let font: NSFont = NSFont(name: "PitagonSansMono-Regular", size: 0) ?? .systemFont(ofSize: 0)
//	let font: NSFont = NSFont(name: "PitagonSansMono-SemiBold", size: 0) ?? .systemFont(ofSize: 0)
//	let font: NSFont = NSFont(name: "PitagonSansMono-Thin", size: 0) ?? .systemFont(ofSize: 0)
//	let font: NSFont = NSFont(name: "RaMonoRegular", size: 0) ?? .systemFont(ofSize: 0)
//	let font: NSFont = NSFont(name: "SpaceMonoNFM-Bold", size: 0) ?? .systemFont(ofSize: 0)
//	let font: NSFont = NSFont(name: "SpaceMonoNFM", size: 0) ?? .systemFont(ofSize: 0)
//	let font: NSFont = NSFont(name: "Unibody8Pro-Regular", size: 0) ?? .systemFont(ofSize: 0)
//	let font: NSFont = NSFont(name: "VCROSDMono", size: 0) ?? .systemFont(ofSize: 0)

	
	
	let animationFPS: Double = 0.06
	let fontColor = NSColor(red: 0.56, green: 0.64, blue: 0.68, alpha: 1.00)
	let dateFormatEven: String = "HH:mm:ss"
	let dateFormatOdd: String = "HH mm ss"
	let colorFadeDuration: Double = 0.5
	let backgroundColor: NSColor = .black

	private init() {}
		
}
