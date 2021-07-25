import UIKit

// (Int, Double) -> Int

func intDouble(_ arg1: Int, _ arg2: Double) -> Int {
    return arg1
}

let func1 = intDouble
func1(3, 3.14)

// ([String]) -> Int

func arrayString(_ arg:[String]) -> Int {
    return arg.count
}

let func2 = arrayString
func2(["Hi", "Hello"])

// (String, Int) -> [String: Int]

func stringInt(_ arg1:String, _ arg2:Int) -> [String: Int] {
    return [arg1: arg2]
}

let func3 = stringInt
func3("hello", 3)

func addTwoNum(_ arg1: Int, _ arg2:Int) -> Int {
    return 0
}


let addTwoclosure = {(arg1: Int, arg2: Int) -> Int in
    return arg1 + arg2
}

let addTwoclosure2 = {(arg1, arg2) -> Int in
    return arg1 + arg2
}

let addTwoclosure3 = {(arg1, arg2) -> Int in
    arg1 + arg2
}

let addTwoclosure4: (Int, Int) -> Int = {
    $0 + $1
}


// (Int, Double) -> Int

let intDoubleClosure :(Int, Double) -> Int = {(i, di) -> Int in
    return i
}

// ([String]) -> Int

let arrayStringClosure: ([String]) -> Int = {(arrayString) -> Int in
    arrayString.count
}

// (String, Int) -> [String: Int]

let stringIntClosure: (String, Int) -> [String: Int] = {(txt, num) -> [String: Int] in
    return [txt:num]
}
