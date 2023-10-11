
import Foundation

// Single Responsibility Principle
// - one class should only have one responsibility

struct EmployeeModel {
    let Id: Int
    let name: String
    let address: String
}

// BEFORE:

class Employee {
    func getEmployeeData() -> Void {
        let employeeResponse = callEmployeeApi()
        let employeeDataArray = parseApiResponse(response: employeeResponse)
        saveDataToDatabase(data: employeeDataArray)
    }
    private func callEmployeeApi() -> Data {
        // call api to fetch data
        return Data()
    }
    private func parseApiResponse(response: Data) -> Array<EmployeeModel> {
        // parse the response received from the server
        return Array<EmployeeModel>()
    }
    private func saveDataToDatabase(data: Array<EmployeeModel>) {
        // save the data to database
    }
}

// AFTER:

class HttpHandler {
    func callEmployeeApi() -> Data {
        // call api to fetch data
        return Data()
    }
}

class Parser {
    func parseApiResponse(response: Data) -> Array<EmployeeModel> {
        // parse the response received from the server
        return Array<EmployeeModel>()
    }
}

class DatabaseHandler {
    func saveDataToDatabase(data: Array<EmployeeModel>) {
        // save the data to database
    }
}

class NewEmployee {
    let _httpHandler: HttpHandler
    let _parser: Parser
    let _databaseHandler: DatabaseHandler
    init(httpHandler: HttpHandler, parser: Parser, databaseHandler: DatabaseHandler) {
        _httpHandler = httpHandler
        _parser = parser
        _databaseHandler = databaseHandler
    }
    func getEmployeeData() -> Void {
        let employeeResponse = _httpHandler.callEmployeeApi()
        let employeeDataArray = _parser.parseApiResponse(response: employeeResponse)
        _databaseHandler.saveDataToDatabase(data: employeeDataArray)
    }
}

let employeeObj = NewEmployee(httpHandler: HttpHandler(), parser: Parser(), databaseHandler: DatabaseHandler())
