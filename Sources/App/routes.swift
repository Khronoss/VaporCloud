import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
	router.group("sandbox", configure: sandboxRoutes)

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}

private func sandboxRoutes(_ router: Router) {
	let sandboxController = SandboxController()
	router.get("hello", use: sandboxController.greet)
	router.get("helloName", use: sandboxController.delayedGreet)
	
	router.get { req in
		"Sandbox routes"
	}
}
