//
//  ViewController.swift
//  CalculateArrayInversions
//
//  Created by Tung Fam on 6/23/18.
//  Copyright © 2018 Tung Fam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print(Date().timeIntervalSince1970)

        getArrayFromTextFile { array in

            let mergeSortedAndInversions = mergeSortAndCountInversions(in: array)

            testSort(array1: array.sorted(), array2: mergeSortedAndInversions.0)

            print(mergeSortedAndInversions.1)

            print(Date().timeIntervalSince1970)
        }
    }

    // MARK: - Merge Sort Algorithm + Inversions counting Implementation

    /// Return value is a tuple, where 1st element is mergeSorted array, 2nd element is quantity of inversions.
    private func mergeSortAndCountInversions(in array: [Int]) -> ([Int], Int) {
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

    // MARK: - Supporting methods

    private func getArrayFromTextFile(completion: (_ array: [Int]) -> Void) {
        do {
            // This solution assumes  you've got the file in your bundle
            if let path = Bundle.main.path(forResource: "PA_file", ofType: "txt") {
                let data = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                let stringsArrayWithTail = data.components(separatedBy: "\n")
                let stringsArray = stringsArrayWithTail.map { item -> String in
                    if item.hasSuffix("\r") {
                        return String(item.dropLast(1))
                    } else {
                        return item
                    }
                }
                let intArray = stringsArray.compactMap { Int($0) }
                completion(intArray)
            }
        } catch {
            print(error)
            completion([Int]())
        }
    }

    private func split(array: [Int]) -> ([Int], [Int]) {
        let midpoint = array.count / 2

        let firstHalf = Array(array[..<midpoint])
        let secondHalf = Array(array[midpoint...])

        return (firstHalf, secondHalf)
    }

    private func mergeAndCountInversions(inputFirstArray: [Int], inputSecondArray: [Int]) -> ([Int], Int) {
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

    // MARK: Testing

    private func testSort(array1: [Int], array2: [Int]) {
        print(array1 == array2)
    }

}

