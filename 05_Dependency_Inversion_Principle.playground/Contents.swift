
// Dependency Inversion Principle
// - high-level modules should not depend on low-level modules

struct Order {
    let amount: Double
    let description: String
    let tax: Double
    let createdBy: String
}

// BEFORE:

// low-level class
class OrderDatabaseOperations {
    func saveOrderToDatabase(order: Order) {
        // save orders to database
    }
}

// high-level class
class Handler {
    private let orderDatabaseOperation: OrderDatabaseOperations
    init(database: OrderDatabaseOperations) {
        orderDatabaseOperation = database
    }
    func saveOrder(order: Order) {
        orderDatabaseOperation.saveOrderToDatabase(order: order)
    }
}

let handlerObj = Handler(database: OrderDatabaseOperations())
handlerObj.saveOrder(order: Order(amount: 300, description: "Order description", tax: 2, createdBy: "aditya423"))

// now if i want to save order to API and not to Database
// create new low-level class and make object of it in Handler
// note we have make change in Handler means it's dependent on low-level class

// AFTER:

protocol OrderStorage {
    func saveOrder(order: Order)
}

// low-level class
class NewOrderDatabaseOperations: OrderStorage {
    func saveOrder(order: Order) {
        // save orders to database
    }
}

// new low-level class
class NewOrderAPIOperations: OrderStorage {
    func saveOrder(order: Order) {
        // save orders to API
    }
}

// high-level class
class NewHandler {
    private let orderStorage: OrderStorage
    init(data: OrderStorage) {
        orderStorage = data
    }
    func saveOrder(order: Order) {
        orderStorage.saveOrder(order: order)
    }
}

let newHandlerObj = NewHandler(data: NewOrderDatabaseOperations())
newHandlerObj.saveOrder(order: Order(amount: 300, description: "Order description", tax: 2, createdBy: "aditya423"))
let newHandlerObj2 = NewHandler(data: NewOrderAPIOperations())
newHandlerObj2.saveOrder(order: Order(amount: 300, description: "Order description", tax: 2, createdBy: "aditya423"))

// create new low-level class, but no need to make any change in Handler
// just need to make object of protocol type and now Handler is independent on low-level class
