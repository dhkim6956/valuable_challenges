//
//  ChallengeListModel.swift
//  TableviewandCollectionview
//
//  Created by 왕지원 on 2021/08/02.
//

import Foundation
import UIKit


///  도전 상태.
enum ChallengeStatus {
    case onGoing, finished, failed
}

struct Challenge {
    var title: String
    var category: String
    
    var finishPeriod: Int // 도전 완료? 목표? 기간
//    var challengeCount: Int // 목표 횟수. (몇회까지 해야 함)
    
    var ongoingPeriod: Int // 도전한지 며칠 되었는지
//    var nowCount: Int // 몇번 시도 했는지.
    
    var startDate: String // 시작 일자
    var finishDate: String // 종료된 일자
//    var remainedCount: Int // 남은 도전 빼먹기 횟수. 3
    
    var status: ChallengeStatus // 현재 이 도전의 상태.
}

let c1 = [Challenge(title: "깃 능력 올리기", category: "개발", finishPeriod: 10, ongoingPeriod: 0, startDate: "", finishDate: "", status: .onGoing),
          Challenge(title: "깃 능력 올리기", category: "개발", finishPeriod: 10, ongoingPeriod: 0, startDate: "", finishDate: "", status: .finished),
          Challenge(title: "깃 능력 올리기", category: "개발", finishPeriod: 10, ongoingPeriod: 0, startDate: "", finishDate: "", status: .failed),
          Challenge(title: "깃 능력 올리기", category: "개발", finishPeriod: 10, ongoingPeriod: 0, startDate: "", finishDate: "", status: .onGoing),
          Challenge(title: "깃 능력 올리기", category: "개발", finishPeriod: 10, ongoingPeriod: 0, startDate: "", finishDate: "", status: .failed),
          Challenge(title: "깃 능력 올리기", category: "개발", finishPeriod: 10, ongoingPeriod: 0, startDate: "", finishDate: "", status: .finished),
          Challenge(title: "깃 능력 올리기", category: "개발", finishPeriod: 10, ongoingPeriod: 0, startDate: "", finishDate: "", status: .onGoing)
          ]


//struct ChallengeListModel{
//    var challenges: String
//}

//struct OngoingChallenge {
//    var title: String
//    var ongoingPeriod:Int
//    var finishPeriod: Int
//    var category: String
//}
//
//
//struct CompleteChallenge {
//    var title: String
//    var finishPeriod: Int
//    var category: String
//    var startDate: String
//    var finishDate: String
//}
//
//struct FailedChallenge {
//    var title: String
//    var finishPeriod: Int
//    var ongoingPeriod : Int
//    var category: String
//    var startDate: String
//    var finishDate: String
//}


class Challenges {
    var arraylist: [Challenge] = []
    var originalList: [Challenge] = []
    
    init() {
        originalList.append(Challenge(title: "Front-end 정복", category: "Coding", finishPeriod: 30, ongoingPeriod: 14, startDate: "2021.08.01", finishDate: "2021.08.20", status: .onGoing))
        originalList.append(Challenge(title: "다양한 분야의 도서 읽기", category: "독서", finishPeriod: 189, ongoingPeriod: 365, startDate: "2021.01.01", finishDate: "2021.12.31", status: .onGoing))
        originalList.append(Challenge(title: "매일 영어일기 쓰기", category: "외국어", finishPeriod: 100, ongoingPeriod: 23, startDate: "2021.07.01", finishDate: "2021.10.08", status: .onGoing))
        originalList.append(Challenge(title: "1일 1Commit", category: "Coding", finishPeriod: 100, ongoingPeriod: 58, startDate: "2021.08.01", finishDate: "2021.11.08", status: .onGoing))
        originalList.append(Challenge(title: "매일 러닝 30분", category: "운동", finishPeriod: 30, ongoingPeriod: 8, startDate: "2021.08.15", finishDate: "2021.09.14", status: .onGoing))
        originalList.append(Challenge(title: "필기시험 2주 준비", category: "자격증", finishPeriod: 14, ongoingPeriod: 14, startDate: "2021.01.01", finishDate: "2021.01.15", status: .finished))
        originalList.append(Challenge(title: "아침 7시 기상", category: "자기계발", finishPeriod: 30, ongoingPeriod: 3, startDate: "2021.01.01", finishDate: "2021.01.03", status: .failed))
    
    }
}
//class OngoingChallnegeModel {
//    var arraylist: [OngoingChallenge] = []
//    var originalList: [OngoingChallenge] = []
//
//    init() {
//        originalList.append(OngoingChallenge(title: "Front-end 정복", ongoingPeriod: 14, finishPeriod: 30, category: "Coding", status: .failed))
//        originalList.append(OngoingChallenge(title: "다양한 분야의 도서 읽기", ongoingPeriod: 189, finishPeriod: 365, category: "독서",status: .onGoing))
//        originalList.append(OngoingChallenge(title: "매일 영어일기 쓰기", ongoingPeriod: 23, finishPeriod: 100, category: "외국어", status: .finished))
//        originalList.append( OngoingChallenge(title: "1일 1commit", ongoingPeriod: 58, finishPeriod: 100, category: "Coding", status: .finished))
//        originalList.append(OngoingChallenge(title: "매일 러닝 30분", ongoingPeriod: 8, finishPeriod: 30, category: "운동", status: .onGoing))
//
//    }
//}
//
//class FinishedChallengeModel {
//    var arraylist: [FinishedChallenge] = []
//    init() {
//        arraylist.append(FinishedChallenge(title: "필기시험 2주 준비", finishPeriod: 14, category: "자격증", startDate: "2021.06.01", finishDate: "2021.01.15"))
//        arraylist.append(FinishedChallenge(title: "토익영어단어 외우기", finishPeriod: 30, category: "외국어", startDate: "2021.07.01", finishDate: "2021.07.30"))
//        arraylist.append(FinishedChallenge(title: "독후감 작성", finishPeriod: 30, category: "독서", startDate: "2021.08.01", finishDate: "2021.08.30"))
//        arraylist.append(FinishedChallenge(title: "체지방 1kg 빼기", finishPeriod: 14, category: "운동", startDate: "2021.07.15", finishDate: "2021.07.29"))
//        arraylist.append(FinishedChallenge(title: "필기+실기시험 준비", finishPeriod: 45, category: "자격증", startDate: "2021.06.15", finishDate: "2021.07.30"))
//        arraylist.append(FinishedChallenge(title: "필기시험 4주 준비", finishPeriod: 30, category: "자격증", startDate: "2022.01.01", finishDate: "2022.01.30"))
//        arraylist.append( FinishedChallenge(title: "다이어트 30일", finishPeriod: 30, category: "운동", startDate: "2022.01.01", finishDate: "2020.01.30"))
//    }
//}
//
//
//class FailedChallengeModel {
//    var arraylist: [FailedChallenge] = []
//    init() {
//        arraylist.append( FailedChallenge(title: "아침 7시 기상", finishPeriod: 30, ongoingPeriod: 3, category: "자기계발", startDate: "2021.01.01", finishDate: "2021.01.03"))
//    }
//}
//

