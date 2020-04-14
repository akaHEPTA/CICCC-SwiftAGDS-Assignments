//
//  File.swift
//  DPProblemSet1
//
//  Created by Richard Cho on 2020-03-19.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

class ESSP {
    // 1. Naive Exhaustive search
    // Time: O(2^N)
    // Space: O(N) -> recursion call stack
    func canPartition(nums: [Int]) -> Bool {
        // for each i
        // - try with numbers at index i (if it does not exceed the sum / 2)
        // - try without number at index i (if it does not exceed the sum /2 )
        
        guard !nums.isEmpty else { return false }
        
        var sum = 0
        for num in nums {
            sum += num
        }
        
        if (sum % 2 == 1) {
            //odd
            return false
        }
        
        return calcNaive(nums, sum / 2, 0)
    }
    
    private func calcNaive(_ nums: [Int], _ targetSum: Int, _ index: Int) -> Bool {
        if targetSum == 0 { return true }
        if index == nums.count { return false }
        if targetSum >= nums[index] {
            if calcNaive(nums, targetSum - nums[index], index + 1) {
                return true
            }
        }
        return calcNaive(nums, targetSum, index + 1)
    }
    
    // 2. DP Top-Down
    // Time: O(N * S) where S is the sum if nums -> O(N)
    // Space: O(N * S) -> O(N)
    func canPartionDPTopDown(nums: [Int]) -> Bool {
        guard !nums.isEmpty else { return false }
        
        var sum = 0
        nums.forEach({ sum += $0 })
        
        // odd?
        if ((sum & 1) == 1) { return false }
        
        let halfSum = sum / 2
        var dp = [[Int]](repeating: [Int](repeating: -1, count: halfSum + 1), count: nums.count)
        
        for i in 0..<nums.count {
            for j in 0..<halfSum + 1 {
                dp[i][j] = -1
            }
        }
        
        return calcTopDown(nums, halfSum, 0, dp)
    }
    
    private func calcTopDown(_ nums: [Int], _ targetSum: Int, _ index: Int, _ dp: [[Int]]) -> Bool {
        if (targetSum == 0) { return true }
        if index == nums.count { return false }
        
        var dp = dp
        
        if dp[index][targetSum] == -1 {
            if targetSum - nums[index] >= 0 {
                if calcTopDown(nums, targetSum - nums[index], index + 1, dp) {
                    dp[index][targetSum - nums[index]] = 1
                    return true
                }
            }
            dp[index][targetSum] = calcTopDown(nums,targetSum, index + 1, dp) ? 1 : 0
        }
        
        return dp[index][targetSum] == 1
    }
    
    // 3. DP Bottom-Up
    // Time: O(N * S) where S is the sum if nums -> O(N)
    // Space: O(N * S) -> O(N)
    func canPartitionDPBottomUp(nums: [Int]) -> Bool{
        guard !nums.isEmpty else { return false }
        
        var sum = 0
        nums.forEach({ sum += $0 })
        
        if ((sum & 1) == 1) { return false }
        
        let halfSum = sum / 2
        let n = nums.count
        
        var dp = [[Bool]](repeating: [Bool](repeating: false, count: halfSum + 1), count: n)
        
        for i in 0..<n { dp [i][0] = true }
        for s in 0..<halfSum + 1 { dp[0][s] = (nums[0] == s) }
        
        for i in 1..<n {
            for s in 1..<halfSum + 1 {
                dp[i][s] = dp[i - 1][s]
                if nums[i] <= s { dp[i][s] = dp[i - 1][s - nums[i]] }
            }
        }
        
        return dp[n - 1][halfSum]
    }
    
}
