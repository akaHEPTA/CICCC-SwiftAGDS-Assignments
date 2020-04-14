//
//  main.swift
//  ProblemSet7
//
//  Created by Richard Cho on 2020-03-05.
//  Copyright © 2020 Richard Cho. All rights reserved.
//
import Foundation

// LeetCode 1029. Two City Scheduling
class LeetCode1029 {
    func twoCitySchedCost(_ costs: [[Int]]) -> Int {
        let costs = costs.map{ [$0[0], $0[1], $0[0] - $0[1]] }.sorted(by: { $0[2] > $1[2] })
        
        var totalCost = 0
        for i in 0..<(costs.count / 2) { totalCost += costs[i][1] + costs[costs.count - i - 1][0] }
        
        return totalCost
    }
}

// LeetCode 621. Task Scheduler
class LeetCode621 {
    func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
        var counter = [Int](repeating: 0, count: 26)
        tasks.forEach{ counter[Int($0.asciiValue! - 65)] += 1 }
        
        let maxNum = counter.max()!
        let maxCount = counter.filter({ $0 == maxNum }).count
        
        let repeatCount = maxNum - 1
        let repeatLength = n - (maxCount - 1)
        
        let emptySpace = repeatCount * repeatLength
        let lefts = tasks.count - maxNum * maxCount
        
        if emptySpace - lefts < 0 { return tasks.count }
        else { return tasks.count + emptySpace - lefts }
    }
}

// LeetCode 134. Gas Station
class LeetCode134 {
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        guard gas.reduce(0, { $0 + $1 }) >= cost.reduce(0, { $0 + $1 }) else { return -1 }
        
        var current = 0, total = 0, start = 0
        
        for i in 0..<gas.count {
            current = current + gas[i] - cost[i]
            if current < 0 {
                start = i + 1
                total += current
                current = 0
            }
        }
        return total + current < 0 ? -1 : start
    }
}

extension String {
    subscript(index: Int) -> String {
        get {
            return String(self[self.index(startIndex, offsetBy: index)])
        }
        set {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            self = self.replacingCharacters(in: startIndex..<self.index(after: startIndex), with: newValue)
        }
    }
}

// LeetCode 768. Partition Labels
class LeetCode768 {
    func partitionLabels(_ S: String) -> [Int] {
        guard !S.isEmpty else { return [Int]() }
        
        var lastIndex = [Int](repeating: 0, count: 26)
        for i in 0..<S.count { lastIndex[Int(Character(S[i]).asciiValue!) - 97] = i }
        
        var j = 0, cursor = 0
        var result = [Int]()
        
        for i in 0..<S.count {
            j = max(j, lastIndex[Int(Character(S[i]).asciiValue!) - 97])
            if i == j {
                result.append(i - cursor + 1)
                cursor = i + 1
            }
        }
        
        return result;
    }
}

