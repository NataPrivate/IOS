// lab 8
// єдина функція формування результуючого масиву
func handle(wallet: [Int], closure: (Int) -> Bool) -> [Int]
{
	var returnWallet = [Int]()
	for banknot in wallet {
		if closure(banknot) {
			returnWallet.append(banknot)
		}
	}
	return returnWallet
} 

/*get rid of defining hundreds of functions*/
////////////////////////////////////////////////
// функція порівняння із числом 100
func compare100(banknot: Int) ->Bool {
	return banknot==100
} 
// функція порівняння із числом 1000
func compareMore1000(banknot:Int) -> Bool {
	return banknot>=1000
}
////////////////////////////////////////////////

var wallet = [10,50,200,100,5000,100,50,300,500,100]
// відбір купюр вартістю вище 200 гривень
handle(wallet: wallet, closure: {$0>=200})
// відбір купюр вартістю 100 гривень
handle(wallet: wallet, closure: {$0==100})


// приклад з сортуванням масиву
var array1 = [1,44,81,4,277,50,101,51,8]
var sortedArray = array1.sorted(by: {$0<$1})


// карування
func sum2(_ x: Int) -> (Int) -> Int {
	return { return $0+x }
}
sum2(5)(12) // поверне 17
var closure = sum2(1)
closure(12) // поверне 13
closure(19) // поверне 20


// автозамикання, ледачі обчислення
var arrayOfNames = ["Helga", "Bazil", "Alex"]
func printName(_ nextName: ()->String) {
	// який-небудь код
	print(nextName())
}
printName({arrayOfNames.remove(at: 0)})

arrayOfNames = ["Helga", "Bazil", "Alex"]
func printName2(_ nextName: @autoclosure ()->String) {
	// який-небудь код
	print(nextName())
}
printName2(arrayOfNames.remove(at: 0))



// lab 9
var array2 = [ 2, 4, 5, 7]
print("\(array2.map{$0*$0})")

var intArray = [1, 2, 3, 4]
print("\(array2.map{$0 > 2})")

let someArray = [[1, 2, 3, 4, 5], [11, 44, 1, 6], [16, 403, 321, 10]]
print("\(someArray.flatMap{$0.filter{ $0 % 2 == 0}})")

let milesToKm = ["Moscow":120.0, "Dubai":50.0, "Paris":70.0]
print("\(milesToKm.map {name, miles in [name:miles * 1.6093]})")


let cash = [10, 50, 100, 500]
let total = cash.reduce(210, +) // 870


let hrnToUsd = 0.036
let hrnToEuro = 0.029
func handle(wallet: [Int], convertCoef: Double, map: (Int, Double) -> Int, closure: (Int) -> Bool) -> [Int]
{
	var returnWallet = [Int]()
	for banknot in wallet {
		if closure(map(banknot, convertCoef)) {
			returnWallet.append(banknot)
		}
	}
	return returnWallet
} 
func convertToIntDown(_ sum: Int, coef: Double)-> Int 
{
    return Int((Double(sum) * coef).rounded(.down));
}
let usd10 = handle(wallet: wallet, convertCoef: hrnToUsd, map: {convertToIntDown($0, coef: $1)}, closure: {$0>=10})
print("Banknots more than 10 dollars in equivalent: \(usd10)")
let euro10 = handle(wallet: wallet, convertCoef: hrnToEuro, map: {convertToIntDown($0, coef: $1)}, closure: {$0>=10})
print("Banknots more than 10 euros in equivalent:\(euro10)")
