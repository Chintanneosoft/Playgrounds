// Grand Central Dispatch (GCD):
// low-level API for managing concurrent operations

// Dispatch queues:
// submit units of work to this queue, and GCD executes them in a FIFO
// these are thread-safe meaning you can simultaneously access them from multiple threads

// Concurrency:
// single-core devices achieve concurrency through a method called time-slicing. They run one thread, perform a context switch, then run another thread.
// multi-core devices, on the other hand, execute multiple threads at the same time via parallelism.

// Queues:
// serial - only one task runs at any given time
// concurrent - allow multiple tasks to run at the same time

// GCD Queues:
// 1. Main queue - runs on the main thread & is a serial queue
// 2. Global queues - concurrent queues (high, default, low, background)
// 3. Custom serial queues - perform background work serially

// When sending tasks to the global concurrent queues,
// you don’t specify the priority directly
// instead, you specify a quality of service (QoS) class property
// this indicates the task’s importance and guides GCD in determining the priority to give to the task

// Qos classes:
// 1. User-interactive - use it for UI updates
//                       should run on the main thread
// 2. User-initiated - use for tasks required to continue user interaction
//                     run on the high-priority global queue
// 3. Utility - use in long-running tasks (computations, continuous data feeds)
//              run on the low-priority global queue
// 4. Background - use in tasks that don't require user interaction & aren't time sensitive
//                 run on the background-priority global queue

// Synchronous:
// returns control to the caller after the task completes
// you can schedule a unit of work synchronously by calling DispatchQueue.sync(execute: )

// Asynchronous:
// returns immediately, ordering the task to start but not waiting for it to complete
// thus, doesn’t block the current thread of execution from proceeding to the next function
// eg., network-based or CPU-intensive tasks
// you can schedule a unit of work asynchronously by calling DispatchQueue.async(execute: )

// Dispatch Barriers:
// a group of functions acting as a serial-style bottleneck when working with concurrent queues
// the queue acts just like a normal concurrent queue, but when the barrier is executing, it essentially acts as a serial queue
// after the barrier finishes, the queue goes back to being a normal concurrent queue

// Dispatch Groups:
// you can group together multiple tasks
// allows you to wait for a collection of tasks to complete before proceeding to the next step

// Dispatch queues manage the execution of tasks, while
// Dispatch groups provide a way to synchronize and track the completion of multiple tasks

import Dispatch



// Global queue

DispatchQueue.global().sync { }
DispatchQueue.global().async { }



// Creating own queue

let myqueue = DispatchQueue(label: "my queue")
myqueue.sync { }
myqueue.async { }

// Creating work item

class Service {
    private var pendingWorkItem: DispatchWorkItem?
    let queue = DispatchQueue(label: "queue")
    func doSomething() {
        pendingWorkItem?.cancel()
        let newWorkItem = DispatchWorkItem { }
        pendingWorkItem = newWorkItem
        queue.async(execute: newWorkItem)
    }
}



// Batching tasks

// wait for two tasks:

let queue1 = DispatchQueue(label: "queue")
let group1 = DispatchGroup()
print ("Initiating tasks")
queue1.async(group: group1) {
    sleep(1)
    print ("Task 1 done")
}
queue1.async(group: group1) {
    sleep(2)
    print ("Task 2 done")
}
group1.wait()
print ("All tasks done")

// non-blocking waiting:

let queue2 = DispatchQueue(label: "queue")
let group2 = DispatchGroup()
group2.enter()
queue2.async {
    sleep(1)
    print ("Task 1 done")
    group2.leave()
}
group2.enter()
queue2.async {
    sleep(2)
    print ("Task 2 done")
    group2.leave()
}
group2.notify(queue: queue2) {
    print ("All tasks done")
}
print ("Again, Initiating tasks")



// Avoiding Thread Explosion

let queue3 = DispatchQueue(label: "queue", attributes: .concurrent)
DispatchQueue.main.sync {
    queue3.sync {
        print("Done")
    }
}
// main.sync ko thread assign hua
// queue.sync ko thread chahiye (ruka)
// main.sync ka kaam queue.sync pe depend h jo ruka h (ruka)
// NOTE: main sync ke andar sync matlab dono ek dusre ke liye rukenge i.e., deadlock



// Limiting Work in Progress

let queue4 = DispatchQueue(label: "queue", attributes: .concurrent)
let sema = DispatchSemaphore(value: 3)   // limit a queue to 3 concurrent tasks
for i in 1...12 {
    queue4.async {
        print (i)
        sleep(5)
        sema.signal()   // free hogya i.e, increament
    }
    sema.wait()   // busy hogya i.e, decreament
}



// Parallel Execution

DispatchQueue.global().async {
    DispatchQueue.concurrentPerform(iterations: 1000) { index in
        // do something
    }
}
// it must be called on a specific queue not to accidently block the main one



// Understand the sequence

// Example 1

DispatchQueue.global(qos: .userInitiated).async {
    var overlayImage = 0
    DispatchQueue.main.async {
        overlayImage = 8686
    }
    overlayImage = {
       return 68
    }()
    print(overlayImage)
    sleep(5)
    print(overlayImage)
}

// Example 2

for i in 1...5 {
    if i==2 {
        rundispatch()
    }
    sleep(4)
    print("i", i)
}
func rundispatch() {
    DispatchQueue.global().async {
        for j in 5...10 {
            print("j", j)
        }
        DispatchQueue.main.async {
            print("NIKAL gaya dispatch")
        }
    }
    print("Bahar")
}
