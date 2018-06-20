import Foundation

// MARK: - Extensions

extension Int {
    var array: [Int] {
        return String(self).compactMap{ Int(String($0)) }
    }
}

// 2 for loops where multiplication is done only for 1 digit numbers
func schoolIntegerMultiplication(of x: Int, and y: Int) -> Int {
    var result = 0

    let xArray = x.array
    let yArray = y.array

    let xArrayReversed = xArray.reversed()
    let yArrayReversed = yArray.reversed()

    for (yIndex, yNumber) in yArrayReversed.enumerated() {

        var xIterationResult = 0
        for (xIndex, xNumber) in xArrayReversed.enumerated() {
            let tenPowered = Int(truncating: NSDecimalNumber(decimal: pow(10, xIndex)))
            let newNumber = xNumber * yNumber * tenPowered
            xIterationResult += newNumber
        }

        let tenPowered = Int(truncating: NSDecimalNumber(decimal: pow(10, yIndex)))
        let newNumber = xIterationResult * tenPowered

        result += newNumber
    }

    return result
}

// Test Version where only 1 for loop presented
func schoolIntegerMultiplication1(of x: Int, and y: Int) -> Int {
    var result = 0

    let yArray = y.array

    let yArrayReversed = yArray.reversed()

    for (index, yNumber) in yArrayReversed.enumerated() {
        let tenPowered = NSDecimalNumber(decimal: pow(10, index))
        let newNumber = yNumber * x * Int(truncating: tenPowered)
        result += newNumber
    }

    return result
}

// MARK: - Tests

func testMultiplication(x: Int, y: Int) {
    let exptectedResult = x * y
    if exptectedResult == schoolIntegerMultiplication(of: x, and: y) {
        print("success 🤑")
    } else {
        print("wrong result 😵")
    }

    if exptectedResult == schoolIntegerMultiplication1(of: x, and: y) {
        print("success 🤑")
    } else {
        print("wrong result 😵")
    }
}

func runAllTests() {
    testMultiplication(x: 1, y: 44)
    testMultiplication(x: 5, y: 43)
    testMultiplication(x: 213, y: 234)
    testMultiplication(x: 824577, y: 432423)
    testMultiplication(x: 3, y: 99348848)
    testMultiplication(x: 353, y: 1231)
    testMultiplication(x: 85775, y: 3378)
    testMultiplication(x: 34748342380, y: 238472829)
}

runAllTests()
