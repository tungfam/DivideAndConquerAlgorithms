
let unsortedArray = [14, 33, 27, 10, 35, 19, 42, 44]

func split(array: [Int]) -> ([Int], [Int]) {
    let midpoint = array.count / 2

    let firstHalf = Array(array[..<midpoint])
    let secondHalf = Array(array[midpoint...])

    return (firstHalf, secondHalf)
}

func merge(inputFirstArray: [Int], inputSecondArray: [Int]) -> [Int] {
    var first = inputFirstArray
    var second = inputSecondArray

    let totalCount = first.count + second.count

    var sortedArray = [Int]()

    for _ in 0...totalCount {
        if first.isEmpty {
            sortedArray.append(contentsOf: second)
            break
        } else if second.isEmpty {
            sortedArray.append(contentsOf: first)
            break
        }

        if first[0] <= second[0] {
            sortedArray.append(first[0])
            first.removeFirst()
        } else {
            sortedArray.append(second[0])
            second.removeFirst()
        }
    }

    return sortedArray
}

func mergeSorted(array: [Int]) -> [Int] {
    guard !array.isEmpty && array.count > 1
        else { return array }

    let splittedArrays = split(array: array)
    let firstHalf = splittedArrays.0
    let secondHalf = splittedArrays.1

    let sortedFirstHalf = mergeSorted(array: firstHalf)
    let sortedSecondHalf = mergeSorted(array: secondHalf)

    let mergedSortedArray = merge(inputFirstArray: sortedFirstHalf, inputSecondArray: sortedSecondHalf)

    return mergedSortedArray
}

func testMergeSort(array: [Int]) {
    print("----")
    let expected = array.sorted()
    let test = mergeSorted(array: array)

    if expected == test {
        print("success 🤩. sorted: \(test)")
    } else {
        print("""
            wrong ☹️:
            expected: \(expected)
            but got: \(test)
            """)
    }
    print("----")
}

testMergeSort(array: unsortedArray)
testMergeSort(array: [1])
testMergeSort(array: [1, 543, 23, 3,2 ,3, 224, 34,265,645,3,4232,4232,434,53,53,53,3,4221,23,24,3554,654,6345])
testMergeSort(array: [1, 543, 23, 3,2 ,3, 224,234,234,56,87,22342324,4234,453577,6,53,3421,34,57,23434,56565,8,722672,573,53,56,453545765,23,32,3435,6,78,8778,8,8983,4,568756213,4654899,54644423245,234,23,25,436423,68765,647876,43, 34,265,645,3,4232,4232,434,53,53,53,3,4221,23,24,3554,654,6345, 1,1,1,11,1,1,1,11,1,1,1,11,1,1,])

let str = "123"
print(str[str.index(str.startIndex, offsetBy: 2)])



//print(merge(inputFirstArray: [Int](), inputSecondArray: [1]))
//print(merge(inputFirstArray: [2], inputSecondArray: [1]))
//print(merge(inputFirstArray: [2], inputSecondArray: [1, 3]))
//print(merge(inputFirstArray: [2], inputSecondArray: [1, 6]))
//print(merge(inputFirstArray: [2], inputSecondArray: [1, 1]))
//print(merge(inputFirstArray: [1, 2, 3], inputSecondArray: [1]))
//print(merge(inputFirstArray: [2, 4, 6, 8, 10, 14], inputSecondArray: [1, 3, 5, 7, 9, 11, 13]))
//print(merge(inputFirstArray: [2, 4, 6, 7, 10, 14], inputSecondArray: [1, 3, 5, 7, 9, 11, 13]))
