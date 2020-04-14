//
//  main.swift
//  RealSushi
//
//  Created by Richard Cho on 2020-02-27.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

let first = readLine()!.split(separator: " ")
// n: total number of nodes / n-1: number of edges / m: number of real sushi restaurant
let n = Int(first[0])!, m = Int(first[1])!
var map = [[Int]](repeating: [Int](repeating: 100000, count: n), count: n)
var visited = [Bool](repeating: false, count: n)
var depth = [Int](repeating: 0, count: n)
var realSushi: [Int] = readLine()!.split(separator: " ").map{ Int($0)! }
var count = [[Int]](repeating: [Int](), count: m)
var distance = [Int](repeating: 100000, count: n)

for _ in 0..<n-1 {
    let temp = readLine()!.split(separator: " ")
    let p = Int(temp[0])!
    let q = Int(temp[1])!
    map[p][q] = 1
    map[q][p] = 1
}

for i in 0..<n { map[i][i] = 0 }

func choose(_ distance: inout [Int], _ n: Int, _ visited: inout [Bool]) -> Int {
    var min = n, minpos = -1
    for i in 0..<n {
        if distance[i] < min && visited[i] == false {
            min = distance[i]
            minpos = i
        }
    }
    return minpos
}

func path(from a: Int, n b: Int) -> [Int] {
    for i in 0..<b {
        distance[i] = map[a][i]
        visited[i] = false
    }
    visited[a] = true
    distance[a] = 0
    
    for _ in 0..<b-1 {
        let u = choose(&distance, b, &visited)
        visited[u] = true
        for w in 0..<b {
            if visited[w] == false {
                if distance[u] + map[u][w] < distance[w] {
                    distance[w] = distance[u] + map[u][w]
                }
            }
        }
    }
    return distance
}

var distances = [[Int]]()

for real in realSushi {
    distances.append(path(from: real, n: n))
}




