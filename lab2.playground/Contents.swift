import UIKit

// ------

/* Example of difference between len - constant
 and var - variable */
let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0

currentLoginAttempt += 1
// maximumNumberOfLoginAttempts += 1 Will raise exception


// ------
let minValue = Int.min
let maxValue = Int.max
let pi = 3.14159


print(minValue)
print(maxValue)
print(pi)

// ------
let decimalInteger = 17
let binaryInteger = 0b10001 // 17 у двійковій нотації
let octalInteger = 0o21 // 17 у восмеричній нотації
let hexadecimalInteger = 0x11 // 17 у шістнацятеричній нотації


// ------
let http404Error = (404, "Not Found")
let (statusCode, statusMessage) = http404Error


// ------
let possibleNumber = "123"
let convertedNumber: Int? = Int(possibleNumber)

if convertedNumber != nil {
    print("convertedNumber contains some integer value.")
}

if let actualNumber = Int(possibleNumber) {
    print("\"\(possibleNumber)\" has an integer value of \(actualNumber)")
}
else {
    print("\"\(possibleNumber)\" could not be converted to an integer")
}

// ------
enum ValidationError: Error {
    case emptyName
}

func canThrowAnError() throws {
    print("generate error")
    throw ValidationError.emptyName
}

func onSuccess() {
    print("on success")
}

do {
    try canThrowAnError()
    onSuccess()
} catch {
    print("on success")
}

// ------
let enteredDoorCode = true
let passedRetinaScan = false

if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}

// ------
for index in 1...5 {
    print("\(index)")
}
