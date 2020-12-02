import Foundation

let matrixSize = 5
var matrix = [[Int]]()

for _ in 1...matrixSize {
    matrix.append((1...matrixSize).map( {_ in Int.random(in: 0...4)}))
}

for i in 0..<matrixSize {
    print(matrix[i])
}


var onlyEvenElementRows = [Int]()
var onlyMonotoneSequenceRows = [Int]()

for i in 0..<matrixSize {
    let arr = matrix[i]
    var isAsc = true
    var isDesc = true
    var allEven = true
    
    // Only even
    for j in arr {
        if (j % 2 != 0) {
            allEven = false
            break
        }
    }
    
    // Ascending
    for j in 1..<matrixSize {
        if (arr[j] > arr[j-1]) {
            isAsc = false
            break
        }
    }
    
    // Descending
    for j in 1..<matrixSize {
        if (arr[j] < arr[j-1]) {
            isDesc = false
            break
        }
    }
    
    if (allEven) {
        onlyEvenElementRows.append(i)
    }
    
    if (isAsc || isDesc) {
        onlyMonotoneSequenceRows.append(i)
    }
}

print("\nOnly even: \(onlyEvenElementRows)")
print("\nOnly monotone: \(onlyMonotoneSequenceRows)")
