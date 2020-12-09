import Foundation

print("Enter number of sets: ")
let numberOfSets = Int(readLine()!)!
var sets = [Set<String>]()


for i in 1...numberOfSets {
    print("Enter set \(i)")
    guard let inputDataSet = readLine() else { fatalError("Bad input") }
    let vals = inputDataSet.split(separator: " ").map{ String($0) }
    
    sets.append(Set<String>(vals))
}

print("Your input: ")
for s in sets {
    print(s)
}


func findIfSimilar(sets: [Set<String>]) -> Array<(x: Int, y: Int)> {
    var similar = [(x: Int, y: Int)]()
    
    for i in 0..<sets.count {
        for j in i+1..<sets.count {
            let isSimilar = sets[i] == sets[j]
            if !isSimilar {
                continue
            }
            
            if !similar.contains(where: {$0.x == j && $0.y == i}) {
                similar.append((x:i, y:j))
            }
        }
    }
    
    return similar;
}

func findIntersection(sets: [Set<String>]) -> Set<String> {
    var intersection = sets[0]
    
    for i in 1..<sets.count {
        intersection = intersection.intersection(sets[i])
    }
    
    return intersection
}

print("Similar pairs: \(findIfSimilar(sets: sets))")
print("Intersection: \(findIntersection(sets: sets))")
