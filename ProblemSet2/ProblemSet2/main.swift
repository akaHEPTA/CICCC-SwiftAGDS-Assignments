//
//  main.swift
//  ProblemSet2
//
//  Created by Richard Cho on 2020-03-02.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

/* Problem 1 - Cyclic Permutation

let testCases = Int(readLine()!)!

func dfs(start: Int, visited: inout [Bool], adjList: [Int]) {
    if !visited[start] {
        visited[start] = true
        dfs(start: adjList[start], visited: &visited, adjList: adjList)
    }
}

for _ in 0..<testCases {
    let size = Int(readLine()!)!
    var permutations: [Int] = readLine()!.split(separator: " ").map{ Int($0)! }
    permutations.insert(0, at: 0)
    var visited = [Bool](repeating: false, count: size + 1)
    var count = 0
    for v in 1..<size + 1 {
        if !visited[v] {
            dfs(start: v, visited: &visited, adjList: permutations)
            count += 1
        }
    }
    print(count)
}

// */


//* Problem 2 - Repeating Sequence

let first = readLine()!.split(separator: " ").map{ Int($0)! }
var D: [Int] = [0, first[0]]
let times = first[1]

var counter = 1

repeat {
    let prev = D[counter]
    
    let a = Int(pow((Double(prev / 1000)), Double(times)))
    let b = Int(pow((Double((prev % 1000) / 100)), Double(times)))
    let c = Int(pow((Double((prev % 100) / 10)), Double(times)))
    let d = Int(pow((Double((prev % 10) / 1)), Double(times)))
    
    let current = a + b + c + d
    D.append(current)
    
    counter += 1
} while !D[1..<counter].contains(D[counter])

let left = D[1..<D.firstIndex(of: D[counter])!]

print(left.count)

// */


