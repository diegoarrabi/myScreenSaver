//
//  AppDelegate.swift
//  myScreenSaverPreview
//
//  Created by Diego Ibarra on 7/1/25.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
	
	@IBOutlet var window: NSWindow!
	
	var screenSaverView: myScreenSaverView?
	let displaySize = NSScreen.main?.frame.size
	let previewSizeRatio = CGFloat(1)
	let previewOrigin = CGPoint(x: 0, y: 0)
	
	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		return true
	}
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		
		let desiredScreenSize = SizeMultiplier(Size: displaySize!, Multiplier: previewSizeRatio)
		window.setFrame(CGRect(origin: previewOrigin, size: desiredScreenSize), display: true)
		window.delegate = self
		window.aspectRatio = desiredScreenSize
		
		guard let screenSaverView = window.contentView as? myScreenSaverView
		else { fatalError("[AppDelegate] - Could not cast window's contentView as a MainView") }
		
		let timer = Timer.scheduledTimer(
			timeInterval: screenSaverView.animationTimeInterval,
			target: screenSaverView,
			selector: #selector(screenSaverView.animateOneFrame),
			userInfo: nil,
			repeats: true
		)
		timer.fire()
		screenSaverView.timeView.resizeFont(for: screenSaverView.bounds.size)
	}
}

extension AppDelegate: NSWindowDelegate {
	func windowDidResize(_ notification: Notification) {
		guard let screenSaverView = window.contentView as? myScreenSaverView
		else { fatalError("could not cast window's contentView as a MainView") }
		screenSaverView.timeView.resizeFont(for: screenSaverView.bounds.size)
	}
}

func SizeMultiplier(Size size: CGSize, Multiplier multiplier: CGFloat) -> CGSize {
	var newSize: CGSize = CGSize(width: 0, height: 0)
	newSize.width = size.width * multiplier
	newSize.height = size.height * multiplier
	return newSize
}
