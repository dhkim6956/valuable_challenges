import UIKit

//Date <-> String
let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeZone = .current
    formatter.locale = .current
    formatter.dateFormat = "MM/dd/yyyy h:mm"
    return formatter
}()


let present = Date()

//Date <-> String
let text = formatter.string(from: present)
print(formatter.date(from: "12/24/2000 9:00"))

//Date +- 초 (86400초 = 하루)
let distantPast = Date.distantPast
let past = Date(timeInterval: -3600, since: present)
let future = Date(timeInterval: 3600, since: present)
let distantFuture = Date.distantFuture

//DateInterval 기간
let interval = DateInterval(start: past, duration: 7200)
print(interval.start)
print(interval.end)
print(interval.duration)

let anotherInterval = DateInterval(start: past, end: future)
print(interval.start)
print(interval.end)
print(interval.duration)



let calendar = Calendar.current
let sort = calendar.dateComponents([.year, .month, .day, .weekday, .hour, .minute, .second, .quarter, .weekOfMonth, .weekOfYear], from: present)

print(sort)





let checkFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeZone = .current
    formatter.locale = .current
    formatter.dateFormat = "MM/dd/yyyy EEEE h:mm a"
    return formatter
}()

let checkDate = checkFormatter.date(from: "08/19/2021 Thursday 11:59 PM")!
let checkDateText = checkFormatter.string(from: checkDate)
let check = calendar.dateComponents([.weekday], from: checkDate)

let futureDate = Date(timeInterval: 60, since: checkDate)
let futureDateText = checkFormatter.string(from: futureDate)
let check2 = calendar.dateComponents([.weekday], from: futureDate)


