//: Playground - noun: a place where people can play

import Foundation
import XCTest

extension Int {
    var array: [Int] {
        return String(self).compactMap{ Int(String($0)) }
    }
}

let x = 1234
let y = 5678
x * y
7*1234
6*1234
5*1234

// Version where only 1 for loop presented
func schoolIntegerMultiplication(of x: Int, and y: Int) -> Int {
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

x * y == schoolIntegerMultiplication(of: x, and: y)

// 2 for loops where multiplication is done only for 1 digit numbers
func schoolIntegerMultiplication2(of x: Int, and y: Int) -> Int {
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

x * y == schoolIntegerMultiplication2(of: x, and: y)
