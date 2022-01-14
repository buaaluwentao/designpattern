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
    var successor: HandlerProtocol? { get set }
    
    func doHandle(request: Request) -> Bool
}

extension HandlerProtocol {
    func handle(request: Request) -> Bool {
        if self.doHandle(request: request) {
            return true
        }
        
        if let successor = self.successor {
            successor.doHandle(request: request)
        }
        
        return false
    }
}

class HandlerA: HandlerProtocol {
    var successor: HandlerProtocol?
    
    func doHandle(request: Request) -> Bool {
        return false
    }
}

class HandlerB: HandlerProtocol {
    var successor: HandlerProtocol?
    
    func doHandle(request: Request) -> Bool {
        return false
    }
}

//基于链表和模版方法实现的HandlerChain
class HandlerChain {
    private var header: HandlerProtocol?
    private var tail: HandlerProtocol?
    
    private let logHelper: LogHelper
    
    init(logHelper: LogHelper) {
        self.logHelper = logHelper
    }
    
    func addHandler(handler: inout HandlerProtocol) {
        handler.successor = nil
        
        if self.header == nil {
            self.header = handler
            self.tail = handler
            return
        }
        
        self.tail?.successor = handler
        self.tail = handler
    }
    
    func handle(request: Request) {
        self.header?.handle(request: request)
    }
}
