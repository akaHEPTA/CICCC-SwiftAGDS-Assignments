//
//  Queue.swift
//  SwiftAlgorithmsDataStructures
//
//  Created by Derrick Park on 2/12/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import Foundation

/// The Queue class represents a first-in-first-out (FIFO) queue of generic items.
/// It supports the usual *eunque* and *dequeue* operations, along with methods for peeking at the first item, testing if the queue is empty, and iterating through the items in FIFO order.
/// This implementation uses a singly linked list with an inner class for linked list nodes.
public final class Queue<E> : Sequence {
    /// beginning of queue
    private var first: Node<E>? = nil
    /// end of queue
    private var last: Node<E>? = nil
    /// size of the queue
    private(set) var count: Int = 0
    
    /// helper linked list node class
    fileprivate class Node<E> {
        fileprivate var item: E
        fileprivate var next: Node<E>?
        fileprivate init(item: E, next: Node<E>? = nil) {
            self.item = item
            self.next = next
        }
    }
    
    /// Initializes an empty queue.
    public init() {}
    
    /// Returns true if this queue is empty.
    public func isEmpty() -> Bool {
        return first == nil
    }
    
    /// Returns the item least recently added to this queue.
    public func peek() -> E? {
        return first?.item
    }
    
    /// Adds the item to this queue
    /// - Parameter item: the item to add
    public func enqueue(item: E) {
        let oldLast = last
        last = Node<E>(item: item)
        if isEmpty() { first = last }
        else { oldLast?.next = last }
        count += 1
    }
    
    /// Removes and returns the item on this queue that was least recently added.
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
    
    /// QueueIterator that iterates over the items in FIFO order.
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
    
    /// Returns an iterator that iterates over the items in this Queue in FIFO order.
    public __consuming func makeIterator() -> QueueIterator<E> {
        return QueueIterator<E>(first)
    }
}

extension Queue: CustomStringConvertible {
    public var description: String {
        return self.reduce(into: "") { $0 += "\($1) " }
    }
}





/// The Queue class represents a first-in-first-out (FIFO) queue of generic items.
/// It supports the usual *eunque* and *dequeue* operations, along with methods for peeking at the first item, testing if the queue is empty, and iterating through the items in FIFO order.
/// This implementation uses a singly linked list with an inner class for linked list nodes.
//public final class Queue2<E> : Sequence {
//    /// beginning of queue
//    private var first: Node<E>? = nil
//    /// end of queue
//    private var last: Node<E>? = nil
//    /// size of the queue
//    private(set) var count: Int = 0
//
//    /// helper linked list node class
//    fileprivate class Node<E> {
//        fileprivate var item: E
//        fileprivate var next: Node<E>?
//        fileprivate init(item: E, next: Node<E>? = nil) {
//            self.item = item
//            self.next = next
//        }
//    }
//
//    /// Initializes an empty queue.
//    public init() {}
//
//    /// Returns true if this queue is empty.
//    public func isEmpty() -> Bool {
//        return count == 0
//    }
//
//    /// Returns the item least recently added to this queue.
//    public func peek() -> E? {
//        return first?.item
//    }
//
//    /// Adds the item to this queue
//    /// - Parameter item: the item to add
//    public func enqueue(item: E) {
//        if isEmpty() {
//            first = Node(item: item)
//            last = first
//        } else {
//            var cursor: Node<E> = first!
//            for _ in 0 ..< (count - 1) {
//                cursor = cursor.next!
//            }
//            cursor.next = Node(item: item)
//            last = cursor.next
//        }
//        count += 1
//    }
//
//    /// Removes and returns the item on this queue that was least recently added.
//    public func dequeue() -> E? {
//        guard first != nil else { return nil }
//        defer {
//            if count == 1 {
//                first = nil
//                last = nil
//            } else {
//                first = first?.next
//            }
//            count -= 1
//        }
//        return first!.item
//    }
//
//    /// QueueIterator that iterates over the items in FIFO order.
//    public struct QueueIterator<E> : IteratorProtocol {
//        private var current: Node<E>?
//        private var first = true
//
//        fileprivate init(_ first: Node<E>?) {
//            current = first
//        }
//
//        public mutating func next() -> E? {
//            guard current != nil else { return nil }
//            if first {
//                first = false
//            } else {
//                current = current?.next
//            }
//            return current?.item
//        }
//
//        public typealias Element = E
//    }
//
//    /// Returns an iterator that iterates over the items in this Queue in FIFO order.
//    public __consuming func makeIterator() -> QueueIterator<E> {
//        return QueueIterator<E>(first)
//    }
//}
//
//extension Queue: CustomStringConvertible {
//    public var description: String {
//        return self.reduce(into: "") { $0 += "\($1) " }
//    }
//}
