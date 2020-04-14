//
//  main.swift
//  RealSushi2
//
//  Created by Richard Cho on 2020-02-28.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

let first = readLine()!.split(separator: " ")
// n: total number of nodes / n-1: number of edges / m: number of real sushi restaurant
let n = Int(first[0])!, m = Int(first[1])!
var map = [[Int]](repeating: [Int](), count: n)
var visited = [Bool](repeating: false, count: n)
var depth = [Int](repeating: 0, count: n)

var realSushi: [Int] = readLine()!.split(separator: " ").map{ Int($0)! }

for _ in 0..<n-1 {
    let temp = readLine()!.split(separator: " ")
    let p = Int(temp[0])!
    let q = Int(temp[1])!
    map[p].append(q)
    map[q].append(p)
}

var count = 0
func dfs(start: Int, visited: inout [Bool], map: inout [[Int]]) {
    depth[start] = count
    count += 1
    visited[start] = true
    for v in map[start] {
        if !visited[v] {
            dfs(start: v, visited: &visited, map: &map)
            count -= 1
        }
    }
}

for v in 0..<map.count {
    if !visited[v] {
        dfs(start: 0, visited: &visited, map: &map)
    }
}

var start: Int = 0
var max: Int = depth[0]
for j in realSushi {
    if depth[j] > max {
        max = depth[j]
        start = j
    }
}

visited = [Bool](repeating: false, count: n)

for v in 0..<map.count {
    if !visited[v] {
        dfs(start: start, visited: &visited, map: &map)
    }
}

var diameter: Int = 0
max = 0
for j in realSushi {
    if depth[j] > max {
        max = depth[j]
        diameter = j
    }
}

// in this moment we have diameter

func dfs3(start: Int, parent: Int, map: inout [[Int]]) {
    let temp = map[start].filter({ $0 != parent })
    if temp.isEmpty && !realSushi.contains(start) {
        map[start].remove(at: map[start].firstIndex(of: parent)!)
        map[parent].remove(at: map[parent].firstIndex(of: start)!)
    } else {
        for v in temp {
            dfs3(start: v, parent: start, map: &map)
            
        }
    }
}

dfs3(start: start, parent: start, map: &map)

print(map)

//print("\(( - 1) * 2 - diameter)")

//realSushiLeft = realSushi
//isSearching = true
//count = 0
//
//func dfs2(start: Int, parent: Int, map: inout [[Int]]) -> Bool {
//    guard isSearching else { return false }
//
//    print(start)
//    if realSushiLeft.contains(start) {
//        realSushiLeft.remove(at: realSushiLeft.firstIndex(of: start)!)
//    }
//    if realSushiLeft.isEmpty {
//        isSearching = false
//        print(count-1)
//        return false
//    } else {
//        var q = Array<Int>()
//        let temp = map[start].filter({ $0 != parent })
//
//        if temp.isEmpty && realSushi.contains(start) {
//            return true
//        }
//
//        for v in temp {
//            if realSushi.contains(v) && realSushiLeft.contains(v) {
//                q.insert(v, at: 0)
//            } else {
//                q.append(v)
//            }
//        }
//
//        var found = [Bool]()
//
//        for v in q {
//            let f = dfs2(start: v, parent: start, map: &map)
//            if f {
//                count += 1
//            } else {
//                count -= 1
//            }
//            found.append(f)
//        }
//        return found.filter({ $0 == true }).count > 0
//    }
//}
//




