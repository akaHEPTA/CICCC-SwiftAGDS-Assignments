//
//  main.swift
//  ProblemSetDP
//
//  Created by Richard Cho on 2020-03-12.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

// 1. Climbing Stairs (LeetCode)
func climbStairs(_ n: Int) -> Int {
    guard n > 0 else { return 0 }
    var stairs = [Int](repeating: 0, count: n)
    stairs[0] = 1; stairs[1] = 2
    if n > 2 { for i in 2..<n { stairs[i] = stairs[i - 2] + stairs[i - 1] } }
    return stairs[n - 1]
}

// 2. Make One
func makeOne(_ x: Int) -> Int {
    var d = [Int](repeating: 0, count: x + 1)
    for i in 2...x {
        d[i] = d[i - 1] + 1
        if i % 2 == 0 && d[i] > d[i / 2] + 1 { d[i] = d[i / 2] + 1 }
        if i % 3 == 0 && d[i] > d[i / 3] + 1 { d[i] = d[i / 3] + 1 }
    }
    return d[x]
}

// 3. 2 * N tiles
func twoTimesNTiles(_ n: Int) -> Int {
    guard n > 0 else { return 0 }
    var arr = [Int](repeating: 0, count: n)
    arr[0] = 1; arr[1] = 2
    if n > 2 { for i in 2..<n { arr[i] = arr[i - 2] + arr[i - 1] } }
    return arr[n - 1]
}

// 4. 2 * N titles - 2
func twoTimesNTiles2(_ n: Int) -> Int {
    guard n > 0 else { return 0 }
    var arr = [Int](repeating: 0, count: n)
    arr[0] = 1; arr[1] = 3
    if n > 2 { for i in 2..<n { arr[i] = arr[i - 2] * 2 + arr[i - 1] } }
    return arr[n - 1]
}

// 5. One Two Three
func oneTwoThree() {
    let t = Int(readLine()!)!
    var cases = [Int]()
    for _ in 0..<t { cases.append(Int(readLine()!)!) }
    
    for n in cases {
        var arr: [Int]
        if n < 4 {
            arr = [Int](repeating: 0, count: 4)
            arr[1] = 1; arr[2] = 2; arr[3] = 4
        } else {
            arr = [Int](repeating: 0, count: n + 1)
            arr[1] = 1; arr[2] = 2; arr[3] = 4
            for i in 4...n { arr[i] = arr[i - 1] + arr[i - 2] + arr[i - 3] }
        }
        print(arr[n])
    }
}

// 6. Pretty Number
func prettyNumber() {
    let n = Int(readLine()!)!
    guard 1 <= n && n <= 100 else { print(-1); return }
    
    if n == 1 { print(9); return }
    
    var d = [[Int]](repeating: [Int](repeating: 0, count: 10), count: n + 1)
    for i in 1...9 { d[1][i] = 1 }
    for i in 2...n {
        for j in 0...9 {
            if j - 1 >= 0 { d[i][j] += d[i - 1][j - 1] }
            if j + 1 <= 9 { d[i][j] += d[i - 1][j + 1] }
        }
    }
    
    var result = 0
    for i in 0...9 { result += d[n][i] }
    print(result)
}

// 7. Non-decreasing Digits
func nonDecreasingDigits() {
    let n = Int(readLine()!)!
    guard 1 <= n && n <= 1000 else { print(-1); return }
    if n == 1 { print(10); return }
    
    var d = [[Int]](repeating: [Int](repeating: 0, count: 10), count: n + 1)
    for i in 1...9 { d[1][i] = 1 }
    for i in 2...n {
        d[i][0] = 1
        for j in 1...9 { d[i][j] = d[i - 1][j] + d[i][j - 1] }
    }
    
    let result = d[n].reduce(0, { $0 + $1 })
    print(result)
}

// 8. Longest Increasing Subsequence (LeetCode)
func lengthOfLIS(_ nums: [Int]) -> Int {
    guard nums.count > 1 else { return nums.count }
    
    var d = [Int](repeating: 1, count: nums.count)
    for i in 1..<nums.count {
        for j in 0..<i {
            if nums[j] < nums[i] {
                if d[j] + 1 > d[i] {
                    d[i] = d[j] + 1
                }
            }
        }
    }
    
    return d.max()!
}

// 9. Sum of Square Numbers (LeetCode)
func judgeSquareSum(_ c: Int) -> Bool {
    let max = Int(Double(c).squareRoot())
    
    for i in 0...max {
        let t = c - i * i
        let j = Int(Double(t).squareRoot())
        if j * j == c - i * i { return true }
    }
    
    return false
}

// 10. Sum of Square Numbers - 2
func sumOfSquareNumbers2 (_ n: Int) -> Int {
    guard 1 <= n && n <= 100000 else { return -1 }
    
    if n == 1 { return 1 }
    
    var d = [Int](repeating: 0, count: n + 1)
    for i in 0...n { d[i] = i }
    
    for i in 2...n {
        var j = 2
        while j * j <= i {
            d[i] = min(d[i], d[i - j * j] + 1)
            j += 1
        }
    }
    
    return d[n]
}

// 11. Pokemon
func pokemon() -> Int {
    let firstLine = readLine()!.split(separator: " ").compactMap{ Int($0) }
    let N = firstLine[0], M = firstLine[1]
    var grid = [[Int]](), sumGrid = [[Int]](repeating: [Int](repeating: -1, count: M), count: N)
    for _ in 0..<N { grid.append(readLine()!.split(separator: " ").compactMap{ Int($0) }) }
    
    sumGrid[N - 1][M - 1] = grid[N - 1][M - 1]
    
    for i in stride(from: N - 1, through: 0, by: -1) {
        for j in stride(from: M - 1, through: 0, by: -1) {
            let val = sumGrid[i][j]
            if i - 1 >= 0 && sumGrid[i - 1][j] < val + grid[i - 1][j] { sumGrid[i - 1][j] = val + grid[i - 1][j] }
            if j - 1 >= 0 && sumGrid[i][j - 1] < val + grid[i][j - 1] { sumGrid[i][j - 1] = val + grid[i][j - 1] }
        }
    }
    
    return sumGrid[0][0]
}

// 12. Decode Ways
func numDecodings(_ s: String) -> Int {
    guard !s.isEmpty else { return 0 }
    let s = s.compactMap({ Int(String($0)) })
    var d = [Int](repeating: 0, count: s.count)
    d[0] = (s[0] != 0) ? 1 : 0
    
    for i in 1..<s.count {
        let crt = s[i]
        let prev = s[i - 1]
        if 1 <= crt && crt <= 9 { d[i] = d[i - 1] }
        if (prev == 1 && 0 <= crt && crt <= 9) || (prev == 2 && 0 <= crt && crt <= 6) { d[i] += (i >= 2) ? d[i - 2] : 1 }
    }
    
    return d[s.count - 1]
}

// 13. Maximam Subarray
func maxSubArray(_ nums: [Int]) -> Int {
    let n = nums.count
    var d = [Int](repeating: 0, count: n)
    
    d[0] = nums[0]
    var maxVal = d[0]
    
    for i in 1..<n {
        d[i] = max(nums[i] + d[i - 1], nums[i])
        maxVal = max(maxVal, d[i])
    }
    
    return maxVal
}

// 14. Edit Distance
func minDistance(_ word1: String, _ word2: String) -> Int {
    // TODO
    return 0
}

// 15. Text Justification
func fullJustify(_ words: [String], _ maxWidth: Int) -> [String] {
    // TODO
    return [""]
}
