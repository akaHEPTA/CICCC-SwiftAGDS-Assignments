//
//  EnumStructClass.swift
//  IntroToSwift
//
//  Created by Richard Cho on 2020-02-06.
//  Copyright © 2020 Richard Cho. All rights reserved.
//

import Foundation
import SwiftUI

var str = "Hello, playground"

// Struct(ure) - class but "value type"
// constructor -> initializer

// instance variable -> 'property (getter, setter)'

// Access Modifiers
// - open (can override, subclass)
// - public (usually for library or framework)
// --------------------
// - internal (default)
// - fileprivate
// - private, private(set)

struct PictureFrame {
    // stored properties
    var width: Int
    var height: Int
    var Thickness: Double? // optional will be init as 'nil'
    
    // computed properties
    var area: Int {
        return width * height
    }
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
    
}

// all the properties should be initialized!

// "designated" initializer
let frame1 = PictureFrame(width: 10, height: 10)

struct Beer {
    var style = "Pale Ale"
    var percentAlcohol = 5.0
    static var cheers = [
        "English":"Cheers!",
        "German":"Prost!",
        "Spanish":"Salut!",
        "Italian":"Cin cin!",
        "Japanese":"Kanpai",
        "Mandarin":"Ganbei",
        "Korean":"Gunbae",
        "Portuguese":"Saude!"
    ]
    var suggestedVolumePerServing: String {
        get {
            let volume = Int(12.0 / (percentAlcohol / 5.0))
            return "\(volume) ounces"
        }
        
    }
    
    static func cheers (_ language: String) {
        if let message = cheers[language]{
            print(message)
        } else {
            print("I don't speak \(language)")
        }
    }
}

var happyHourBeer = Beer(style: "IPA", percentAlcohol: 8.0)
print(happyHourBeer.suggestedVolumePerServing)
Beer.cheers("German")

var sadHourBeer: Beer = happyHourBeer
sadHourBeer.percentAlcohol = 3.0

print(happyHourBeer.percentAlcohol)
print(sadHourBeer.percentAlcohol)

// Reference type (very similar to struct)
enum WineType{
    case red
    case white
    case rose
    case ice
    case sparkling
}

class Wine: CustomStringConvertible {
    var description: String {
        return "Wine: \(percentAlcohol), \(type)"
    }
    var type: WineType = .red
    var percentAlcohol = 10.0
    static var cheers = [
        "English":"Cheers!",
        "German":"Prost!",
        "Spanish":"Salut!",
        "Italian":"Cin cin!",
        "Japanese":"Kanpai",
        "Mandarin":"Ganbei",
        "Korean":"Gunbae",
        "Portuguese":"Saude!"
    ]
    
    var suggestedVolumePerServing: String {
        get {
            let volume = Int(12.0 / (percentAlcohol / 5.0))
            return "\(volume) ounces"
        }
    }
    
    static func cheers (_ language: String) {
        if let message = cheers[language]{
            print(message)
        } else {
            print("I don't speak \(language)")
        }
    }
    
    init(type: WineType, percentAlcohol: Double){
        self.type = type
        self.percentAlcohol = percentAlcohol
    }
}

let chileRed = Wine(type: .red, percentAlcohol: 13.0)
let fakeChileRed = chileRed
fakeChileRed.percentAlcohol = 20.0

print(chileRed.percentAlcohol)
print(fakeChileRed.percentAlcohol)


// Enum Associated Values (different from rawValues)
// Values that can be attached to enum cases.
// Developers can add additional information to a case.

enum PlaySpeed: Int {
    case slow, normal, fast, custom
}

// Raw values are uniqe and immutable (constant)
print(PlaySpeed.fast.rawValue)

enum AudioRate: String {
    case slow, normal, fast, custom
}

if let rate: AudioRate = AudioRate(rawValue: "slow") {
    print(rate.rawValue)
}

// Associated Value
enum ImageFilter {
    case sepia
    case verticalGradient(from: Color, to: Color)
    case horizontalGradient(from: Color, to: Color)
    case sketch(penThickness: Double?)
}

let filter1 = ImageFilter.verticalGradient(from: .black, to: .gray)
let filter2 = ImageFilter.horizontalGradient(from: .orange, to: .red)

switch filter1 {
case .sepia:
    print("sepia")
case let .verticalGradient(color1, color2):
    print("Vertical gradient from \(color1) to \(color2)")
case .horizontalGradient(var c1, _):
    c1 = .black
    print("Horizontal gradient from \(c1)")
case .sketch(let penSize):
    if let penSize = penSize{
        print("Sketching with \(penSize)")
    } else {
        print("Sketching using default thickness")
    }
default:
    print("IDK")
}

extension ImageFilter{
    var colors: (from: Color, to: Color)? {
        switch self {
        case .verticalGradient(let from, let to),.horizontalGradient(let from, let to):
            return (from, to)
        default:
            return nil
        }
    }
    
    var penThickness: Double? {
        switch self {
        case .sketch(let penThickness):
            return penThickness
        default:
            return nil
        }
    }
    
    var hasHeavyPenThickness: Bool {
        if case let ImageFilter.sketch(penThickness) = self,
            let thickness = penThickness,
            thickness > 5.0 {
            return true
        } else {
            return false
        }
    }
}

// Tuple type
let t = (from: "Hello", to: "Bye", age: 0)

if let colors = filter1.colors {
    print(colors.from)
    print(colors.to)
}

let filter3 = ImageFilter.sketch(penThickness: 10)
if let thickness = filter3.penThickness {
    print(thickness)
}

print(filter3.hasHeavyPenThickness) // true

enum HTTPResponse {
    case Success(json: String)
    case failure(error: Error)
}

// "if case" to extract associated values
if case ImageFilter.horizontalGradient(var from, let to) = filter1 {
    from = .red
    print("Horizontal gradient with \(from) and \(to)")
}

if case let ImageFilter.horizontalGradient(from, to) = filter1 {
    print("Horizontal gradient with \(from) and \(to)")
}

if case let ImageFilter.horizontalGradient(from, to) = filter1, to == .black {
    print("Horizontal gradient with \(from) and \(to)")
} // 'where' is not available



