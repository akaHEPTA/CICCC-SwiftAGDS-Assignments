import Cocoa

var str = "Hello, playground"
print(str)

func sayHello(with name: String) {
    print ("Hello, \(name)!")
}

sayHello(with: "Vancouver")


func filterInts(_ numbers: [Int], _ includeNumber: (Int) -> Bool) -> [Int] {
    var result: [Int] = []
    
    for number in numbers{
        if includeNumber(number){
            result.append(number)
        }
    }
    return result
}

