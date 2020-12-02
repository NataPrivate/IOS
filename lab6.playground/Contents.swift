import Foundation

typealias Chessman = [String:(alpha:Character,num:Int)?]; //шахова фігура
let figuresNames = ["Белая королева", "Белый король", "Черный ферзь", "Белый конь", "Черная ладья"]
let chessmans: Chessman = [
    figuresNames[0]: (alpha: "A", num: 4),
    figuresNames[1]: (alpha: "G", num: 4),
    figuresNames[2]: (alpha: "A", num: 0),
    figuresNames[3]: (alpha: "E", num: 7),
    figuresNames[4]: nil
]

for figureName in figuresNames {
    if let coordinates = chessmans[figureName] ?? nil {
        print("\(figureName): \(coordinates)")
    }
    else {
        print("\(figureName) отсутствует на поле..")
    }
}
