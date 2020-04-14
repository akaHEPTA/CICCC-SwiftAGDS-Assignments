import Foundation

// Closures
// - global functions, nested functions, and "closure expressions"

// syntax
// (parameters, ... ) -> (return type)

func someFunc() -> ((Int) -> String) {
    var name = "Diego"
    // nested function
    func makeTacos(num: Int) -> String {
        let chef = name
        return chef
    }
    return makeTacos
}

let diego = someFunc()(10)
print(diego)

// Closure Expression
// - unnamed, self-contained block of code that you can call like a function

var makeSushi: (String) -> () = { (chef: String) -> () in
    print("\(chef) is making sushi for me!")
    
}
makeSushi("Rick")

var makeSushi2: (String) -> () = { (chef) in
    print("\(chef) is making sushi for me!")
}

makeSushi2("Yusuke")

var makeSushi3: (String) -> () = {
    print("\($0) is making sushi for me!")
}

makeSushi3("Yusuke")


func getFish(_ address: String, kindOf fish: String, completion: (String) -> ()) {
    // goto address // Network call
    print("go to \(address) and buy \(fish)")
    // when it's done, call completetion()
    completion(fish)
}

getFish("https://japanfishmarket.jp", kindOf: "Tuna") { (fish) in
    print("Make \(fish) sushi")
}

// Higher-order Functions
// functions that take functions or return functions
// .filter
// .map
// .reduce
// .sort

var scores = [48.1, 75.4, 63.7, 52.4, 68.2]
// full form
scores.sort { (score1, score2) -> Bool in
    return score1 < score2
}
// simplified
scores.sort { $0 < $1 }
print(scores)

let passed = scores.filter { $0 > 70 }
print(passed)

// How to write my own filter function?
let doubled = scores.map { $0 * 2 }
print(doubled)
