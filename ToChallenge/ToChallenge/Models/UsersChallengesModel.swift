//
//  UsersChallengesModel.swift
//  ToChallenge
//
//  Created by Yejin Lee on 2021/08/04.
//

import Foundation
import UIKit

struct UserChallenge {
    let title: String                           //도전명
    let color: UIColor                          //도전색
    let sort: challengeSort                     //나만의 도전, 일반 도전, 서바이벌 도전
    let category: challengeCategory             //자격증, 코딩, 운동, 외국어, 독서, 기타
    let description: String                     //설명
    let authenticationMethod: String            //인증방법
    let authenticationPeriod: challengePeriod   //인증주기
    
    var progression: challengeProgression
    
    var interval: DateInterval                  //기간
    var todayStatus: authenticationStatus       //오늘 도전 상태
    var dueDates: [dueDatesStruct]              //인증기한
    var remainTry: Int                          //남은 도전 실패 횟수



    enum challengeProgression {
        case waitForStart, onGoing, succeed, failed
    }

    enum authenticationStatus {
        case authenticated, waiting, failed
    }

    enum challengeSort {
        case userMade, normal, survival
    }

    enum challengeCategory {
        case certificate, coding, health, language, reading, etc
    }

    enum challengePeriod {
        case everyYear, everyMonth, everyDay, everyMonday, everyTuesday, everyWednesday, everyThursday, everyFriday, everySaturday, everySunday
    }
    
    func getInProgressDate() -> Int {
        let calendar = Calendar.current
        
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "yyyy/MM/dd h:mm a"

        let todayInfo = calendar.dateComponents([.year, .month, .day], from: Date())
        let todayString = "\(todayInfo.year!)/\(todayInfo.month!)/\(todayInfo.day!) 11:59 PM"
        let todayDate = formatter.date(from: todayString)!
        let progressInterval = DateInterval(start: interval.start, end: todayDate)
        
        return Int(progressInterval.duration / 86400)
    }

    func getEstimatedEndDate() -> Int {
        return Int(interval.duration / 86400)
    }

    func getStartDate(yyyyMMdd: String?) -> String {
        let formatter = customDateFormat(yyyyMMdd: yyyyMMdd)
        return formatter.string(from: interval.start)
    }

    func getFinishDate(yyyyMMdd: String?) -> String {
        let formatter = customDateFormat(yyyyMMdd: yyyyMMdd)
        return formatter.string(from: interval.end)
    }
    
    func getCategory() -> String {
        switch category {
        case .certificate:
            return "자격증"
        case .coding:
            return "코딩"
        case .health:
            return "운동"
        case .language:
            return "외국어"
        case .reading:
            return "독서"
        default:
            return "기타"
        }
    }

    func getTotalAuthenticationCount() -> Int {
        dueDates.count
    }

    func getDoneAuthenticationCount() -> Int {
        var doneAuthenticationCount = 0
        for dueDate in dueDates {
            if dueDate.dueDateStatus == .authenticated {
                doneAuthenticationCount += 1
            }
        }
        return doneAuthenticationCount
    }

    func getIsHaveToDoToday() -> Bool {
        let calendar = Calendar.current
        let todayInfo = calendar.dateComponents([.weekday], from: Date())
        switch authenticationPeriod {
        case .everySunday:
            if todayInfo.weekday == 1 {
                return true
            } else {
                return false
            }
        case .everyMonday:
            if todayInfo.weekday == 2 {
                return true
            } else {
                return false
            }
        case .everyTuesday:
            if todayInfo.weekday == 3 {
                return true
            } else {
                return false
            }
        case .everyWednesday:
            if todayInfo.weekday == 4 {
                return true
            } else {
                return false
            }
        case .everyThursday:
            if todayInfo.weekday == 5 {
                return true
            } else {
                return false
            }
        case .everyFriday:
            if todayInfo.weekday == 6 {
                return true
            } else {
                return false
            }
        case .everySaturday:
            if todayInfo.weekday == 7 {
                return true
            } else {
                return false
            }
        default:
            return true
        }
    }

    func customDateFormat(yyyyMMdd: String?) -> DateFormatter {
        let customFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.timeZone = .current
            formatter.locale = .current

            if let customFormat = yyyyMMdd {
                formatter.dateFormat = customFormat
            } else {
                formatter.dateFormat = "yyyy년 MM월 dd일"
            }
            return formatter
        }()
        return customFormatter
    }

    struct dueDatesStruct {
        let date: Date
        var dueDateStatus: authenticationStatus = .waiting
        var authenticationImage: String = ""
        var authenticationReview: String = ""
    }

    init(setTitle: String, setColor: UIColor, setSort: challengeSort, setCategory: challengeCategory, setDescription: String, setAuthenticationMethod: String, setAuthenticationPeriod: challengePeriod, setStartDate: Date, setFinishDate: Date) {



        title = setTitle
        color = setColor
        sort = setSort
        category = setCategory
        description = setDescription
        authenticationMethod = setAuthenticationMethod
        authenticationPeriod = setAuthenticationPeriod

        let calendar = Calendar.current

        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "yyyy/MM/dd h:mm a"

        let startDateInfo = calendar.dateComponents([.year, .month, .day], from: setStartDate)
        let finishDateInfo = calendar.dateComponents([.year, .month, .day], from: setFinishDate)
        let startDateString = "\(startDateInfo.year!)/\(startDateInfo.month!)/\(startDateInfo.day!) 12:00 AM"
        let finishDateString = "\(finishDateInfo.year!)/\(finishDateInfo.month!)/\(finishDateInfo.day!) 11:59 PM"

        let startDate = formatter.date(from: startDateString)!
        let finishDate = formatter.date(from: finishDateString)!
        interval = DateInterval(start: startDate, end: finishDate)

        var dateForCalc = Date(timeInterval: 86399, since: startDate)
        dueDates = []
        while dateForCalc <= finishDate {
            let dateInfo = calendar.dateComponents([.year, .month, .day, .weekday], from: dateForCalc)

            switch setAuthenticationPeriod {
            case .everyYear:
                if dateInfo.month == 1 && dateInfo.day == 1 {
                    let yesterday = Date(timeInterval: -86400, since: dateForCalc)
                    dueDates.append(dueDatesStruct(date: yesterday))
                }
            case .everyMonth:
                if dateInfo.day == 1 {
                    let yesterday = Date(timeInterval: -86400, since: dateForCalc)
                    dueDates.append(dueDatesStruct(date: yesterday))
                }
            case .everyDay:
                dueDates.append(dueDatesStruct(date: dateForCalc))
            case .everySunday:
                if dateInfo.weekday == 1 {
                    dueDates.append(dueDatesStruct(date: dateForCalc))
                }
            case .everyMonday:
                if dateInfo.weekday == 2 {
                    dueDates.append(dueDatesStruct(date: dateForCalc))
                }
            case .everyTuesday:
                if dateInfo.weekday == 3 {
                    dueDates.append(dueDatesStruct(date: dateForCalc))
                }
            case .everyWednesday:
                if dateInfo.weekday == 4 {
                    dueDates.append(dueDatesStruct(date: dateForCalc))
                }
            case .everyThursday:
                if dateInfo.weekday == 5 {
                    dueDates.append(dueDatesStruct(date: dateForCalc))
                }
            case .everyFriday:
                if dateInfo.weekday == 6 {
                    dueDates.append(dueDatesStruct(date: dateForCalc))
                }
            case .everySaturday:
                if dateInfo.weekday == 7 {
                    dueDates.append(dueDatesStruct(date: dateForCalc))
                }
            }



            let tomorrow = Date(timeInterval: 86400, since: dateForCalc)
            dateForCalc = tomorrow
        }
        if setAuthenticationPeriod == .everyYear || setAuthenticationPeriod == .everyMonth {
            dueDates.append(dueDatesStruct(date: finishDate))
        }
        todayStatus = .waiting
        remainTry = 3
        if Date() < startDate {
            progression = .waitForStart
        } else {
            progression = .onGoing
        }
    }
}



let dummyPresent = Date()
let dummyFuture1 = Date(timeInterval: 86400*30, since: dummyPresent)
let dummyFuture2 = Date(timeInterval: 86400*365, since: dummyPresent)
let dummyFuture3 = Date(timeInterval: 86400*100, since: dummyPresent)


var UserChallenges: [UserChallenge] = {
    var challenges: [UserChallenge] = []
    
    challenges.append(UserChallenge(setTitle: "Front-end 정복해보자", setColor: #colorLiteral(red: 0, green: 1, blue: 0.4314159155, alpha: 1), setSort: .normal, setCategory: .coding, setDescription: "30일 동안 html, css, javascript에 대한 개념을 잡을 수 있는 과정", setAuthenticationMethod: "Dream Coding 무료 동영상 강의를 듣고 해당 강의에서 작성한 코드를 캡쳐하여 인증", setAuthenticationPeriod: .everyDay, setStartDate: dummyPresent, setFinishDate: dummyFuture1))
    challenges.append(UserChallenge(setTitle: "다양한 장르의 책을 한달에 1권씩 1년동안 읽기", setColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), setSort: .normal, setCategory: .reading, setDescription: "문체부 추천도서 / 교과 연계도서를 읽고 인증하는 과정", setAuthenticationMethod: "월 1회 독후감을 작성하거나 책의 핵심 내용을 요약하여 인증하는 과정", setAuthenticationPeriod: .everyDay, setStartDate: dummyPresent, setFinishDate: dummyFuture2))
    challenges.append(UserChallenge(setTitle: "매일 영어 일기 쓰기", setColor: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), setSort: .normal, setCategory: .language, setDescription: "영어 writing 실력을 늘리기 위해 100일간 영어 일기(최소 한줄)를 쓰기를 도전해보자", setAuthenticationMethod: "매일 영어 일기를 쓰고 쓴 내용을 사진으로 찍어 인증하기", setAuthenticationPeriod: .everyDay, setStartDate: dummyPresent, setFinishDate: dummyFuture3))
    
    return challenges
}()



func updateTodayChallengeStatus() {
    for (index,eachChallenge) in UserChallenges.enumerated() {
        switch eachChallenge.authenticationPeriod {
        case .everyYear:
            for dueDate in eachChallenge.dueDates {
                if Date() <= dueDate.date {
                    if dueDate.dueDateStatus == .authenticated {
                        UserChallenges[index].todayStatus = .authenticated
                    } else {
                        UserChallenges[index].todayStatus = .waiting
                    }
                    break
                }
            }
        case .everyMonth:
            for dueDate in eachChallenge.dueDates {
                if Date() <= dueDate.date {
                    if dueDate.dueDateStatus == .authenticated {
                        UserChallenges[index].todayStatus = .authenticated
                    } else {
                        UserChallenges[index].todayStatus = .waiting
                    }
                    break
                }
            }
        default:
            var isAuthNeededDay = false

            for dueDate in eachChallenge.dueDates {
                let calendar = Calendar.current
                let todayInfo = calendar.dateComponents([.year, .month, .day], from: Date())
                let dueDateInfo = calendar.dateComponents([.year, .month, .day], from: dueDate.date)

                if todayInfo.year == dueDateInfo.year && todayInfo.month == dueDateInfo.month && todayInfo.day == dueDateInfo.day {
                    if dueDate.dueDateStatus == .authenticated {
                        UserChallenges[index].todayStatus = .authenticated
                    } else {
                        UserChallenges[index].todayStatus = .waiting
                    }
                    isAuthNeededDay = true
                    break
                }
            }
            if isAuthNeededDay == false {
                UserChallenges[index].todayStatus = .failed
            }
        }
    }
}
