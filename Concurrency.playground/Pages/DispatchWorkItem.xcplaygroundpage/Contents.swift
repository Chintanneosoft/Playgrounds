
import Foundation

class Example {
    
    func myDispatchWorkItemExample() {
        var number = 15
        let workItem = DispatchWorkItem {
            number += 5
        }
        workItem.notify(queue: .main, execute: {
            print ("Increament number completed = \(number)")
        })
        let queue = DispatchQueue.global(qos: .utility)
        queue.async(execute: workItem)
    }
    
    func printNumbers() {
        var workItem: DispatchWorkItem?
        workItem = DispatchWorkItem {
            for i in 1...10 {
                guard let wkItem = workItem, !wkItem.isCancelled else {
                    print ("WorkItem is cancelled")
                    break
                }
                print (i)
                sleep(1)
            }
        }
        workItem?.notify(queue: .main, execute: {
            print ("Done printing numbers")
        })
        let queue = DispatchQueue.global(qos: .utility)
        queue.async(execute: workItem!)
        queue.asyncAfter(deadline: .now() + .seconds(3), execute: {
            workItem?.cancel()
        })
    }
}

let obj = Example()
obj.printNumbers()
