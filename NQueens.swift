//
//  NQueens.swift
//  NQueensProblem
//
//  Created by Richard Cho on 2020-02-18.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

class NQueens {
    func solveNQueens(_ n: Int) -> [[String]] {
        guard n > 0 else {
            return [[String]]()
        }
    
        var boards = [[String]]()
        var board = Array(repeating: "", count: n)
        
        dfs(&boards, &board, n, 0)
        
        return boards
    }
    
    private func dfs(_ boards: inout [[String]], _ board: inout [String], _ n: Int, _ row: Int) {
        if row == n {
            boards.append(Array(board))
            return
        }
        
        
        for col in 0..<n {
            if isValid(board, col, row) {
                board[row] = setRow(col, n)
                dfs(&boards, &board, n, row + 1)
            }
        }
    }
    
    private func isValid(_ board: [String], _ col: Int, _ row: Int) -> Bool {
        var c = -1
    
        for i in 0..<row {
            for j in 0..<board[0].count {
                if charAt(board[i], j) == "Q" {
                    c = j
                    break
                }
            }
            
            // check col
            if c == col {
                return false
            }
            
            // check diagnol
            if abs(c - col) == abs(i - row) {
                return false
            }
        }
        
        return true
    }
    
    private func charAt(_ str: String, _ index: Int) -> Character {
        return str[str.index(str.startIndex, offsetBy: index)]
    }
    
    private func setRow(_ col: Int, _ n: Int) -> String {
        var row = ""
        
        for i in 0..<n {
            if i == col {
                row.append("Q")
            } else {
                row.append("-")
            }
        }
        
        return row
    }
}
