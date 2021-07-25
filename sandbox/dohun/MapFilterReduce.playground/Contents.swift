import UIKit

let index: [Int] = [1, 2, 3, 4, 5]
var filteredEx: [Int] = []


for indexLoop in index {
    if indexLoop % 2 == 0 {
        filteredEx.append(indexLoop)
    }
}


var filtered: [Int] = []

filtered.filter({(indexLoop: Int) -> Bool in
    return indexLoop % 2 == 0
})
