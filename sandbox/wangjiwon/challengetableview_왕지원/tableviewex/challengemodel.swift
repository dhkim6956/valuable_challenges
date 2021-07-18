//
//  challengemodel.swift
//  tableviewex
//
//  Created by 왕지원 on 2021/07/18.
//

import Foundation
import CoreLocation

struct challenge {
    let title: String
    let period: String
    let description: String
    let category: String
}

class challengemodel {
    var arraylist: [challenge]
    
    init() {
        arraylist = []
        
        arraylist.append(challenge(title: "독후감작성", period: "30일", description: "1달동안 책 1권 읽고 독후감 작성하기", category: "독서"))
        arraylist.append(challenge(title: "단어외우기", period: "30일", description: "토익영어단어 외우기", category: "언어공부"))
    }
    
    
    
}
