import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
// Create an OperationQueue
let operationQueue = OperationQueue()

// Create custom Operation instances
let operation1 = BlockOperation {
    for i in 1...10{
        print("Operation 1")
    }
}

let operation2 = BlockOperation {
    for i in 1...10{
        print("Operation 2")
    }
}

operation1.addDependency(operation2)

// Add operations to the queue
operationQueue.addOperation(operation1)
operationQueue.addOperation(operation2)
// Wait for all operations in the queue to finish
operationQueue.waitUntilAllOperationsAreFinished()
print("All operations are finished")
