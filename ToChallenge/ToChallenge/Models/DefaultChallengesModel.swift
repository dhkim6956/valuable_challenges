//
//  DefaultChallengesModel.swift
//  ToChallenge
//
//  Created by 김도훈 on 2021/08/20.
//

import Foundation

struct DefaultChallenge {
    let title: String                           //도전명
    let sort: challengeSort                     //나만의 도전, 일반 도전, 서바이벌 도전
    let category: challengeCategory             //자격증, 코딩, 운동, 외국어, 독서, 기타
    let description: String                     //설명
    let authenticationMethod: String            //인증방법
    let authenticationPeriod: challengePeriod   //인증주기
    let duration: Int
    var challengeAdded: Bool
    
    
    enum challengeSort {
        case userMade, normal, survival
    }

    enum challengeCategory {
        case certificate, coding, health, language, reading, etc
    }

    enum challengePeriod {
        case everyYear, everyMonth, everyDay, everyMonday, everyTuesday, everyWednesday, everyThursday, everyFriday, everySaturday, everySunday
    }
}

var DefaultChallenges: [DefaultChallenge] = {
    var challenges: [DefaultChallenge] = []
    
    challenges.append(DefaultChallenge(title: "Front-end 정복해보자", sort: .normal, category: .coding, description: "30일 동안 html, css, javascript에 대한 개념을 잡을 수 있는 과정", authenticationMethod: "Dream Coding 무료 동영상 강의를 듣고 해당 강의에서 작성한 코드를 캡쳐하여 인증", authenticationPeriod: .everyDay, duration: 30, challengeAdded: true))
    challenges.append(DefaultChallenge(title: "독후감 작성하기", sort: .normal, category: .reading, description: "한달동안 한권의 책을 읽고 독후감을 작성하여 인증하는 과정", authenticationMethod: "독후감을 작성한 후 작성 내용의 일부를 촬영하여 인증", authenticationPeriod: .everyMonth, duration: 90, challengeAdded: false))
    challenges.append(DefaultChallenge(title: "다양한 장르의 책을 한달에 1권씩 1년동안 읽기", sort: .normal, category: .reading, description: "문체부 추천도서 / 교과 연계도서를 읽고 인증하는 과정", authenticationMethod: "월 1회 독후감을 작성하거나 책의 핵심 내용을 요약하여 인증하는 과정", authenticationPeriod: .everyMonth, duration: 365, challengeAdded: true))
    challenges.append(DefaultChallenge(title: "해커스 토익 보카", sort: .normal, category: .language, description: "해커스 신 토익 보카 책을 이용하여 30일간 단어 암기하는 과정", authenticationMethod: "매일 Daily Check Up을 풀고 인증하기", authenticationPeriod: .everyDay, duration: 30, challengeAdded: false))
    challenges.append(DefaultChallenge(title: "매일 영어 일기 쓰기", sort: .normal, category: .language, description: "영어 writing 실력을 늘리기 위해 100일간 영어 일기(최소 한줄)를 쓰기를 도전해보자", authenticationMethod: "매일 영어 일기를 쓰고 쓴 내용을 사진으로 찍어 인증하기", authenticationPeriod: .everyDay, duration: 100, challengeAdded: true))
    challenges.append(DefaultChallenge(title: "하루에 1 commit", sort: .normal, category: .coding, description: "1년간 매일 코딩을 하고 git에 commit하는 습관을 만들자", authenticationMethod: "하루에 최소한번 git에 commit하고 그 내용을 캡쳐하여 인증하기", authenticationPeriod: .everyDay, duration: 365, challengeAdded: false))
    challenges.append(DefaultChallenge(title: "필기시험 4주 준비", sort: .normal, category: .certificate, description: "자격증 시험 중 필기시험만 있는 시험 준비하기", authenticationMethod: "시중에 있는 한달 과정의 문제집 등을 이용하여 1day풀고 사진찍어 인증하기", authenticationPeriod: .everyDay, duration: 28, challengeAdded: false))
    challenges.append(DefaultChallenge(title: "필기시험 2주 준비", sort: .normal, category: .certificate, description: "한국사능력검정시험, 컴활 필기 등 단기간에 준비할 수 있는 사람들을 위한 과정", authenticationMethod: "시중에 있는 2주 과정의 문제집 등을 이용하여 1day풀고 사진찍어 인증하기", authenticationPeriod: .everyDay, duration: 14, challengeAdded: false))
    challenges.append(DefaultChallenge(title: "필기 + 실기 6주 준비", sort: .normal, category: .certificate, description: "필기와 실기 시험 2가지 모두 치뤄야 하는 자격증 시험의 경우 필기 3주 + 실기3주 또는 필기 2주 + 실기 4주를 본인의 역량에 맞게 선택하여 준비", authenticationMethod: "필기 및 실기 시험 공부한 것 결과물 등을 사진으로 찍어 인증하기", authenticationPeriod: .everyDay, duration: 42, challengeAdded: false))
    challenges.append(DefaultChallenge(title: "체지방 1kg빼기", sort: .normal, category: .health, description: "근손실없이 건강하게 체지방 빼기!", authenticationMethod: "매일 근력운동 1시간 + 유산소 1시간 하기", authenticationPeriod: .everyDay, duration: 14, challengeAdded: false))
    challenges.append(DefaultChallenge(title: "다이어트 30days", sort: .normal, category: .health, description: "한달동안 꾸준한 다이어트!", authenticationMethod: "주마다 유산소 운동을 한뒤 사진으로 찍어 인증하기", authenticationPeriod: .everyDay, duration: 30, challengeAdded: false))
    challenges.append(DefaultChallenge(title: "매일 러닝 30분", sort: .normal, category: .health, description: "매일매일 30분으로 달라지는 나의 몸과 체력!", authenticationMethod: "매일 런닝을 30분간 한뒤 사진으로 찍어 인증하기", authenticationPeriod: .everyDay, duration: 28, challengeAdded: false))
    return challenges
}()
