import Foundation

let arr = (1...10).map( {_ in Int.random(in: -100...100)} )
print(arr)

// avg of 2-elements
var sumOfEven = 0
var countOfEven = 0

for i in arr {
    if (i % 2 == 0 && i != 0) {
        sumOfEven += i
        countOfEven += 1
    }
}

if (countOfEven > 0) {
    print("Avg of even: \(sumOfEven / countOfEven)")
}
else {
    print("No even elements")
}

// minimal positive
var minimalPositive : Int?
var minimalPositiveIndex : Int?

for i in 0..<arr.count {
    if (arr[i] > 0 && (minimalPositive == nil || arr[i] < minimalPositive!)) {
        minimalPositive = arr[i]
        minimalPositiveIndex = i
    }
}
if let value = minimalPositive {
		print("Minimal positive + position = \(value + minimalPositiveIndex!)")
}
else {
		print("No positive elements")
}

// |max_neg| * |min_even|
var maximumNegative = 0
var hasNegative = false
var minEven = 0
var hasEven = false

for i in arr {
    if (i < 0 && (i > maximumNegative || !hasNegative)) {
        maximumNegative = i
        hasNegative = true
    }
    
    if (i % 2 == 0 && (i < minEven || !hasEven)) {
        minEven = i
        hasEven = true
    }
}

if (hasNegative && hasEven) {
    print("|max_neg| * |min_even| = \(abs(maximumNegative) * abs(minEven))")
}
else {
    print("No even or negative")
}
