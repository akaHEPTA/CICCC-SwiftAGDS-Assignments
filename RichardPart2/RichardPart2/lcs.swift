//
//  lcs.swift
//  RichardPart2
//
//  Created by Richard Cho on 2020-03-20.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

// findLCSHelper()

func findLCSHelper() -> Int {
    let s1 = readLine()!
    let s2 = readLine()!
    return findLCS(s1, s2)
}

func findLCS(_ s1: String, _ s2: String) -> Int {
    var dp = [[Int]](repeating: [Int](repeating: 0, count: s2.count + 1), count: s1.count + 1)
    
    for i in 0..<s1.count {
        for j in 0..<s2.count {
            if s1[i] == s2[j] {
                dp[i + 1][j + 1] = 1 + dp[i][j]
            } else {
                dp[i + 1][j + 1] = max(dp[i][j + 1], dp[i + 1][j])
            }
        }
    }
    
    print(dp[s1.count][s2.count])
    return dp[s1.count][s2.count]
}
