let array = [1,2,3,4,5]

// 3보다 큰 원소
let fn: (Int) -> Bool = { (item:Int) -> Bool in
    if item > 3{
        return true
    } else {
        return false
    }
}
array.filter({ (item:Int) -> Bool in
    if item > 3{
        return true
    } else {
        return false
    }
})

let retFilter = array.filter {item in
    return item > 3
}

// map -2
let fn2: (Int) -> String = {(item) -> String in
    return "item \(item)"
}

array.map {(item) -> String in
    return "item \(item)"
}

let retReduce = array.reduce("") {(prevRet: String, item: Int) -> String in
    return prevRet + "\(item)"
}

array.filter {item in
    item % 2 == 1
}.reduce("") {(prevRet, item) in
    prevRet + "\(item)"
}



let retArray2 = array.filter({(item:Int) -> Bool in
                if item % 3 == 0 {
                    return true
                } else {
                    return false
                }
}).map {(item) -> Int in
    return item + 1
}

print(retArray2)

let ret = retArray2.reduce(0) {(preInt, item) -> Int in
    return preInt + item
}

print(ret)
