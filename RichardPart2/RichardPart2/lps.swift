//
//  lps.swift
//  RichardPart2
//
//  Created by Richard Cho on 2020-03-20.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

// findLPSHelper()

func findLPSHelper() -> Int {
    let s = readLine()!
    return findLPS(s)
}

func findLPS(_ str: String) -> Int {
    let n = str.count
    var dp = [[Bool]](repeating: [Bool](repeating: false, count: n), count: n)
    var maxLength = 1
    
    for i in 0..<n { dp[i][i] = true }
    
    for i in 0..<n - 1 {
        if str[i] == str[i + 1] {
            dp[i][i + 1] = true
            maxLength = 2
        }
    }
    
    for k in 3...n {
        for i in 0..<n - k + 1 {
            let j = i + k - 1
            if dp[i + 1][j - 1] && str[i] == str[j] {
                dp[i][j] = true
                if k > maxLength {
                    maxLength = k
                }
            }
        }
    }
    
    print(maxLength)
    return maxLength
}
