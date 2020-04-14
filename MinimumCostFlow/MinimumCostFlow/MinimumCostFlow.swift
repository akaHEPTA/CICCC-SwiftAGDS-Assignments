//
//  MinimumCostFlow.swift
//  MinimumCostFlow
//
//  Created by Richard Cho on 2020-03-11.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

func minimumCostFlow() -> [Int] {
    let firstLine = readLine()!.split(separator: " ").compactMap{ Int($0) }
    let N = firstLine[0] // The number of the buildings in Vancouver
    let M = firstLine[1] // The number of the pipes between the buildings
    let D = firstLine[2] // The strength of the enhancer
    
    var edges = [Edge]()
    
    for i in 1...M {
        let line = readLine()!.split(separator: " ").compactMap{ Int($0) }
        edges.append(Edge(line[0], line[1], line[2], i < N))
    }
    edges.sort()
    
    var uf = UF(N + 1)
    var active = 0, count = 0, index = 0
    
    for i in 0..<M {
        let edge = edges[i]
        if !uf.connected(edge.from, edge.to) {
            active += 1
            uf.union(edge.from, edge.to)
            if !edge.isActivated { count += 1 }
        }
        if active >= N - 1 { index = i; break }
    }
    
    if edges[index].cost < D {
        if !edges[index].isActivated { count -= 1 }
    }
    
    print(count)
    return [count]
}

public struct Edge: Comparable {
    public static func < (lhs: Edge, rhs: Edge) -> Bool {
        return lhs.cost < rhs.cost
    }
    
    let from: Int
    let to: Int
    let cost: Int
    let isActivated: Bool
    
    init (_ from: Int, _ to: Int, _ cost: Int, _ isActivated: Bool) {
        self.from = from
        self.to = to
        self.cost = cost
        self.isActivated = isActivated
    }
}

//
//  UF.swift
//  SwiftAlgorithmsDataStructures
//
//  Created by Derrick Park on 2/24/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//
public struct UF {
    private var parent: [Int]
    private var size: [Int]
    private(set) var count: Int
    
    public init(_ n: Int) {
        self.count = n
        self.size = [Int](repeating: 1, count: n)
        self.parent = [Int](repeating: 0, count: n)
        for i in 0..<n {
            self.parent[i] = i
        }
    }
    
    public mutating func find(_ p: Int) -> Int { return root(of: p) }
    
    public mutating func connected(_ p: Int, _ q: Int) -> Bool { return root(of: p) == root(of: q) }
    
    public mutating func union(_ p: Int, _ q: Int) {
        let rp = root(of: p), rq = root(of: q)
        if size[rp] < size[rq] {
            parent[rp] = rq
            size[rq] += size[rp]
        } else {
            parent[rq] = rp
            size[rp] += size[rq]
        }
    }
    
    private mutating func root(of p: Int) -> Int {
        var p = p
        while p != parent[p] {
            parent[p] = parent[parent[p]]
            p = parent[p]
        }
        return p
    }
}

