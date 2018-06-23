
// MARK: - Supporting methods

func split(array: [Int]) -> ([Int], [Int]) {
    let midpoint = array.count / 2

    let firstHalf = Array(array[..<midpoint])
    let secondHalf = Array(array[midpoint...])

    return (firstHalf, secondHalf)
}

func mergeAndCountInversions(inputFirstArray: [Int], inputSecondArray: [Int]) -> ([Int], Int) {
    var first = inputFirstArray
    var second = inputSecondArray

    let totalCount = first.count + second.count

    var sortedArray = [Int]()
    var inversions = 0

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
            inversions += first.count
        }
    }

    return (sortedArray, inversions)
}

// MARK: - Merge Sort Algorithm + Inversions counting Implementation

let array = [1, 3, 5, 4, 6, 10, 7, 2]
let array2 = [1, 9, 6, 4 ,5, 2, 3, 10]

/// Return value is a tuple, where 1st element is mergeSorted array, 2nd element is quantity of inversions.
func mergeSortAndCountInversions(in array: [Int]) -> ([Int], Int) {
    guard array.count > 1
        else { return (array, 0) }

    let splittedArrays = split(array: array)
    let firstHalf = splittedArrays.0
    let secondHalf = splittedArrays.1

    let firstHalfTuple = mergeSortAndCountInversions(in: firstHalf)
    let secondHalfTuple = mergeSortAndCountInversions(in: secondHalf)
    let sortedFirstHalf = firstHalfTuple.0
    let sortedSecondHalf = secondHalfTuple.0

    let mergedSortedArrayAndInversions = mergeAndCountInversions(inputFirstArray: sortedFirstHalf, inputSecondArray: sortedSecondHalf)
    let mergedSortedArray = mergedSortedArrayAndInversions.0
    let inversions = mergedSortedArrayAndInversions.1 + firstHalfTuple.1 + secondHalfTuple.1

    return (mergedSortedArray, inversions)
}

print(mergeSortAndCountInversions(in: array2))
