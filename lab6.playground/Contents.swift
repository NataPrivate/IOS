import Foundation

typealias Chessman = [String:(alpha:Character,num:Int)?]; //шахова фігура
let figuresNames = ["Белая королева", "Белый король", "Черный ферзь", "Белый конь", "Черная ладья"]
var chessmans: Chessman = [
    figuresNames[0]: (alpha: "A", num: 4),
    figuresNames[1]: (alpha: "G", num: 4),
    figuresNames[2]: (alpha: "A", num: 0),
    figuresNames[3]: (alpha: "E", num: 7),
    figuresNames[4]: nil
]

func chessAnalizer(_ figures: Chessman) {
    var i = 0
	for (figureName, coordinates) in figures {
	        i += 1
			if coordinates != nil {
					print("\(i). \(figureName) на \(coordinates!.alpha)\(coordinates!.num)")
			}
			else {
					print("\(i). \(figureName) отсутствует на поле..")
			}
	}
}

func changeFigure(figures: inout Chessman, figureName: String, coordinates : (alpha:Character,num:Int)?) {
	figures[figureName] = coordinates
}

chessAnalizer(chessmans)
changeFigure(figures : &chessmans, figureName : figuresNames[3], coordinates : nil)
changeFigure(figures : &chessmans, figureName : "Черная королева", coordinates : (alpha: "B", num: 1))
print("---------------")
chessAnalizer(chessmans)
