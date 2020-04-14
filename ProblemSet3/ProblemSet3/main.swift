//
//  main.swift
//  ProblemSet3
//
//  Created by Richard Cho on 2020-03-02.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

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


//* Problem 1 - Tomato Farm

class Tomato {
    let x: Int
    let y: Int

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

let dx = [0, 0, 1, -1]
let dy = [1, -1, 0, 0]

let line = readLine()!.split(separator: " ").map{ Int($0)! }
let m = line[0], n = line[1]

var tomatoBox = [[Int]]()
for _ in 0..<n {
    let line = readLine()!.split(separator: " ").map{ Int($0)! }
    tomatoBox.append(line)
}

var tomatoBoxAfter = tomatoBox

let q = Queue<Tomato>()
var day = 0
var flag = false

func isSafe(_ x: Int, _ y: Int) -> Bool {
    return 0 <= x && x < m && 0 <= y && y < n
}

func bfs(q: Queue<Tomato>) {
    while !q.isEmpty() {
        let tomato = q.dequeue()!
        let (x, y) = (tomato.x, tomato.y)
        if x == -1 && y == -1 {
            if flag { break }
            flag = true
            q.enqueue(item: Tomato(-1, -1))
            day += 1
        } else {
            flag = false
            for i in 0..<4 {
                let nx = x + dx[i]
                let ny = y + dy[i]
                if isSafe(nx, ny) {
                    if tomatoBox[ny][nx] == 0 {
                        q.enqueue(item: Tomato(nx, ny))
                        tomatoBox[ny][nx] = 1
                    }
                }
            }
        }
    }
}

for y in 0..<n {
    for x in 0..<m {
        if tomatoBox[y][x] == 1 {
            q.enqueue(item: Tomato(x, y))
        }
    }
}

q.enqueue(item: Tomato(-1, -1))

bfs(q: q)

if tomatoBox.flatMap({ $0 }).contains(0) {
    print(-1)
} else {
    print(day - 1)
}
