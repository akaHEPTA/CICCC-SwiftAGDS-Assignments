//
//  main.swift
//  FileCrawler
//
//  Created by Richard Cho on 2020-02-14.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation

let fileManager = FileManager()

let desktopPath = "/home/daniel/Swift"
let ideaPath = "/Users/Ricky/Workspace/IdeaProjects"

let rootPath = "/"
let selectedPath = fileManager.currentDirectoryPath

var totalFiles = 0
var totalDirectories = 0

func tree(_ path: String, _ depth: Int = 0, _ totalFiles: inout Int, _ totalDirectories: inout Int, _ isLastDir: [Bool] = []) -> (files: Int, directories: Int) {
    do {
        let contents = try fileManager.contentsOfDirectory(atPath: path).sorted()
        
        for entry in 0 ..< contents.count {
            let newpath = path + "/" + contents[entry]
            var isFolder: ObjCBool = false;
            _ = fileManager.fileExists(atPath: newpath, isDirectory: &isFolder)
            if isFolder.boolValue {
                totalDirectories += 1
                for index in 0 ..< depth { 
                    if isLastDir[index] == true {
                        print("    ", terminator: "")
                    } else{
                        print("│   ", terminator: "") 
                    }
                }
                var auxLastDir = isLastDir
                if entry == contents.count - 1 { 
                    print("└─ \(contents[entry])")    
                    auxLastDir.append(true);
                } else { 
                    print("├─ \(contents[entry])")    
                    auxLastDir.append(false); 
                }
                _ = tree(newpath, depth + 1, &totalFiles, &totalDirectories,auxLastDir)
            } else {
                totalFiles += 1
                for index in 0 ..< depth { 
                    if isLastDir[index] == true {
                        print("    ", terminator: "")
                    } else{
                        print("│   ", terminator: "") 
                    }
                }
                if entry == contents.count - 1 { 
                    print("└─ \(contents[entry])") 
                } else { 
                    print("├─ \(contents[entry])") 
                }
            }
        }
    } catch let error as NSError {
        print("Error access directory: \(error)")
    }
    return (totalFiles, totalDirectories)
}

if CommandLine.arguments.count >= 2 {
    print(CommandLine.arguments)
    switch CommandLine.arguments[1] {
    // option s(pecify): set path manually
    case "-s":
        if CommandLine.arguments.count == 3 {
            print(tree(CommandLine.arguments[2], 0, &totalFiles, &totalDirectories))
        } else {
            print("Path is missing")
        }
    // option r(oot): set path as root
    case "-r":
        print(tree(rootPath, 0, &totalFiles, &totalDirectories))
    case "-h":
        print("options:")
        print("-s [specify]: set path manually by following order")
        print("-r [root]: set path as root")
        print("-h [help]: show this option information")
    default:
        print("Undefined option")
    }
} else {
    print(tree(selectedPath, 0, &totalFiles, &totalDirectories))
}
