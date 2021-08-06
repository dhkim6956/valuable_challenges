//
//  UsersChallengesModel.swift
//  ToChallenge
//
//  Created by Yejin Lee on 2021/08/04.
//

import Foundation

struct UsersChallenge {
    let title : String
    let period : Int
    let completionDate : Int
    
    let category : category
    let certification : certification
    let type : type
    
    
    
    enum category {
        case normal, serviver
       
    }
    enum certification {
        case yes, yet
    }
    
    enum type {
        case certificate, coding, health, language, reading
    }
}


class UsersChallengesModel {
    var arrayList : [UsersChallenge] = []
    init() {
        arrayList.append(UsersChallenge(title: "단어외우기", period: 10, completionDate: 7, category: .normal, certification: .yet, type: .language))
        arrayList.append(UsersChallenge(title: "동네 한바퀴", period: 30, completionDate: 15, category: .normal, certification: .yet, type: .health))
        arrayList.append(UsersChallenge(title: "Commit 습관만들기", period: 14, completionDate: 3, category: .serviver, certification: .yes, type: .coding))
    }
}
