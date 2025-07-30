//
//  MyLog.swift
//  myScreenSaver
//
//  Created by Diego Ibarra on 7/30/25.
//

import OSLog

struct MyLogger {
	

	func log(message: Any, description: String? = nil) {
		let prefix: String
		if let description = description {
			prefix = "msg: [\(description)]"
		} else {
			prefix = "msg"
		}
		let msg = "\(prefix): \(String(describing: message))"
		os_log("%{public}@", msg)
	}
}
