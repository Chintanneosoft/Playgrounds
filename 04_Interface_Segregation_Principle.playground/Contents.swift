
// Interface Segregation Principle

// BEFORE:

protocol Humans {
    func goToWork()
    func buyAHouse()
    func eat()
    func sleep()
}

class Person: Humans {
    func goToWork() {
        print ("Go to work")
    }
    
    func buyAHouse() {
        print ("Buy a house")
    }
    
    func eat() {
        print ("Eat")
    }
    
    func sleep() {
        print("Sleep")
    }
}

class Lion: Humans {
    func goToWork() {
        print ("Lion doesn't go to work")
    }
    
    func buyAHouse() {
        print ("Lion doesn't buy a house")
    }
    
    func eat() {
        print ("Eat")
    }
    
    func sleep() {
        print ("Sleep")
    }
}

// AFTER:

protocol NewHumans {
    func goToWork()
    func buyAHouse()
    func eat()
    func sleep()
}

protocol NewAnimals {
    func eat()
    func sleep()
}

class NewPerson: NewHumans {
    func goToWork() {
        print ("Go to work")
    }
    
    func buyAHouse() {
        print ("Buy a house")
    }
    
    func eat() {
        print ("Eat")
    }
    
    func sleep() {
        print("Sleep")
    }
}

class NewLion: NewAnimals {
    func eat() {
        print ("Eat")
    }
    
    func sleep() {
        print ("Sleep")
    }
}
