// Async-await:

// Use cases
// - calling APIs one after other in a specific order
// - response of one API is the input parameter of the other API
// - to perform asynchronous operations

// But to perform asynchronous operations there are many options available
// - DispatchQueue (GCD) - async operations
// - Nested closures - serial APIs call (simple)
// - Dispatch group - serial APIs call (advance)
// - Operation queue - serial APIs call (advance)

// Then why we are using it?
// problems in previous options
// - pyramid of boom
// - unknowingly creating strong references
// - error handling is difficult (using Result readability & maintainability kam hoga)

import Foundation



func fetchStudentScore() async -> [Double] {
    sleep(2)
    let scores = [89.23 , 68.13 , 98.24 , 73.06]
    print(1)
    return scores
}

func calculateAverageResult(for scores: [Double]) async -> Double {
    print(2)
    let total = scores.reduce(0, +)
    let average = total / Double(scores.count)
    return average
}

func uploadResult(result: Double) async -> Bool {
    print(3)
    let status = true
    return status
}

let scores = await fetchStudentScore()
print(scores)
let average = await calculateAverageResult(for: scores)
print(average)
let response = await uploadResult(result: average)
print("Server response: \(response)")



// NOTE: jab tak async function complete nahi ho jata tab tak await ke baad ka line run nahi hoga
//       Task used for async operations

