//
//  QueensSolver.swift
//  SwiftAGDS
//
//  Created by Derrick Park on 2019-03-13.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import Foundation

/// Write a function solveQueens that accepts a Board as a parameter
/// and tries to place 8 queens on it safely.
///
/// - Your method should stop exploring if it finds a solution
/// - You are allowed to change the function header (args or return type)
/// - Your total recursive calls should not exceed 120 times.

class QueensSolver {
    let size = 8
    var board = Board(size: 8)
    var solution = 1
    var count = 0
    var isSearching = true
    
    func driver() {
        print("Problem 1.")
        solve8Queens(board: &board)
        print("\nProblem 2.")
        solve8QueensASAP(board: &board)
    }
    
    private func solve8Queens(board: inout Board, row: Int = 0) {
        if row == size {
            print("case: \(solution)\n\(board)")
            solution += 1
            return
        } else {
            for col in 0 ..< size {
                if board.isSafe(row: row, col: col) {
                    board.place(row: row, col: col)
                    solve8Queens(board: &board, row: row + 1)
                    board.remove(row: row, col: col)
                }
            }
        }
    }
    
    private func solve8QueensASAP(board: inout Board, row: Int = 0) {
        guard isSearching else { return }
        count += 1
        if row == size {
            print("\(board)")
            print("Number of recursive calls: \(count)")
            isSearching = false
            return
        } else {
            for col in 0 ..< size {
                if board.isSafe(row: row, col: col) {
                    board.place(row: row, col: col)
                    solve8QueensASAP(board: &board, row: row + 1)
                    board.remove(row: row, col: col)
                }
            }
        }
    }
}

/*
 
 base case: reached at the end (all queens are placed)
 -> print answer
 -> go upper to prev step (backtracking)
 
 case 1: isSafe == true
 -> place queen
 -> go deeper
 
 case 2: have no answer in current col anymore
 -> end w/o return
 -> go upper to prev step (backtracking)
 
 */

