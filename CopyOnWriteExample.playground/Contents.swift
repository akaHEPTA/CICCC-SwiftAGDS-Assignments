import Foundation

//func print(address o: UnsafeRawPointer){
//    print(String(format: "%p", Int(bitPattern: o)))
//}

// Array, Dictionary, etc (Collections)
// -> struct (value type)
// Copy-on-write feature (Swift Standard Library)
//var arr: Array<Int> = [1, 2, 3]
//var arr1 = arr
//
//print(address: arr)
//print(address: arr1)
//
//// write (mutating)
//arr1.append(5)
//
//print(address: arr1)


var name: String? = nil

func firstMatching(name:String, in names:[String]) -> String {
    TODO;
}

let matched = firstMatching(name: "Wenda", in : ["Rio", "Wenda", "Yusuke"])

// 3 different ways of "Unwrapping" optional
// 1. force unwrap (!) - bomb!
print(matched!.count)

// 2. if-let statement
if let m = matched{
    print(m)
} else {
    print("Oh, it's nil")
}

// 3. guard statement (
func curlyHell(_ name: String?, _ age: Int?, _ gender: Bool?) {
    // syntactic sugar
    guard let name = name else { return }
    guard let age = age else { return }
    guard let gender = gender else { return }
    print("\(name) \(age) \(gender)")
}

