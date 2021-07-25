import UIKit

func intAndDouble(_ getInt: Int, _ getDouble: Double) -> Int {
    return 0
}

let iAD: (Int, Double) -> Int = {(getInt: Int, getDouble: Double) -> Int in
    return 0
}

func stringArray(_ getStringArray: [String]) -> Int {
    return 0
}

let sA: ([String]) -> Int = {(getStringArray: [String]) -> Int in
    return 0
}

func stringAndInt(_ getString: String, getInt: Int) -> [String: Int] {
    return ["String0":0, "String1":1]
}

let sI: (String, Int) -> [String : Int] = { (_ getString: String, getInt: Int) -> [String: Int] in
    return ["String0":0, "String1":1]
}
