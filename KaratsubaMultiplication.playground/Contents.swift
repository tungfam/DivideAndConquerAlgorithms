import Foundation

extension Int {
    var array: [Int] {
        return String(self).compactMap{ Int(String($0)) }
    }

    var isEven: Bool {
        return self % 2 == 0
    }
}

extension String {
    subscript (i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

extension Double {
    var array: [Int] {
        return String(self).compactMap{ Int(String($0)) }
    }
}

var array = [5, 6, 7, 8]
array.prefix(upTo: 2)
array.prefix(through: 2)
array.suffix(from: 2)

func power(of number: Int, times: Int) -> Int {
    let powerOfNumber = pow(Double(number), Double(times))
    return Int(truncating: NSDecimalNumber(decimal: Decimal(powerOfNumber)))
}

func addZeros(to number: String, times: Int) -> String {
    var result = number
    for _ in 0..<times {
        result.append("0")
    }
    return result
}

func sum(string1: String, string2: String) -> String {
    let str1Count = string1.count
    let str2Count = string2.count

    let upperStr: String
    let downStr: String
    let upperCount: Int
    let downCount: Int
    if str1Count > str2Count {
        upperStr = string1
        upperCount = str1Count
        downStr = string2
        downCount = str2Count
    } else {
        upperStr = string2
        upperCount = str2Count
        downStr = string1
        downCount = str1Count
    }

    var result = ""
    var carryOverValue: Int?
    let upperReversed = String(upperStr.reversed())
    let downReversed = String(downStr.reversed())
    for i in 0..<downCount {
        let up = Int(upperReversed[i])!
        let down = Int(downReversed[i])!
        let sum = up + down + (carryOverValue ?? 0)

        if sum >= 10 {
            carryOverValue = 1
            let sumTail = sum % 10
            let strTail = String(sumTail)
            result.insert(Character(strTail), at: result.startIndex)
        } else {
            carryOverValue = nil
            let strSum = String(sum)
            result.insert(Character(strSum), at: result.startIndex)
        }
    }

    if upperCount > downCount {
        let diff = upperCount - downCount
        let startSubstring = upperStr.prefix(upTo: upperStr.index(upperStr.startIndex,
                                                                  offsetBy: diff))
        let startString = String(startSubstring)
        if let carryOverValue = carryOverValue {
            let finalStartString = sum(string1: startString, string2: String(carryOverValue))
            result = finalStartString + result
        } else {
            result = startString + result
        }
    } else { // they are equal
        if let carryOverValue = carryOverValue {
            let firstNumberString = String(carryOverValue)
//            print(firstNumberString)
            result.insert(Character(firstNumberString), at: result.startIndex)
        }
    }

    return result
}

func testStringSum(string1: String, string2: String) {
    let test = sum(string1: string1, string2: string2)
    let expected = String(Int(string1)! + Int(string2)!)
    if test == expected {
        print("yes")
    } else {
        print("no")
        print("expe: \(expected)")
        print("test: \(test)")
    }
}

//testStringSum(string1: "123132123", string2: "34234222")
//testStringSum(string1: "32123", string2: "34234222")
//testStringSum(string1: "34504", string2: "3423422234698602")
//testStringSum(string1:   "969684",
//              string2: "34234222")
//testStringSum(string1: "34504", string2: "99999999")
//testStringSum(string1: "99999999", string2: "99999999")
//testStringSum(string1: "1999999991", string2: "999999990")
//testStringSum(string1: "9999499999991", string2: "999999990")
//testStringSum(string1: "99999999999234", string2: "99999999")
//testStringSum(string1: "9995499999999234", string2: "319923999999")
//testStringSum(string1: "99999999999223434", string2: "9999934999")
//testStringSum(string1: "99999999999234", string2: "99999923499")
//testStringSum(string1: "99999999999234", string2: "99999243999")
//testStringSum(string1: "99999324999999234", string2: "99923499999")
//testStringSum(string1: "123123", string2: "132")
//testStringSum(string1: "11", string2: "99923499999")
//testStringSum(string1: "555599", string2: "5")
//testStringSum(string1: "4", string2: "2")
//testStringSum(string1: "1313", string2: "24")

func arrayToInteger(array: [Int]) -> Int {
    return array.reduce(0) { (result, nextNumber) -> Int in
        return result * 10 + nextNumber
    }
}

func splitIntoTwoParts(number: Int) -> (Int, Int) {
    let numbersArray = number.array
    let count = numbersArray.count
    if count.isEven {
        let half = count / 2

        let firstPartArray = numbersArray.prefix(upTo: half)
        let secondPartArray = numbersArray.suffix(from: half)

        let firstPartInt = arrayToInteger(array: Array(firstPartArray))
        let secondPartInt = arrayToInteger(array: Array(secondPartArray))
//        print(firstPartArray)
//        print(secondPartArray)

        return (firstPartInt, secondPartInt)
    } else {
        let half = count / 2
//        print("aaaaaa")
//        print(number)
//        print(count)
//        print(half)
//        print("aaaaaa")

        let firstPartArray = numbersArray.prefix(upTo: half + 1)
//        print(firstPartArray)
        let secondPartArray = numbersArray.suffix(from: half + 1)
//        print(secondPartArray)

        let firstPartInt = arrayToInteger(array: Array(firstPartArray))
        let secondPartInt = arrayToInteger(array: Array(secondPartArray))

//        print(firstPartInt)
//        print(secondPartInt)
        return (firstPartInt, secondPartInt)
    }
}

func splitIntoTwoPartsString(number: String) -> (String, String) {
    let midpoint = number.count / 2

    let firstHalf = number.prefix(upTo: number.index(number.startIndex, offsetBy: midpoint))
    let secondHalf = number.suffix(from: number.index(number.startIndex, offsetBy: midpoint))
    let first = String(firstHalf)
    let second = String(secondHalf)
    return (first, second)
}

let x = 1234
let y = 5678

func karatsubaMultiplication(of x: String, and y: String) -> String {

//    print("x: \(x)")
//    print("y: \(y)")

    let xArray = x
    let yArray = y

    if x.count <= 1 || y.count <= 1 {
        return String(Int(x)! * Int(y)!)
    }

    let maxCount = max(xArray.count, yArray.count)

    let n: Int
    let m: Int
    if maxCount.isEven {
        n = maxCount
        m = maxCount / 2
    } else {
        n = maxCount
        m = (maxCount / 2)
    }

    let partedX = splitIntoTwoPartsString(number: x)
    let a = partedX.0
    let b = partedX.1

    let partexY = splitIntoTwoPartsString(number: y)
    let c = partexY.0
    let d = partexY.1

    let ac = karatsubaMultiplication(of: a, and: c)
    let bd = karatsubaMultiplication(of: b, and: d)
//    let adPlusBc = karatsubaMultiplication(of: (a + b), and: (c + d)) - ac - bd
    let ad = karatsubaMultiplication(of: a, and: d)
    let bc = karatsubaMultiplication(of: b, and: c)
    let adPlusBc = sum(string1: ad, string2: bc) //ad + bc

//    let result = power(of: 10, times: m * 2) * ac + power(of: 10, times: m) * adPlusBc + bd
//    return result
    let first = addZeros(to: ac, times: m * 2)
    let second = addZeros(to: adPlusBc, times: m)
    let sumFirstSecond = sum(string1: first, string2: second)
    let result = sum(string1: sumFirstSecond, string2: bd)
    return result
    // x * y = 10^n*a*c + 10^(n/2)*(ad+bc) + bd
}

//func testKaratsubaMultiplication(x: Int, y: Int) {
//    let expectedValue = x * y
//    let testValue = karatsubaMultiplication(of: x, and: y)
//    if expectedValue == testValue {
//        print("--- success 🎉 ---")
//    } else {
//        print("🙅‍♀️ not equal. expected: \(expectedValue), but got \(testValue). x: \(x), y: \(y)")
//    }
//}

func testKaratsubaMultiplication(x: String, y: String) {
    let expectedValue = String(Int(x)! * Int(y)!)
    let testValue = karatsubaMultiplication(of: x, and: y)
    if expectedValue == testValue {
        print("--- success 🎉 ---")
    } else {
        print("🙅‍♀️ not equal. expected: \(expectedValue), but got \(testValue). x: \(x), y: \(y)")
    }
}

//testKaratsubaMultiplication(x: 1234, y: 1234)
//testKaratsubaMultiplication(x: 1234, y: 5678)
//testKaratsubaMultiplication(x: 33, y: 5678)
//testKaratsubaMultiplication(x: 584930, y: 425434)
//testKaratsubaMultiplication(x: 1234, y: 5678)
//testKaratsubaMultiplication(x: 1234, y: 5678)
//testKaratsubaMultiplication(x: 1234, y: 5678)
//testKaratsubaMultiplication(x: 1234, y: 5678)

//testKaratsubaMultiplication(x: "1234", y: "1234")
//testKaratsubaMultiplication(x: "1234", y: "5678")
//testKaratsubaMultiplication(x: "33", y: "5678")
//testKaratsubaMultiplication(x: "5849308531", y: "1342543434")
//testKaratsubaMultiplication(x: "58493084531", y: "13425434344")
//testKaratsubaMultiplication(x: "584930844531", y: "134425434344")
//testKaratsubaMultiplication(x: "5849308444531", y: "1344425434344")
//testKaratsubaMultiplication(x: "58493084445391", y: "13444254343414")
//testKaratsubaMultiplication(x: "584939084445391", y: "134442543434194")
//testKaratsubaMultiplication(x: "5849390844453941", y: "1349442543434194")
let test = karatsubaMultiplication(of: "3141592653589793238462643383279502884197169399375105820974944592",
                                   and: "2718281828459045235360287471352662497757247093699959574966967627")
let expected = "8539734222673567065463550869546574495034888535765114961879601127067743044893204848617875072216249073013374895871952806582723184"

if test == expected {
    print("YAY")
} else {
    print("no")
}
//testKaratsubaMultiplication(x: "1234555", y: "5555678")
//testKaratsubaMultiplication(x: "1234", y: "5678")
//testKaratsubaMultiplication(x: "1234", y: "5678")
//testKaratsubaMultiplication(x: "1234", y: "5678")

//let a = 3141592653589793238462643383279502884197169399375105820974944592.0
//print(a)
//print(String(a))
//print(a.array)

//let maxD = Double.greatestFiniteMagnitude
//print(String(maxD))
//print(maxI.bitWidth)

//let maxI = 9223372036854775807
//print(maxI)
//print(maxI.bitWidth)

//print("3141592653589793238462643383279502884197169399375105820974944592".count)

//print(Float.greatestFiniteMagnitude)

//let jj: Double = 0.1
//let ff: Double = 0.2
//let hh = jj + ff
//print(hh)
//let ii = 0.3
//print(hh == ii)
//print(ii)

//testKaratsubaMultiplication(x: 3141592653589793238462643383279502884197169399375105820974944592,
//                            y: 2718281828459045235360287471352662497757247093699959574966967627)

//testKaratsubaMultiplication(x: 46, y: 134)
//testKaratsubaMultiplication(x: 134, y: 46)
//testKaratsubaMultiplication(x: 6, y: 34)
//testKaratsubaMultiplication(x: 10, y: 35)
//testKaratsubaMultiplication(x: 10, y: 35)

//func testing(a: Int, b: Int) -> Int {
//    return 4 * power(of: 10, times: a) + 142 * power(of: 10, times: b) + 204
//}
//
//func testing2(a: Double, b: Double) -> Double {
//    let powB = pow(10, b)
//    let powA = pow(10, a)
//    return 4 * powA + 142 * powB + 204
//}
//
////testing2(a: 3, b: 1.1399677)
////testing2(a: 2.7867, b: 2.7867 / 2)
//
//func testing3(a: Double, b: Double) -> Double {
//    let powB = pow(10, b)
//    let powA = pow(10, a)
//    return 52 * powA + 94 * powB + 24
//}
//
//testing3(a: 2, b: 1)

//print(INTMAX_MAX)
//
//let aff: Int64 = 3141592653589793238462643383279502884197169399375105820974944592
//print(aff)
