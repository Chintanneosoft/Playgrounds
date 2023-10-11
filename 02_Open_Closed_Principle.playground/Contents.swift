
import Foundation

// Open/Closed Principle
// - open for extension, closed for modification
// - it should be easy to add new features to your class

// BEFORE:

class Rectangle {
    let width: Double
    let height: Double
    init(_width: Double, _height: Double) {
        width = _width
        height = _height
    }
    func calculateArea() -> Double {
        return width * height
    }
}

class Circle {
    let radius: Double
    init(_radius: Double) {
        radius = _radius
    }
    func calculateArea() -> Double {
        return Double.pi * pow(radius, 2)
    }
}

class AreaCalculator {
    func area(shape: Rectangle) -> Double {
        return shape.calculateArea()
    }
    func area(shape: Circle) -> Double {
        return shape.calculateArea()
    }
}

let areaCalculatorObj = AreaCalculator()
let rectangleObj = Rectangle(_width: 3, _height: 3)
print("Area = \(areaCalculatorObj.area(shape: rectangleObj))")
let circleObj = Circle(_radius: 3)
print("Area = \(areaCalculatorObj.area(shape: circleObj))")

// AFTER:

protocol Shape {
    func calculateArea() -> Double
}

class NewRectangle: Shape {
    let width: Double
    let height: Double
    init(_width: Double, _height: Double) {
        width = _width
        height = _height
    }
    func calculateArea() -> Double {
        return width * height
    }
}

class NewCircle: Shape {
    let radius: Double
    init(_radius: Double) {
        radius = _radius
    }
    func calculateArea() -> Double {
        return Double.pi * pow(radius, 2)
    }
}

class NewAreaCalculator {
    func area(shape: Shape) -> Double {
        return shape.calculateArea()
    }
}

let newAreaCalculatorObj = AreaCalculator()
let newRectangleObj = Rectangle(_width: 3, _height: 3)
print("Area = \(newAreaCalculatorObj.area(shape: newRectangleObj))")
let newCircleObj = Circle(_radius: 3)
print("Area = \(newAreaCalculatorObj.area(shape: newCircleObj))")
