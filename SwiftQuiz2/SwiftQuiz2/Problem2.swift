//
//  Problem2.swift
//  SwiftQuiz2
//
//  Created by Richard Cho on 2020-02-21.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

class Problem2 {
    var data: [Node<Int>?]
    
    init(size: Int) {
        self.data = [Node<Int>?](repeating: nil, count: size)
    }
    
    func append(val: Int, linked: [[Int]]) {
        self.data[val] = Node(val, linked)
    }
    
//    func diameter() -> Int {
//        var dis = 0
//        for node in self.data {
//            for (i, distance) in node?.linked {
//                if dis < distance { dis = distance }
//            }
//        }
//
//        self.data.reduce(<#T##initialResult: Result##Result#>, <#T##nextPartialResult: (Result, Problem2.Node<Int>?) throws -> Result##(Result, Problem2.Node<Int>?) throws -> Result#>)
//
//
//        return 0
//    }
    
    class Node<Int> {
        let val: Int
        var linked: [[Int]]
        
        init(_ val: Int, _ linked: [[Int]]) {
            self.val = val
            self.linked = linked
        }
        
        public func link(list: [[Int]]) {
            for node in list {
                linked.append(node)
            }
        }
    }
}
