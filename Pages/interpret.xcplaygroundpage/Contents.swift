//: [Previous](@previous)

import Foundation

// key1 > 100 && key2 > 200 || key3 < 300

protocol Expression {
    func interpret(expressionDict: [String: Int]) -> Bool
}

enum ExpressionError : Error {
    case invilid
}

class GreaterExpression: Expression {
    private let left: String
    private let right: Int
    
    init(expression: String) {
        let expressionComponents = expression.split(separator: ">")
//        if expressionComponents.count != 2 {
//            throw ExpressionError.invilid
//        }
        
        self.left = String(expressionComponents[0])
        self.right = Int(expressionComponents[1]) ?? 0
    }
    
    func interpret(expressionDict: [String: Int]) -> Bool {
        return (expressionDict[self.left] ?? 0) > self.right
    }
}

class LessExpression: Expression {
    private let left: String
    private let right: Int
    
    init(expression: String) {
        let expressionComponents = expression.split(separator: "<")
//        if expressionComponents.count != 2 {
//            throw ExpressionError.invilid
//        }
        
        self.left = String(expressionComponents[0])
        self.right = Int(expressionComponents[1]) ?? 0
    }
    
    func interpret(expressionDict: [String: Int]) -> Bool {
        return (expressionDict[self.left] ?? 0) < self.right
    }
}

class AndExpression: Expression {
    private var expressionList: [Expression]
    
    init(expression: String) {
        self.expressionList = [Expression]()
        let expressionComponents = expression.split(separator: "&")
        for expression in expressionComponents {
            if String(expression).contains(where: { c in
                c == ">"
            }) {
                self.expressionList.append(GreaterExpression.init(expression: String(expression).trimmingCharacters(in: .whitespaces)))
            } else {
                self.expressionList.append(LessExpression.init(expression: String(expression).trimmingCharacters(in: .whitespaces)))
            }
        }
    }
    
    func interpret(expressionDict: [String : Int]) -> Bool {
        for expression in self.expressionList {
            if !expression.interpret(expressionDict: expressionDict) {
                return false
            }
        }
        return true
    }
}

class OrExpression: Expression {
    private var expressionList: [Expression]
    
    init(expression: String) {
        self.expressionList = [Expression]()
        
        let trimWhitespaceExp = expression.trimmingCharacters(in: .whitespaces)
        let expressionComponents = trimWhitespaceExp.split(separator: "|")
        for exp in expressionComponents {
            print(String(expression))
            self.expressionList.append(AndExpression(expression: String(exp)))
        }
    }
    
    func interpret(expressionDict: [String: Int]) -> Bool {
        for expression in self.expressionList {
            if expression.interpret(expressionDict: expressionDict) {
                return true
            }
        }
        
        return false
    }
}

class AlertRuleInterpret {
    private let expression: Expression
    
    init(expression: String) {
        self.expression = OrExpression(expression: expression)
    }
    
    func interpret(expressionDict: [String: Int]) -> Bool {
        return self.expression.interpret(expressionDict: expressionDict)
    }
}

let interpret = AlertRuleInterpret.init(expression: "key1 > 100 & key2 > 200 | key3 < 300")

print(interpret.interpret(expressionDict: ["key1": 101]))

//添加异常后该怎么处理哪？
