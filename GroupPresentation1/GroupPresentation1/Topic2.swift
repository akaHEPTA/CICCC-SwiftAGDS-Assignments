//
//  Topic2.swift
//  GroupPresentation1
//
//  Created by Richard Cho on 2020-02-19.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

class Topic2 {
    let text = "INAHAYSTACKNEEDLEINA"
    let pattern = "NEEDLE"
    
    var pi: Array<Int>?
    
    // kmp algorithm
    func indexOf(pattern: String) -> Int {
        var j = 0;
        for i in 0 ..< text.count {
            while j > 0 && text[i] != pattern[j] { j = pi![j - 1] }
            if text[i] == pattern[j] {
                if j == pattern.count - 1 { return i - pattern.count + 1 }
                else { j += 1 }
            }
        }
        return -1
    }
    
    func getPi(pattern: String) {
        pi = Array(repeating: 0, count: pattern.count)
        var j = 0;
        for i in 1 ..< pattern.count {
            while j > 0 && pattern[i] != pattern[j] { j = pi![j - 1] }
            if pattern[i] == pattern[j] {
                j += 1
                pi![i] = j
            }
        }
    }
}
