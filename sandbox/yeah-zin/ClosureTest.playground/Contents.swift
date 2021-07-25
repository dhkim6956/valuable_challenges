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


// 문제2
// 앞에 만들어진 결과 array(retArray)의 모든 수 합을 구하세요.
// reduce

var ret = 0

for i in retArray {
    ret += i
}

print(ret)
