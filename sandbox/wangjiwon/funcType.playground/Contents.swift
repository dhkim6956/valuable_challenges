import UIKit

var greeting = "Hello, playground"


func addNum (_ arg1: Int, _ arg2: Double) -> Int {
    return 0
}

let fn1: (Int, Double) -> Int = addNum

func addText (_ arg1: [String]) -> Int {
    return 0
}

let fn2: ([String]) -> Int = addText

func addTextAndNum (_ arg1: String, _ arg2: Int) -> [String: Int] {
    
    return ["Hello": 0]
}

let fn3: (String, Int) -> [String: Int] = addTextAndNum
