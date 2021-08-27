//
//  ChallengeListModel.swift
//  TableviewandCollectionview
//
//  Created by 왕지원 on 2021/08/02.
//
import UIKit
import Foundation

enum ChallengeStatus {
    case onGoing, finished, failed
}

struct Challenge {
    var title: String
    var category: String
    var finishPeriod: Int // 도전 완료? 목표? 기간
//  var challengeCount: Int // 목표 횟수. (몇회까지 해야 함)
    var ongoingPeriod: Int // 도전한지 며칠 되었는지
//  var nowCount: Int // 몇번 시도 했는지.
    var startDate: String // 시작 일자
    var finishDate: String // 종료된 일자
//    var remainedCount: Int // 남은 도전 빼먹기 횟수. 3
    var status: ChallengeStatus // 현재 이 도전의 상태.
}



struct CertificationRecord {
    var title: String
    var category: String
    var challengeCount: Int
    var nowCount: Int
    var startDate: String
    var finishDate: String
    var description: String
    var status: ChallengeStatus
    var proofImage: UIImage? = UIImage(named: "Image")
}

class Challenges {
    var arraylist: [Challenge] = []

    init() {
        arraylist.append(Challenge(title: "Front-end 정복", category: "Coding", finishPeriod: 30, ongoingPeriod: 18, startDate: "2021.08.01", finishDate: "2021.08.30", status: .onGoing))
        arraylist.append(Challenge(title: "다양한 분야의 도서 읽기", category: "독서", finishPeriod: 365, ongoingPeriod: 182, startDate: "2021.01.01", finishDate: "2021.12.31", status: .onGoing))
        arraylist.append(Challenge(title: "매일 영어일기 쓰기", category: "외국어", finishPeriod: 30, ongoingPeriod: 10, startDate: "2021.08.01", finishDate: "2021.08.30", status: .onGoing))
        arraylist.append(Challenge(title: "1일 1Commit", category: "Coding", finishPeriod: 100, ongoingPeriod: 58, startDate: "2021.08.01", finishDate: "2021.08.20", status: .onGoing))
        arraylist.append(Challenge(title: "매일 러닝 30분", category: "운동", finishPeriod: 30, ongoingPeriod: 8, startDate: "2021.08.01", finishDate: "2021.08.30", status: .onGoing))
        arraylist.append(Challenge(title: "필기시험 2주 준비", category: "자격증", finishPeriod: 14, ongoingPeriod: 14, startDate: "2021.06.01", finishDate: "2021.06.15", status: .finished))
        arraylist.append(Challenge(title: "토익 영어 단어 외우기", category: "외국어", finishPeriod: 30, ongoingPeriod: 30, startDate: "2021.07.01", finishDate: "2021.07.30", status: .finished))
        arraylist.append(Challenge(title: "독후감 작성", category: "독서", finishPeriod: 30, ongoingPeriod: 30, startDate: "2021.01.01", finishDate: "2021.01.30", status: .finished))
        arraylist.append(Challenge(title: "체지방 1KG 빼기", category: "운동", finishPeriod: 14, ongoingPeriod: 14, startDate: "2021.07.15", finishDate: "2021.07.29", status: .finished))
        arraylist.append(Challenge(title: "필기+실기시험 준비", category: "자격증", finishPeriod: 45, ongoingPeriod: 45, startDate: "2020.01.01", finishDate: "2020.02.14", status: .finished))
        arraylist.append(Challenge(title: "필기시험 4주 준비", category: "자격증", finishPeriod: 30, ongoingPeriod: 30, startDate: "2021.05.01", finishDate: "2021.05.30", status: .finished))
        arraylist.append(Challenge(title: "다이어트 30일", category: "운동", finishPeriod: 30, ongoingPeriod: 30, startDate: "2021.06.01", finishDate: "2021.06.30", status: .finished))
        arraylist.append(Challenge(title: "아침 7시 기상하기", category: "자기계발", finishPeriod: 30, ongoingPeriod: 3, startDate: "2021.01.01", finishDate: "2021.01.03", status: .failed))

    }
}
    


