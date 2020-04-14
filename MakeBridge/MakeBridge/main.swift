//
//  main.swift
//  MakeBridge
//
//  Created by Richard Cho on 2020-03-03.
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
    
    public func isEmpty() -> Bool { return first == nil }
    
    public func peek() -> E? { return first?.item }
    
    public func enqueue(item: E) {
        let oldLast = last
        last = Node<E>(item: item)
        if isEmpty() { first = last } else { oldLast?.next = last }
        count += 1
    }
    
    public func dequeue() -> E? {
        if let item = first?.item {
            first = first?.next
            count -= 1
            if isEmpty() { last = nil }
            return item
        }
        return nil
    }
    
    public struct QueueIterator<E> : IteratorProtocol {
        private var current: Node<E>?
        
        fileprivate init(_ first: Node<E>?) { self.current = first }
        
        public mutating func next() -> E? {
            if let item = current?.item {
                current = current?.next
                return item
            }
            return nil
        }
        
        public typealias Element = E
    }
    
    public __consuming func makeIterator() -> QueueIterator<E> { return QueueIterator<E>(first) }
}

extension Queue: CustomStringConvertible {
    public var description: String { return self.reduce(into: "") { $0 += "\($1) " } }
}


//* GET INPUT
let size = Int(readLine()!)!
var inputMap = [[Int]]()
var map = [[Int]](repeating: [Int](repeating: 0, count: size), count: size)
var checked = [[Bool]](repeating: [Bool](repeating: false, count: size), count: size)
for _ in 0..<size {
    let line = readLine()!.split(separator: " ").map{ Int($0)! }
    inputMap.append(line)
}
// */

class Square {
    let x: Int
    let y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

let dx = [0, 0, 1, -1]
let dy = [1, -1, 0, 0]

func isSafe(_ x: Int, _ y: Int) -> Bool {
    return 0 <= x && x < size && 0 <= y && y < size
}

let island1 = Queue<Square>()
let island2 = Queue<Square>()

func bfs(x: Int, y: Int, id: Int, n: Int) {
    let q = Queue<Square>()
    let square = Square(x, y)
    q.enqueue(item: square)
    map[x][y] = id
    
    while !q.isEmpty() {
        let square = q.dequeue()!
        let (x, y) = (square.x, square.y)
        
        if id == 1 { island1.enqueue(item: square) }
        if id == 2 { island2.enqueue(item: square) }
        
        for i in 0..<4 {
            let nx = x + dx[i]
            let ny = y + dy[i]
            if isSafe(nx, ny) {
                if inputMap[nx][ny] == 1 && map[nx][ny] == 0 {
                    q.enqueue(item: Square(nx, ny))
                    map[nx][ny] = id
                }
            }
        }
    }
}

//* LABELLING
var id = 0
for x in 0..<size {
    for y in 0..<size {
        if inputMap[x][y] == 1 && map[x][y] == 0 {
            id += 1
            bfs(x: x, y: y, id: id, n: size)
        }
    }
}
// */

var answer = [Int]()

func expansion(queue q: Queue<Square>, map: [[Int]]) {
    var map = map
    q.enqueue(item: Square(-1, -1))
    var count = 0
    queueLoop: while !q.isEmpty() {
        let square = q.dequeue()!
        let (x, y) = (square.x, square.y)
        
        // count flag
        if x == -1 && y == -1 {
            q.enqueue(item: square)
            count += 1
        }
        
        for i in 0..<4 {
            let nx = x + dx[i]
            let ny = y + dy[i]
            if isSafe(nx, ny) {
                if map[nx][ny] == 0 {
                    q.enqueue(item: Square(nx, ny))
                    map[nx][ny] = map[x][y]
                } else {
                    if map[nx][ny] != map[x][y] {
                        answer.append(count)
                        break queueLoop
                    }
                }
            }
        }
    }
}

expansion(queue: island1, map: map)
expansion(queue: island2, map: map)

print(min(answer[0], answer[1]))
