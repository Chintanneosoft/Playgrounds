
import Foundation

// Liskov Substitution Principle (LSP)
// - ability to be substituted with something else
// - this principle is a note of how you override methods
// - violation
//   - if a subclass overrides a method from its parent class and
//     changes its parameter list or return type or behaviour

// BEFORE:

// able to set length and width independently
class Rectangle {
    var width: Double = 0
    var length: Double = 0
    var area: Double {
        return width * length
    }
}

// changing width automatically changes length
class Square: Rectangle {
    override var width: Double {
        didSet {
            length = width
        }
    }
}

// this change in behavior means that a Square is not a true substitute for a Rectangle
// it breaks LSP

// AFTER:

protocol Shape {
    var area: Double { get }
}

class NewRectangle: Shape {
    var width: Double = 0
    var length: Double = 0
    var area: Double {
        return width * length
    }
}

class NewSquare: Shape {
    var width: Double = 0
    var area: Double {
        return pow(width, 2)
    }
}
