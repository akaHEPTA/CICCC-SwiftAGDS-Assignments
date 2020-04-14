//
//  Problem1.swift
//  SwiftQuiz2
//
//  Created by Richard Cho on 2020-02-21.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

class Problem1 {
    let root = Node(val: 1)
    var checkList: [Bool]
    
    init(size: Int) {
        checkList = [Bool](repeating: false, count: size + 1)
        checkList[1] = true
    }
    
    func isParent(a: Int) -> Bool {
        return checkList[a]
    }
    
    func append(a: Int, b: Int) {
        if isParent(a: a) {
            if let parent = search(current: self.root, des: a) {
                parent.child.append(Node(val: b))
                checkList[b] = true
            }
        } else {
            if let parent = search(current: self.root, des: b) {
                parent.child.append(Node(val: a))
                checkList[a] = true
            }
        }
    }
    
    func search(current: Node<Int>, des: Int) -> Node<Int>? {
        if current.val == des {
            return current
        } else {
            guard !current.child.isEmpty else { return nil }
            for child in current.child {
                if let temp = search(current: child, des: des) {
                    return temp
                } else {
                    continue
                }
            }
            return nil
        }
    }
    
    func getParent(child: Int) -> Int {
        return searchParent(current: self.root, des: child)
    }
    
    private func searchParent(current: Node<Int>, des: Int) -> Int {
        if current.val == des {
            return 0
        } else {
            guard !current.child.isEmpty else { return -1 }
            for child in current.child {
                let temp = searchParent(current: child, des: des)
                if temp == 0 {
                    return current.val
                } else if temp != 0 && temp != -1 {
                    return temp
                }
            }
            return -1
        }
    }
    
    class Node<Int> {
        var val: Int
        var child: [Node<Int>] = []
        
        init(val: Int) {
            self.val = val
        }
    }
    
}
