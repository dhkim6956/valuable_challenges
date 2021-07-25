// 문제1
// 3의 배수를 찾고 +1을 하여 배열에 넣으세요.
// filter, map

let array = [1,2,3,4,5,6,7,8,9]
var retArray: [Int] = []

for  i in array {
    if i % 3 == 0 {
        retArray.append(i+1)
    }
}

print(retArray)

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


// 문제2
// 앞에 만들어진 결과 array(retArray)의 모든 수 합을 구하세요.
// reduce

var ret = 0

for i in retArray {
    ret += i
}

print(ret)

let ret4 = retArray2.reduce(0) {(preInt, num) -> Int in
    return preInt + num
}

print(ret4)


// 도훈님 문제

let index: [Int] = [1, 2, 3, 4, 5]
var filteredEx: [Int] = []


for indexLoop in index {
    if indexLoop % 2 == 0 {
        filteredEx.append(indexLoop)
    }
}

let filteredEx2 = index.filter({(item:Int) -> Bool in
    return item % 2 == 0
})

print(filteredEx2)

// 지원님 문제
//정해진 숫자까지 곱하기 2의 합

let num = 5
var ret2 = 0

for i in 1...num {
   ret2 += i * 2
}

print(ret2)

let ret3 = Array(Range(1...num)).reduce(0) {(preInt, num) -> Int in
    return preInt + (num * 2)
}
print(ret3)



let filtered = index.filter({(indexLoop: Int) -> Bool in
    return indexLoop % 2 == 0
})
