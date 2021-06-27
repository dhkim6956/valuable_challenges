### 변수/값 증가 시키기

var gemCounter = 0

while !isBlocked{
    moveForward()
    if isOnGem {
        collectGem()
        gemCounter = gemCounter + 1
    }
    if isBlocked && isBlockedLeft {
        turnRight()
    }
}

### lee
var gemCounter = 0

func colGem() {
    moveForward()
    collectGem()
    gemCounter += 1
}
for i in 1 ... 5 {
    colGem()
}

### fork - pull


### 유형/올바른 포털 설정하기

var gemStone = 0

while gemStone < 4 {
    while !isBlocked {
        moveForward()
        if isOnGem {
            collectGem()
            gemStone += 1
        }
        if gemStone == 1 {
            bluePortal.isActive = false 
        }else {
            bluePortal.isActive = true
        }
        if gemStone == 2{
            pinkPortal.isActive = false
        }else{
            pinkPortal.isActive = true
        }
    }
    turnLeft()
    turnLeft()
}

