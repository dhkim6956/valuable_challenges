//
//  achievementsModel.swift
//  ToChallenge
//
//  Created by Yejin Lee on 2021/08/12.
//

import Foundation

struct Collectibles {
    let sectionTitle : String
    let collectList : [String]
}


class AchivementsModel {
    var arrayList: [Collectibles] = []
    init() {
        arrayList.append(Collectibles(sectionTitle: "레벨 달성", collectList: ["Level 1","Level 2","Level 3","Level 4","Level 5","Level 6"]))
        arrayList.append(Collectibles(sectionTitle: "독특한 경험", collectList: ["매번 실패", "하루도 못가"]))
    }
}
