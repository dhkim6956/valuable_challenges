//
//  UsersChallengesModel.swift
//  ToChallenge
//
//  Created by Yejin Lee on 2021/08/04.
//

import Foundation
import UIKit

var documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]


struct UserChallenge: Codable {
    let title: String                           //도전명
    let color: uiColorInRGB                     //도전색
    let sort: challengeSort                     //나만의 도전, 일반 도전, 서바이벌 도전
    let category: challengeCategory             //자격증, 코딩, 운동, 외국어, 독서, 기타
    let description: String                     //설명
    let authenticationMethod: String            //인증방법
    let authenticationPeriod: challengePeriod   //인증주기
    
    var progression: challengeProgression       //도전 상태 : 시작전, 진행중, 성공함, 실패함
    
    var interval: DateInterval                  //기간
    var todayStatus: authenticationStatus       //인증 상태 : 인증, 대기중
    var dueDates: [dueDatesStruct]              //인증기한
    var remainTry: Int                          //남은 도전 실패 횟수
    
    var originalIndex: Int                     //유저 챌린지 고유 번호
    

    
    //오늘 - 시작일
    func getInProgressDate() -> Int {
        let progressInterval = DateInterval(start: interval.start, end: today.end)
        
        return Int(progressInterval.duration / 86400) + 1
    }
    
    //종료일 - 시작일
    func getEstimatedEndDate() -> Int {
        return Int(interval.duration / 86400) + 1
    }

    //시작일
    func getStartDate(yyyyMMdd: String?) -> String {
        let formatter = customDateFormat(yyyyMMdd: yyyyMMdd)
        return formatter.string(from: interval.start)
    }

    //종료일
    func getFinishDate(yyyyMMdd: String?) -> String {
        let formatter = customDateFormat(yyyyMMdd: yyyyMMdd)
        return formatter.string(from: interval.end)
    }
    
    //카테고리
    func getSort() -> String {
        switch sort {
        case .normal:
            return "일반 도전"
        case .userMade:
            return "나만의 도전"
        case .survival:
            return "서바이벌 도전"
        }
    }
    
    //카테고리
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
        case .etc:
            return "기타"
        }
    }
    
    //인증주기
    func getPeriod() -> String {
        switch authenticationPeriod {
        case .everyYear:
            return "매년"
        case .everyMonth:
            return "매월"
        case .everyDay:
            return "매일"
        case .everyMonday:
            return "매주 월요일"
        case .everyTuesday:
            return "매주 화요일"
        case .everyWednesday:
            return "매주 수요일"
        case .everyThursday:
            return "매주 목요일"
        case .everyFriday:
            return "매주 금요일"
        case .everySaturday:
            return "매주 토요일"
        case .everySunday:
            return "매주 일요일"
        }
    }

    //총 필요 인증 횟수 (프로그레스 뷰에서 사용)
    func getTotalAuthenticationCount() -> Float {
        return Float(dueDates.count)
    }

    //총 인증 횟수 (프로그레스 뷰에서 사용)
    func getDoneAuthenticationCount() -> Float {
        var doneAuthenticationCount = 0
        for dueDate in dueDates {
            if dueDate.dueDateStatus == .authenticated {
                doneAuthenticationCount += 1
            }
        }
        return Float(doneAuthenticationCount)
    }

    //오늘까지 해야하는 목표 or 매월, 매년 해야하는 목표 (메인 화면표시용)
    func getIsHaveToDoToday() -> Bool {
        if progression == .onGoing {
            if todayStatus == .failed {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }
    
    //도전 구분 색
    func getColor() -> UIColor {
        return UIColor(displayP3Red: color.redFloat, green: color.greenFloat, blue: color.blueFloat, alpha: 1.0)
    }
    
    //도전 카테고리 이미지
    func getCategoryImage() -> UIImage? {
        var enumToImageName: String!
        
        switch category {
        case .certificate:
            enumToImageName = "certificate"
        case .coding:
            enumToImageName = "coding"
        case .health:
            enumToImageName = "health"
        case .language:
            enumToImageName = "language"
        case .reading:
            enumToImageName = "reading"
        case .etc:
            enumToImageName = "etc"
        }
        
        return UIImage(named: "challenge_\(enumToImageName!)")
    }

    //타입 Date <-> String
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
    
    //도전 히스토리 이미지
    func getAuthenticationImage(dueDateIndex: Int) -> UIImage {
        let url = documentsPath.appendingPathComponent("\(originalIndex)/\(dueDates[dueDateIndex].authenticationImage)")
        if let image = UIImage(contentsOfFile: url.path) {
            
            return image
        } else {
            return UIImage(named: "blankImage")!
        }
    }
    
    //특정일의 인증여부
    func checkDateStatus(specificDate: Date) -> authenticationStatus? {
        let calendar = Calendar.current
        let specificDateInfo = calendar.dateComponents([.year, .month, .day], from: specificDate)
        
        
        for dueDate in dueDates {
            let dueDateInfo = calendar.dateComponents([.year, .month, .day], from: dueDate.date)
            
            if specificDateInfo.year == dueDateInfo.year && specificDateInfo.month == dueDateInfo.month && specificDateInfo.day == dueDateInfo.day {
                return dueDate.dueDateStatus
            }
            
        }
        return nil
    }
    
    //오늘 인증 가능한 인증기한
    func checkTodaysDueDateIndex() -> Int {
        
        var getIndex = -1
        
        
        for (index,dueDate) in dueDates.enumerated() {
            
            if index == 0 {
                switch authenticationPeriod {
                case .everyYear:
                    if dueDate.date >= today.end {
                        getIndex = index
                    }
                case .everyMonth:
                    if dueDate.date >= today.end {
                        getIndex = index
                    }
                default:
                    if dueDate.date == today.end {
                        getIndex = index
                    }
                }
            } else {
                let priorDueDate = dueDates[index - 1].date
                switch authenticationPeriod {
                case .everyYear:
                    if priorDueDate < today.end && dueDate.date >= today.end {
                        getIndex = index
                    }
                case .everyMonth:
                    if priorDueDate < today.end && dueDate.date >= today.end {
                        getIndex = index
                    }
                default:
                    if dueDate.date == today.end {
                        getIndex = index
                    }
                }
            }
            
        }
        return getIndex
    }
    
    struct dueDatesStruct: Codable {
        let date: Date                                      //인증 필요 날짜
        var dueDateStatus: authenticationStatus = .waiting  //인증 여부
        var authenticationImage: String = ""                   //인증 사진
        var authenticationReview: String = ""               //인증 후기
    }

    enum challengeProgression: String, Codable {
        case waitForStart, onGoing, succeed, failed
    }

    enum authenticationStatus: String, Codable {
        case authenticated, waiting, failed
    }

    enum challengeSort: String, Codable {
        case userMade, normal, survival
    }

    enum challengeCategory: String, Codable {
        case certificate, coding, health, language, reading, etc
    }

    enum challengePeriod: String, Codable {
        case everyYear, everyMonth, everyDay, everyMonday, everyTuesday, everyWednesday, everyThursday, everyFriday, everySaturday, everySunday
    }
    
    struct uiColorInRGB: Codable{
        var redFloat: CGFloat
        var greenFloat: CGFloat
        var blueFloat: CGFloat
    }

    init(setTitle: String, setColor: UIColor, setSort: challengeSort, setCategory: challengeCategory, setDescription: String, setAuthenticationMethod: String, setAuthenticationPeriod: challengePeriod, setStartDate: Date, setFinishDate: Date) {



        title = setTitle
        color = uiColorInRGB(redFloat: setColor.redValue, greenFloat: setColor.greenValue, blueFloat: setColor.blueValue)
        sort = setSort
        category = setCategory
        description = setDescription
        authenticationMethod = setAuthenticationMethod
        authenticationPeriod = setAuthenticationPeriod

        let calendar = Calendar.current

        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "yyyy/MM/dd h:mm:ss a"

        let startDateInfo = calendar.dateComponents([.year, .month, .day], from: setStartDate)
        let finishDateInfo = calendar.dateComponents([.year, .month, .day], from: setFinishDate)
        let startDateString = "\(startDateInfo.year!)/\(startDateInfo.month!)/\(startDateInfo.day!) 12:00:00 AM"
        let finishDateString = "\(finishDateInfo.year!)/\(finishDateInfo.month!)/\(finishDateInfo.day!) 11:59:59 PM"

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
        
        originalIndex = userData.newChallengeIndex
        
        let folderPath = documentsPath.appendingPathComponent("\(userData.newChallengeIndex)")
        if !FileManager.default.fileExists(atPath: folderPath.path) {
            do { try FileManager.default.createDirectory(atPath: folderPath.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                NSLog("Couldn't create document directory")
            }
        }
        
        userData.newChallengeIndex += 1
    }
}




var UserChallenges: [UserChallenge] = []

class UserDataManager {
    
    func updateDueDateStatus() {
        for (challengeIndex, eachChallenge) in UserChallenges.enumerated() {
            for (dueDateIndex, dueDate) in eachChallenge.dueDates.enumerated() {
                
                if dueDate.date < today.start && dueDate.dueDateStatus == .waiting {
                    UserChallenges[challengeIndex].dueDates[dueDateIndex].dueDateStatus = .failed
                }
            }
        }
    }
    
    //오늘 도전 인증필요 여부 업데이트
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
    
    //유저 정보 저장
    func saveUserData() {
        userData.userChallenges = UserChallenges
        for (challengeIndex, eachChallenge) in DefaultChallenges.enumerated() {
            userData.addedChallenges[challengeIndex] = eachChallenge.challengeAdded
        }
        
        
        let encoder = JSONEncoder()
        
        guard let result = try? encoder.encode(userData) else { return }
        
        let homepath = NSHomeDirectory()
        var url = URL(fileURLWithPath: homepath)
        
        url.appendPathComponent("Documents/UserData.json")
        
        _ = try! result.write(to: url)
    }
    
    //유저 정보 불러오기
    func loadUserData() {
        let homepath = NSHomeDirectory()
        var url = URL(fileURLWithPath: homepath)
        
        url.appendPathComponent("Documents/UserData.json")
        
        if let data = try? Data(contentsOf: url) {
            let result = try! JSONDecoder().decode(UserData.self, from: data)
            
            userData = result
            UserChallenges = userData.userChallenges
            
            for (challengeIndex, challengeAdded) in userData.addedChallenges.enumerated() {
                DefaultChallenges[challengeIndex].challengeAdded = challengeAdded
            }
        } else {
            print("UserData.json not found")
        }
    }
    
    //앱 초기화
    func restoreDefaults() {
        let fileManager = FileManager.default
//        for folderIndex in 0... {
//            let forderDirectory = documentsPath.appendingPathComponent("\(folderIndex)")
//            guard let filePaths = try? fileManager.contentsOfDirectory(at: forderDirectory, includingPropertiesForKeys: nil, options: []) else { return }
//            for filePath in filePaths {
//                try? fileManager.removeItem(at: filePath)
//            }
//        }
        
        guard let filePaths = try? fileManager.contentsOfDirectory(at: documentsPath, includingPropertiesForKeys: nil, options: []) else { return }
        for filePath in filePaths {
            try? fileManager.removeItem(at: filePath)
        }
        
        userData = UserData.init()
        UserChallenges = []
        for (index,_) in DefaultChallenges.enumerated() {
            DefaultChallenges[index].challengeAdded = false
        }
    }
}

let manageUserData = UserDataManager.init()




extension UIColor {
    var redValue: CGFloat{ return CIColor(color: self).red }
    var greenValue: CGFloat{ return CIColor(color: self).green }
    var blueValue: CGFloat{ return CIColor(color: self).blue }
    var alphaValue: CGFloat{ return CIColor(color: self).alpha }
}






struct todayDateInfo {
    let start: Date = {
        let calendar = Calendar.current

        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "yyyy/MM/dd h:mm:ss a"
        
        let todayInfo = calendar.dateComponents([.year, .month, .day], from: Date())
        let todayString = "\(todayInfo.year!)/\(todayInfo.month!)/\(todayInfo.day!) 12:00:00 AM"
        return formatter.date(from: todayString)!
    }()
    
    let end: Date = {
        let calendar = Calendar.current

        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "yyyy/MM/dd h:mm:ss a"
        
        let todayInfo = calendar.dateComponents([.year, .month, .day], from: Date())
        let todayString = "\(todayInfo.year!)/\(todayInfo.month!)/\(todayInfo.day!) 11:59:59 PM"
        return formatter.date(from: todayString)!
    }()
}

let today = todayDateInfo.init()


struct UserData: Codable {
    var userName = "지왕"
    
    var level = 0
    var points = 0
    var newChallengeIndex = 0
    
    var userChallenges: [UserChallenge] = []
    
    var addedChallenges = [Bool](repeating: false, count: DefaultChallenges.count)
}

var userData = UserData.init()

