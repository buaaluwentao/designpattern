import UIKit

protocol FTTotalStrategy {
    func totoal(orderList: [FTOrder]) -> Double
}

class FTNormalTotalStrategy: FTTotalStrategy {
    func totoal(orderList: [FTOrder]) -> Double {
        var sum = 0.0
        for order in orderList {
            sum += order.price
        }
        return sum
    }
}

class FTVipTotalStrategy: FTTotalStrategy {
    let discountPercent = 0.8
    func totoal(orderList: [FTOrder]) -> Double {
        var sum = 0.0
        for order in orderList {
            sum = sum + order.price
        }
        return discountPercent * sum
    }
}

class FTOrder {
    let orderId: Int
    let price: Double
    
    init(orderId: Int, price: Double) {
        self.orderId = orderId
        self.price = price
    }
}

class FTCustomer {
    enum FTCustomerType {
        case normal, vip
    }
    
    private var orderList: [FTOrder]
    private let type: FTCustomerType
    private let totalStrategy: FTTotalStrategy
    
    init(type: FTCustomerType, totalStrategy: FTTotalStrategy) {
        self.orderList = [FTOrder]()
        self.type = type
        self.totalStrategy = totalStrategy
    }
    
    init(type: FTCustomerType) {
        self.orderList = [FTOrder]()
        self.type = type
        self.totalStrategy =  FTOrderStrategyFactory.orderStrategy(customerType: type)
    }
    
    func addOrder(newOrder: FTOrder) {
        self.orderList.append(newOrder)
    }
    
    func total() -> Double {
        return self.totalStrategy.totoal(orderList: self.orderList)
    }
}

let customer1 = FTCustomer(type: .normal, totalStrategy: FTNormalTotalStrategy())

customer1.addOrder(newOrder: FTOrder(orderId: 1, price: 100))
customer1.addOrder(newOrder: FTOrder(orderId: 2, price: 50))

print("客户1总价：\(customer1.total())")

let customer2 = FTCustomer(type: .normal, totalStrategy: FTVipTotalStrategy())

customer2.addOrder(newOrder: FTOrder(orderId: 1, price: 100))
customer2.addOrder(newOrder: FTOrder(orderId: 2, price: 50))

print("客户2总价：\(customer2.total())")

class FTOrderStrategyFactory {
    private static let normalStrategy = FTNormalTotalStrategy()
    private static let vipStrategy = FTVipTotalStrategy()
    static func orderStrategy(customerType: FTCustomer.FTCustomerType) -> FTTotalStrategy {
        switch customerType {
        case .normal:
            return normalStrategy
        case .vip:
            return vipStrategy
        }
    }
}

let customer3 = FTCustomer(type: .normal)
customer3.addOrder(newOrder: FTOrder(orderId: 1, price: 100))
customer3.addOrder(newOrder: FTOrder(orderId: 2, price: 50))
print("客户3总价：\(customer3.total())")

