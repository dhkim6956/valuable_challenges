import UIKit



struct Challenge1 {
    var title: String
    var category: String
    var finishPeriod: Int // 도전 완료? 목표? 기간
//  var challengeCount: Int // 목표 횟수. (몇회까지 해야 함)
    var ongoingPeriod: Int // 도전한지 며칠 되었는지
//  var nowCount: Int // 몇번 시도 했는지.
    var startDate: String // 시작 일자
    var finishDate: String // 종료된 일자
//    var remainedCount: Int // 남은 도전 빼먹기 횟수. 3
//    var status: ChallengeStatus // 현재 이 도전의 상태.
}



struct UserChallenge {
    let title: String                           //도전명
    let color: UIColor                          //도전색
    let sort: challengeSort                     //나만의 도전, 일반 도전, 서바이벌 도전
    let category: challengeCategory             //자격증, 코딩, 운동, 외국어, 독서, 기타
    let description: String                     //설명
    let authenticationMethod: String            //인증방법
    let authenticationPeriod: challengePeriod   //인증주기
    
    
    var interval: DateInterval                  //기간
    var todayStatus: challengeStatus            //오늘 도전 상태
    var dueDates: [dueDatesStruct]              //인증기한
    var remainTry: Int                          //남은 도전 실패 횟수
    
    
    
    
    enum challengeStatus {
        case certified, waiting, failed
    }
    
    enum challengeSort {
        case userMade, normal, serviver
    }
    
    enum challengeCategory {
        case certificate, coding, health, language, reading, etc
    }
    
    enum challengePeriod {
        case everyYear, everyMonth, everyDay, everyMonday, everyTuesday, everyWednesday, everyThursday, everyFriday, everySaturday, everySunday
    }
    
    func getDuration() -> Int {
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
    
    func getTotalAuthenticationCount() -> Int {
        dueDates.count
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
    
    func getDoneAuthenticationCount() -> Int {
        var doneAuthenticationCount = 0
        for dueDate in dueDates {
            if dueDate.dueDateStatus == .certified {
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
        var dueDateStatus: challengeStatus = .waiting
        var authenticationImage: String = ""
        var authenticationReview: String = ""
    }
    
    init(setTitle: String, setColor: UIColor, setSort: challengeSort, setCategory: challengeCategory, setDescription: String, setAuthenticationMethod: String, setAuthenticationPeriod: challengePeriod, setInterval: DateInterval) {
        title = setTitle
        color = setColor
        sort = setSort
        category = setCategory
        description = setDescription
        authenticationMethod = setAuthenticationMethod
        authenticationPeriod = setAuthenticationPeriod
        interval = setInterval

        let calendar = Calendar.current
        let finishDate = setInterval.end
        var dateForCalc = setInterval.start

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
    }
}

var UserChallenges: [UserChallenge] = []


let present = Date()
let future = Date(timeInterval: 8640000, since: present)
let interval = DateInterval(start: present, end: future)


UserChallenges.append(UserChallenge(setTitle: "Front-end 정복해보자", setColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), setSort: .normal, setCategory: .coding, setDescription: "30일 동안 html, css, javascript에 대한 개념을 잡을 수 있는 과정", setAuthenticationMethod: "Dream Coding 무료 동영상 강의를 듣고 해당 강의에서 작성한 코드를 캡쳐하여 인증", setAuthenticationPeriod: .everyMonth, setInterval: interval))

UserChallenges[0].getDoneAuthenticationCount()
UserChallenges[0].getTotalAuthenticationCount()
UserChallenges[0].getDuration()
UserChallenges[0].getStartDate(yyyyMMdd: nil)
UserChallenges[0].getFinishDate(yyyyMMdd: "yyyy/MM/dd")
UserChallenges[0].getIsHaveToDoToday()
UserChallenges[0].getCategory()
