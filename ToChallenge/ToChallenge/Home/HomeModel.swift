//
//  HomeModel.swift
//  ToChallenge
//
//  Created by Yejin Lee on 2021/08/04.
//

import Foundation

struct HomeChallenge {
    let title : String
    let period : Int
    let completionDate : Int
    
    let category : category
    let certification : certification
    
    enum category {
        case normal, serviver
       
    }
    enum certification {
        case yes, yet
    }
}


class HomeChallengesModel {
    var arrayList : [HomeChallenge] = []
    init() {
        arrayList.append(HomeChallenge(title: "단어외우기", period: 10, completionDate: 7, category: .normal, certification: .yet))
        arrayList.append(HomeChallenge(title: "동네 한바퀴", period: 30, completionDate: 15, category: .normal, certification: .yet))
        arrayList.append(HomeChallenge(title: "Commit 습관만들기", period: 14, completionDate: 3, category: .serviver, certification: .yes))
    }
}
