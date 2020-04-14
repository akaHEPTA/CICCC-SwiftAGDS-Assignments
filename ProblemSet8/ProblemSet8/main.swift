//
//  main.swift
//  ProblemSet8
//
//  Created by Richard Cho on 2020-03-13.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

func networkDelayTime(_ times: [[Int]], _ N: Int, _ K: Int) -> Int {
    var dist = [Int](repeating: Int.max, count: N + 1)
    dist[K] = 0
    for _ in 0..<N {
        for e in times {
            let u = e[0], v = e[1], w = e[2]
            if dist[u] != Int.max && dist[v] > dist[u] + w {
                dist[v] = dist[u] + w
            }
        }
    }
    
    var maxWait = 0
    for i in 1...N {
        maxWait = max(maxWait, dist[i])
    }
    
    return maxWait == Int.max ? -1 : maxWait
}

func findCheapestPrice(_ n: Int, _ flights: [[Int]], _ src: Int, _ dst: Int, _ K: Int) -> Int {
    var cost = [Int](repeating: Int.max, count: n)
    
    cost[src] = 0
    for _ in 0...K {
        var temp = cost
        for flight in flights {
            let current = flight[0], next = flight[1], price = flight[2]
            if cost[current] == Int.max { continue }
            temp[next] = min(temp[next], cost[current] + price)
        }
        cost = temp
    }
    
    return cost[dst] == Int.max ? -1 : cost[dst]
}
