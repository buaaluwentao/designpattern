//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

public class AlertRule {
    public let maxTps = 100000
    public let maxErrorCounter = 10000
    private let instance = AlertRule()
    
    public func getMatchedRule(_ api: String) -> AlertRule {
        return self.instance
    }
}
public class Notification {
    public func notify(message: String) -> Void {
        
    }
}

public class Alert {
    private let alertRule: AlertRule
    private let notification: Notification
    
    init(alertRule: AlertRule, notification: Notification) {
        self.alertRule = alertRule
        self.notification = notification
    }
    
    public func check(api: String,
                      requestCount: Int,
                      errorCount: Int,
                      durationOfSeconds: Int,
                      timeoutCount: Int) {
        let tps = requestCount / durationOfSeconds
        if tps > self.alertRule.getMatchedRule(api).maxTps {
            self.notification.notify(message: "...")
        }
        
        if errorCount > self.alertRule.getMatchedRule(api).maxErrorCounter {
            self.notification.notify(message: "...")
        }
        
        //处理接口超时
        //...
    }
}
