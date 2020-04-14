//
//  getSortedElements.swift
//  GroupPresentation1
//
//  Created by Richard Cho on 2020-02-24.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

// 1. Find the smallest/largest M elements in a stream of N items.
func getSortedElements(n: Int, m: Int, compare: @escaping (Int, Int) -> Bool) {
    
    var arr: [Int] = Array(repeating: 0, count: n)
    
    let queue: CustomPriorityQueue<Int> = CustomPriorityQueue(m, compare)
    for i in 0..<n {
        arr[i] = Int.random(in: 1...10000)
        queue.insert(arr[i])
    }
    
    var res: [Int] = Array(repeating: 0, count: m)
    var j = m - 1
    while (queue.peek() != nil && j > -1) {
        res[j] = queue.pop()!
        j -= 1
    }
    
    print("Original Array")
    print(arr)
    print("heap sort(nlogm solution)")
    print(res)
    print("normal sort(nlogn solution)")
    let sortedArray: [Int] = arr.sorted(by: compare)
    print(sortedArray[0..<m])
}
