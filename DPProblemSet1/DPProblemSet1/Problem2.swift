//
//  Problem2.swift
//  DPProblemSet1
//
//  Created by Richard Cho on 2020-03-19.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

class LPS {
    // 1. Naive Exhaustive Search
    // Time: O(2^N)
    // Space: O(N)
    func findLPSNaive(str: String) -> Int {
        return calcNaive(str: str, start: 0, end: str.count - 1)
    }
    
    func calcNaive(str: String, start: Int, end: Int) -> Int {
        if start > end { return 0 }
        if start == end { return 1 }
        if str[start] == str[end] { return 2 + calcNaive(str: str, start: start + 1, end: end + 1) }
        
        let c1 = calcNaive(str: str, start: start + 1, end: end)
        let c2 = calcNaive(str: str, start: start, end: end - 1)
        
        return max(c1, c2)
    }
    
    // 2. DP Top-Down
    // Time:
    // Space:
    func findLPSTopDown(str: String) -> Int {
        let n = str.count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
        
        return calcTopDown(str, 0, str.count - 1, &dp)
    }
    
    func calcTopDown(_ str: String, _ start: Int, _ end: Int, _ dp: inout [[Int]]) -> Int {
        if start > end { return 0 }
        if start == end { return 1 }
        
        if dp[start][end] == 0 {
            if str[start] == str[end] {
                dp[start][end] = 2 + calcTopDown(str, start + 1, end + 1, &dp)
            } else {
                let c1 = calcTopDown(str, start + 1, end, &dp)
                let c2 = calcTopDown(str, start, end - 1, &dp)
                dp[start][end] = max(c1, c2)
            }
        }
        return dp[start][end]
    }
    
    // 3. DP Bottom Up
    // Time: O(N^2) - Quadratic time (polynomial time)
    // Space: O(N^2)
    func findLPSBottomUp(str: String) -> Int{
        let n = str.count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
        
        for i in 0..<n { dp [i][i] = 1 }
        
        for i in stride(from: n - 1, through: 0, by: -1) {
            for j in i + 1..<n {
                if str[i] == str[j] {
                    dp[i][j] = 2+dp[i+1][j-1]
                } else {
                    dp[i][j] = max(dp[i + 1][j], dp[i][j-1])
                }
            }
        }
        
        return dp[0][n - 1]
    }
}
