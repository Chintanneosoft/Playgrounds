
import Foundation

// Dispatch Groups -> Concurrent Execution

let dispatchGroup = DispatchGroup()
let queue = DispatchQueue.global(qos: .background)

dispatchGroup.enter()
queue.async {
    for i in 1...5 {
        print ("Task 1: \(i)")
    }
}
dispatchGroup.leave()

dispatchGroup.enter()
queue.async {
    for i in 6...10 {
        print ("Task 2: \(i)")
    }
}
dispatchGroup.leave()

dispatchGroup.notify(queue: .main) {
    print ("chal bata ab aage kya karna h\n")
}

// Nested Closures -> Serial Execution

func callApiA(completion: @escaping (String)->(Void)) {
    DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1), execute: {
        completion("data from service A")
    })
}

func callApiB(completion: @escaping (String)->(Void)) {
    DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1), execute: {
        completion("data from service B")
    })
}

func callApiC(completion: @escaping (String)->(Void)) {
    DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1), execute: {
        completion("data from service C")
    })
}

callApiA { (responseFromA) in
    callApiB { (responseFromB) in
        callApiC { (responseFromC) in
            print (responseFromA)
            print (responseFromB)
            print (responseFromC)
        }
    }
}
