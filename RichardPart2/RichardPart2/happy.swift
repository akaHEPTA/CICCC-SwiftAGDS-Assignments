//
//  happy.swift
//  RichardPart2
//
//  Created by Richard Cho on 2020-03-20.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

// happyOrSadHelper()

func happyOrSadHelper() -> String {
    let str = readLine()!
    return happyOrSad(str)
}

func happyOrSad(_ s: String) -> String {
    guard s.count >= 3 else { print("none"); return "none" }
    
    var happy = 0
    var sad = 0
    
    for i in 0...(s.count - 3) {
        if s[i, i + 3] == ":-)" { happy += 1}
        else if s[i,i + 3] == ":-(" { sad += 1 }
    }
    
    var answer = ""

    if happy == 0 && sad == 0 { answer = "none"}
    if happy == sad { answer = "unsure" }
    
    if happy > sad { answer = "happy" }
    else { answer = "sad" }
    
    print(answer)
    return answer
}
