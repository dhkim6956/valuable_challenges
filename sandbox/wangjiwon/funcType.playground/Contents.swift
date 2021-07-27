import UIKit

var greeting = "Hello, playground"


func addNum (_ arg1: Int, _ arg2: Double) -> Int {
    return 0
}

//클로저 타입 추가
let addNumClosure: (Int, Double) -> Int = {(_ arg1: Int, _ arg2: Double) -> Int in
    return 0

}

let fn1: (Int, Double) -> Int = addNum

func addText (_ arg1: [String]) -> Int {
    return 0
}
    
let addTextClosure: ([String]) -> Int = {(_ arg1: [String]) -> Int in
    return 0
}

let fn2: ([String]) -> Int = addText

func addTextAndNum (_ arg1: String, _ arg2: Int) -> [String: Int] {
    
    return ["Hello": 0]
}
let addTextAndNumClosure: (String, Int) -> [String: Int] = { (_ arg1: String, _ arg2: Int) -> [String: Int] in
    return ["String1" :  1]
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



func sayHi() -> String {
    return "Hi"
}

let ret = sayHi()

func sayHi2( handler: (String) -> Void) {
    handler("Hi")
}


//sayHi2 코드 호출하는 법 (1)
let fn: (String) -> Void = { (arg: String) -> Void in
    print(arg)
}

sayHi2(handler: fn)

//sayHi2 코드 호출하는 법 (2)
sayHi2(handler: { (arg: String) -> Void in
    print(arg)
})


//sayHi2 코드 호출하는 법 (3)
sayHi2 { (arg: String)  in
    print(arg)
}


//연습
func sayHello( handler: (String) -> Void) {
    handler ("Hello")
}

//1번방법
let fn123: (String) -> Void = { (arg: String) -> Void in
    print(arg)
}

sayHello(handler: fn123)

//2번방법
sayHello(handler: { (erg: String) -> Void in
    print(erg)
})

//3번방법
sayHello{ (erg: String) in
    print(erg)
}
