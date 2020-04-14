//: # Strings

import UIKit
import Foundation

//: ## Defining Strings using string literals
let myFirstString = "mo 💰" // string literals
let mySecondString = "mo\' problems"

//: ## String concatenation
let theTruth = myFirstString + ", " + mySecondString
let theTruth2 = "\(myFirstString), \(mySecondString)"

let theTruth3 = "💰 can't buy me 💖."

let theBaseballTeamInAtlanta = "Atlanta Braves"
var jamesFavoriteBaseballTeam = "Atlanta Braves"

var nWithTilde = "ca\u{006E}\u{0303} not"
print(nWithTilde)

// String.Index
let startIndex = nWithTilde.startIndex
let spaceIndex = nWithTilde.firstIndex(of: " ")!
print(nWithTilde[startIndex..<spaceIndex])
nWithTilde.unicodeScalars.count
nWithTilde.count


//: ## Emoji characters
let similarTruth = "💰can't buy me 💖"

// Here's one way to initialize an empty Swift string
var characterPoorString = ""

// And here's another 
let potentialRichString = String()


//: ## String interpolation

//: ### Plain string

var doggyDiet = "Lulu eats 25lbs of dog food per month"
//: ### String with variables
var dogName = "Ferris"
var ferrisPic = UIImage(named:"Springerdoodle\(dogName).jpg")!
doggyDiet = "\(dogName) eats 25lbs of dog food per month"

//: ### String with variables and expression
var lbsPerDay = 0.75
var daysPerMonth: Double = 30.0
doggyDiet = "\(dogName) eats 🇨🇦?lbs of dog food per month"

var frankiePic = UIImage(named:"frankie.jpeg")!
lbsPerDay = 0.25
dogName = "Lil Frankie"
doggyDiet = "\(dogName) eats ?lbs of dog food per month"
//: ## A String isn't just a String

//: ### Through the .characters property we can access an array of characters
var password = "Meet me in St. Louis"
for ch in password {
    if ch == "e" {
        print("found an e!")
    }
}

//: ### A String can be treated as an NSString
let newPassword = password.replacingOccurrences(of: "e", with: "3")

// Swift (new) <-> Objective-C (old)
// NSString -> Objective-C
// convert NSString -> String(NSString)




