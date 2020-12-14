/*
Скласти процедуру, результатом роботи якої є дійсне значення,
якщо символ, заданий при звертанні до процедури, - буква, і
помилкове значення в іншому випадку. Обчислити,
використовуючи написану функцію, кількість букв і символів,
що не є буквами в заданому рядку
*/

// https://stackoverflow.com/questions/24502669/how-to-find-out-if-letter-is-alphanumeric-or-digit-in-swift
func checkIsAlphabetic(_ symbol : Character) -> Bool {
	return symbol.isLetter // swift 5
}

let testString = readLine()!
var notAlphabeticCount = 0
for symbol in testString {
	if !checkIsAlphabetic(symbol) {
		notAlphabeticCount += 1
	}
}
print("Кількість не букв у рядку: \(notAlphabeticCount)")
