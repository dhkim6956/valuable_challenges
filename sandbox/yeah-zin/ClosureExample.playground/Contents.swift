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




