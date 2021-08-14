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


struct FinishedChallenge {
    var title: String
    var finishPeriod: Int
    var category: String
    var startDate: String
    var finishDate: String
}


struct FailedChallenge {
    var title: String
    var finishPeriod: Int
    var ongoingPeriod : Int
    var category: String
    var startDate: String
    var finishDate: String
}


class OngoingChallnegeModel {
    var arraylist: [OngoingChallenge] = []
    init() {
        arraylist.append(OngoingChallenge(title: "Front-end 정복", ongoingPeriod: 14, finishPeriod: 30, category: "Coding"))
        arraylist.append(OngoingChallenge(title: "다양한 분야의 도서 읽기", ongoingPeriod: 189, finishPeriod: 365, category: "독서"))
        arraylist.append(OngoingChallenge(title: "매일 영어일기 쓰기", ongoingPeriod: 23, finishPeriod: 100, category: "외국어"))
        arraylist.append( OngoingChallenge(title: "1일 1commit", ongoingPeriod: 58, finishPeriod: 100, category: "Coding"))
        arraylist.append(OngoingChallenge(title: "매일 러닝 30분", ongoingPeriod: 8, finishPeriod: 30, category: "운동"))
        
    }
}

class FinishedChallengeModel {
    var arraylist: [FinishedChallenge] = []
    init() {
        arraylist.append(FinishedChallenge(title: "필기시험 2주 준비", finishPeriod: 14, category: "자격증", startDate: "2021.06.01", finishDate: "2021.01.15"))
        arraylist.append(FinishedChallenge(title: "토익영어단어 외우기", finishPeriod: 30, category: "외국어", startDate: "2021.07.01", finishDate: "2021.07.30"))
        arraylist.append(FinishedChallenge(title: "독후감 작성", finishPeriod: 30, category: "독서", startDate: "2021.08.01", finishDate: "2021.08.30"))
        arraylist.append(FinishedChallenge(title: "체지방 1kg 빼기", finishPeriod: 14, category: "운동", startDate: "2021.07.15", finishDate: "2021.07.29"))
        arraylist.append(FinishedChallenge(title: "필기+실기시험 준비", finishPeriod: 45, category: "자격증", startDate: "2021.06.15", finishDate: "2021.07.30"))
        arraylist.append(FinishedChallenge(title: "필기시험 4주 준비", finishPeriod: 30, category: "자격증", startDate: "2022.01.01", finishDate: "2022.01.30"))
        arraylist.append( FinishedChallenge(title: "다이어트 30일", finishPeriod: 30, category: "운동", startDate: "2022.01.01", finishDate: "2020.01.30"))
    }
}


class FailedChallengeModel {
    var arraylist: [FailedChallenge] = []
    init() {
        arraylist.append( FailedChallenge(title: "아침 7시 기상", finishPeriod: 30, ongoingPeriod: 3, category: "자기계발", startDate: "2021.01.01", finishDate: "2021.01.03"))
    }
}
