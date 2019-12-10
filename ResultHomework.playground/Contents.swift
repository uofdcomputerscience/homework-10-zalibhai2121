import Foundation

// Implement an Error type. Make sure it has at least two values.

enum Wrong: Error {
    case buffer
    case crowded
    case idontknowthis
}

// Implement a function that returns a Result of string or your error type

func thisFunctionCouldThrow() throws -> String {
    var foo = "foo"
    defer {
        print("inside the function: \(foo)")
    }
    throw Wrong.crowded
    foo = "another value"
    return foo
}

do {
    let thrownString = try thisFunctionCouldThrow()
    print(thrownString)
} catch {
    print("an error occurred: \(error)")
}

// Call your function in a way that will return an error result, and handle that error.
extension Wrong: LocalizedError {
    func errorDescription() -> String {
        return "This was an API error"
    }
}

func doesntDoTheRightThing() -> Error? {
    return Wrong.idontknowthis
}

let err = doesntDoTheRightThing()
if let err = err as? LocalizedError {
    print(err.errorDescription)
}

// Call your function in a way that will return a success result, and handle the value.

func getOrFail(value: Int) -> Result<String, Error> {
    if (value < 5) {
        return .success("foo")
    }
    return .failure(Wrong.crowded)
}

let result = getOrFail(value: 4)
switch result {
case .success(let string):
    print("string: \(string)")
case .failure(let error):
    print(error)
}
