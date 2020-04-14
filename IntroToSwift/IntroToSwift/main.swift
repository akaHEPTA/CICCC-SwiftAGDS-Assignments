//
//  main.swift
//  IntroToSwift
//
//  Created by Richard Cho on 2020-02-06.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

var nonsenseArray = ["bungalow", "buffalo", "indigo", "although", "Ontario", "albino", "%$&#!"]

func combineLastCharacters(from words: [String]) -> String {
    return words.reduce(into: "") {
        if let last = $1.last { $0 += String(last) }
    }
}

print(combineLastCharacters(from: nonsenseArray))

