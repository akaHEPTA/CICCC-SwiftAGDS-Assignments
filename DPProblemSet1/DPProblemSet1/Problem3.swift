//
//  Problem3.swift
//  DPProblemSet1
//
//  Created by Richard Cho on 2020-03-19.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

class LCS {
    // 1. Naive Exhaustive search
    // Time: O(3^(M + N)) where m is the length s1, n is the length of s2
    // Space: O(M + N)
    // index1, index2, count
    func findLCS(s1: String, s2: String) -> Int {
        return findLCSNaive(s1, s2, 0, 0, 0)
    }
    
    private func findLCSNaive(_ s1: String,_ s2: String,_ i1: Int, _ i2: Int,_ count: Int) -> Int {
        if i1 == s1.count || i2 == s2.count { return count }
        var count = count
        
        if s1[i1] == s2[i2] { count = findLCSNaive(s1, s2, i1 + 1, i2 + 1, count + 1) }
        
        let c1 = findLCSNaive(s1, s2, i1 + 1, i2, 0)
        let c2 = findLCSNaive(s1, s2, i1, i2 + 1, 0)
        
        return max(count, max(c1, c2))
    }
    
    // 2. DP Top-Down
    // Time: O(M * N * min(m, n)) -> O(N^3)
    func findLCSDPTopDown(s1: String, s2: String) -> Int {
        var dp = [[[Int?]]](repeating: [[Int?]](repeating: [Int?](repeating: 0, count: min(s1.count, s2.count)), count: s2.count), count: s1.count)
        
        return findLCSDPTopDown(s1, s2, 0, 0, 0, &dp)
    }
    
    private func findLCSDPTopDown(_ s1: String,_ s2: String,_ i1: Int, _ i2: Int,_ count: Int, _ dp: inout [[[Int?]]]) -> Int {
        if i1 == s1.count || i2 == s2.count { return count }
        
        if dp[i1][i2][count] == nil {
            var c1 = count
            if s1[i1] == s2[i2] {
                c1 = findLCSDPTopDown(s1, s2, i1 + 1, i2 + 1, count + 1, &dp)
            }
            let c2 = findLCSDPTopDown(s1, s2, i1, i2 + 1, 0, &dp)
            let c3 = findLCSDPTopDown(s1, s2, i1, i2 + 1, 0, &dp)
            dp[i1][i2][count] = max(c1, max(c2, c3))
        }
        
        return dp[i1][i2][count]!
    }
    
    // 3. DP Bottom-Up
    // Time: O(9)m*n)
    // Space: O(m * n)
    // You can improve the space -> O(N)
    func findLCSDPBottomUp(_ s1: String, _ s2: String) -> Int {
        var dp = [[Int]](repeating: [Int](repeating: 0, count: s2.count + 1), count: s1.count + 1)
        var maxVal = 0
        for i in 1...s1.count {
            for j in 1...s2.count {
                if s1[i - 1] == s2[j - 1] {
                    dp[i][j] = 1 + dp[i - 1][j - 1]
                    maxVal = max(maxVal, dp[i][j])
                }
            }
        }
        return maxVal
    }
    
}
