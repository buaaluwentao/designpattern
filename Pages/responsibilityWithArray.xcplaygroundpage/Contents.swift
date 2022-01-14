//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

class Request {
    func context() -> String {
        return "Request"
    }
}

class LogHelper {
    func log(logStr: String) {}
}

protocol HandlerProtocol {
    func handle(request: Request) -> Bool
}

class HandlerA: HandlerProtocol {
    func handle(request: Request) -> Bool {
        return false
    }
}

class HandlerB: HandlerProtocol {
    func handle(request: Request) -> Bool {
        return false
    }
}

//数组实现的HandlerChain
class HandlerChain {
    private var handlers: [HandlerProtocol]
    private let logHelper: LogHelper
    
    init(logHelper: LogHelper) {
        self.handlers = [HandlerProtocol]()
        self.logHelper = logHelper
    }
    
    func addHandler(handler: HandlerProtocol) {
        self.handlers.append(handler)
    }
    
    func handle(request: Request) {
        for handler in self.handlers {
            self.logHelper.log(logStr: request.context())
            if handler.handle(request: request) {
                return
            }
        }
    }
}


