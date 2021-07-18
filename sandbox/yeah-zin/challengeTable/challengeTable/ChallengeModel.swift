//
//  ChallengeModel.swift
//  challengeTable
//
//  Created by Yejin Lee on 2021/07/18.
//

import Foundation

struct Challenge {
    let title : String
    let desc : String
    let period : Int
    let category : String
}

class ChallengesModel {
    var arrayList : [Challenge] = []
    
    init() {
        arrayList.append(Challenge(title: "단어외우기", desc: "30일간 꾸준히 단어 외우기", period: 30, category: "공부"))
        arrayList.append(Challenge(title: "동네 한바퀴", desc: "하루에 30분 동네 러닝", period: 100, category: "운동"))
        arrayList.append(Challenge(title: "Commit 습관만들기", desc: "하루에 1 commit 실천하기", period: 15, category: "공부"))
    }
}
