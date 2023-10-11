import UIKit
//MARK: - Actor for race condition  (swift 15+)
actor Fresher{
    var salary = 10000
    func badega(){
        salary = salary*3
        print("Congrats abhi teri jindagi \(salary) ki hogai")
    }
    func nhiBada(){
        print("1 mahina aur ruk")
    }
}

class NayeNamune {
    var namuna = Fresher()
    func pagar() async -> Int{
        print("\(await namuna.salary)")
        return await namuna.salary
    }
    func khushi() async{
        await namuna.badega()
    }
    func intezar() async -> Int{
        print("\(await namuna.salary)")
        return await namuna.salary
    }
}

let aditya = NayeNamune()
let queue = DispatchQueue(label: "ok", attributes: .concurrent)
queue.async {
    Task{
        print("1")
        await aditya.pagar()
        await aditya.khushi()
        await aditya.intezar()
        await aditya.pagar()
        await aditya.khushi()
        await aditya.intezar()
        await aditya.pagar()
        await aditya.khushi()
        await aditya.intezar()
        await aditya.pagar()
        await aditya.khushi()
        await aditya.intezar()
    }
}
queue.async {
    Task{
        print("2")
        await aditya.pagar()
    }
    Task{
        print("3")
        await aditya.khushi()
        await aditya.intezar()
    }
}
