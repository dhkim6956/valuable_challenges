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







func addTwoNum(_ arg1: Int, _arg2: Int) -> Int {
    return 0
}

//파라미터 타입 선언 생략
let addTwoNumClosure: (Int, Int) -> Int = { (arg1, arg2) -> Int in
    return arg1 + arg2
}

//리턴타입 선언 생략
let addTwoNumClosure2: (Int, Int) -> Int  = { (arg1, arg2) in
    
    return arg1 + arg2
}

// 리턴 생략
let addTwoNumClosure3: (Int, Int) -> Int = { (arg1, arg2) in
    0
}




