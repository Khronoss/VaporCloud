//
//  SandboxController.swift
//  App
//
//  Created by Anthony Merle on 01/03/2020.
//

import Vapor

final class SandboxController {
	func greet(_ req: Request) -> String {
		"Hello friend!"
	}
	
	func delayedGreet(_ req: Request) -> Future<String> {
		let promise = req.eventLoop.newPromise(of: String.self)

		do {
			let name = try req.query.get(String.self, at: "name")
			DispatchQueue.global()
				.asyncAfter(deadline: .now() + .seconds(2)) {
					promise.succeed(result: "Hello, \(name)!")
			}
		} catch {
			promise.fail(error: error)
		}
		
		return promise.futureResult
	}
}
