//
//  main.swift
//  LeetCode207
//
//  Created by Richard Cho on 2020-03-04.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

class Solution {
    func canFinish(_ numCourses: Int, _ prerequisited: [[Int]]) -> Bool {
        var adj = [[Int]](repeating: [Int](), count: numCourses)
        var rc = [Int](repeating: 0, count: numCourses)
        for e in prerequisited {
            adj[e[1]].append(e[0])
            rc[e[0]] += 1
        }
        
        func checkDependency() -> Bool {
            let q = Queue<Int>()
            var checked = [Bool](repeating: false, count: numCourses)
            for i in 0..<rc.count { if rc[i] == 0 { q.enqueue(item: i) } }
            
            while !q.isEmpty() {
                let first = q.dequeue()!
                checked[first] = true
                
                if rc[first] != 0 { return false }
                
                for j in adj[first] {
                    rc[j] -= 1
                    if rc[j] == 0 { q.enqueue(item: j) }
                }
            }
            
            if checked.contains(false) { return false }
            return true
        }
        
        if !rc.contains(0) { return false }
        else {
            return checkDependency()
        }
    }
}

public final class Queue<E> : Sequence {
    private var first: Node<E>? = nil
    private var last: Node<E>? = nil
    private(set) var count: Int = 0
    
    fileprivate class Node<E> {
        fileprivate var item: E
        fileprivate var next: Node<E>?
        fileprivate init(item: E, next: Node<E>? = nil) {
            self.item = item
            self.next = next
        }
    }
    
    public init() {}
    
    public func isEmpty() -> Bool {
        return first == nil
    }
    
    public func peek() -> E? {
        return first?.item
    }
    
    public func enqueue(item: E) {
        let oldLast = last
        last = Node<E>(item: item)
        if isEmpty() { first = last }
        else { oldLast?.next = last }
        count += 1
    }
    
    public func dequeue() -> E? {
        if let item = first?.item {
            first = first?.next
            count -= 1
            // to avoid loitering
            if isEmpty() { last = nil }
            return item
        }
        return nil
    }
    
    public struct QueueIterator<E> : IteratorProtocol {
        private var current: Node<E>?
        
        fileprivate init(_ first: Node<E>?) {
            self.current = first
        }
        
        public mutating func next() -> E? {
            if let item = current?.item {
                current = current?.next
                return item
            }
            return nil
        }
        
        public typealias Element = E
    }
    
    public __consuming func makeIterator() -> QueueIterator<E> {
        return QueueIterator<E>(first)
    }
}

extension Queue: CustomStringConvertible {
    public var description: String {
        return self.reduce(into: "") { $0 += "\($1) " }
    }
}

