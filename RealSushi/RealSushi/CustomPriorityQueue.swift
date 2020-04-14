//
//  CustomPriorityQueue.swift
//  GroupPresentation1
//
//  Created by Richard Cho on 2020-02-19.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

public class CustomPriorityQueue<T> {
    private var arr: [T] = []
    private var size = 0

    func enqueue(_ a: T) {
        arr.append(a)
        size += 1
        heapify(arr.count)
    }
    
    func peek() -> T? {
        if arr.isEmpty {
            return nil
        }
        return arr[0]
    }

    func pop() -> T? {
        if arr.isEmpty {
            return nil
        }

        let res: T = arr.removeFirst()

        if !arr.isEmpty {
            arr.insert(arr.removeLast(), at: 0)
            heapify(0)
        }

        return res
    }
    
    func describe() {
        print(arr)
    }
    
    func isEmpty() -> Bool {
        return arr.count == 0
    }

    private func heapify(_ i: Int) {
        let l: Int = 2 * i + 1, r: Int = 2 * i + 2
        var root: Int = i

        if l < arr.count, !compare(arr[l], arr[root]) {
            root = l
        }

        if r < arr.count, !compare(arr[r], arr[root]) {
            root = r
        }

        if root == i {
            return
        }

        let temp: T = arr[i]
        arr[i] = arr[root]
        arr[root] = temp

        heapify(root)
    }
}
