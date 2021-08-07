//
//  ChallengeModel.swift
//  ToChallenge
//
//  Created by 왕지원 on 2021/07/28.
//

import Foundation

struct OngoingChallenge {
    var title: String
    var ongoingPeriod: Int
    var finishPeriod: Int
    var category: String
}


struct CompleteChallenge {
    var title: String
    var finishPeriod: Int
    var category: String
    var startDate: String
    var finishDate: String
}


struct FailedChallenge {
    var title: String
    var finishedPeriod: Int
    var ongoingPeriod : Int
    var cetegory: String
    var startDate: String
    var finishDate: String
}