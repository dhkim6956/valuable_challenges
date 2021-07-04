import UIKit

struct Challenge {
    var title : String
    var period : Int
    var desc : String
    var category : String
    var authenticationMethod : String
}

var challenges: [Challenge] = [
    Challenge(title: "Front-end", period: 30, desc: "30일 동안 html, css, JS에 대한 개념을 잡아보자", category: "Coding", authenticationMethod: "Dream Coding 무료 동영상 강의를 듣고 해당 강의에서 작성한 코드를 캡쳐하여 인증"),
    Challenge(title: "독후감 작성하기", period: 30, desc: "한달동안 한권의 책을 읽고 독후감을 작성하여 인증하는 과정", category: "독서", authenticationMethod: "독후감을 작성한 후 작성 내용의 일부를 촬영하여 인증"),
    Challenge(title: "필기시험 4주 뿌셔", period: 28, desc: "4주간 준비할 수 있는 필기시험 공부하는 과정", category: "자격증 공부", authenticationMethod: "시중에 판매하는 한달 과정의 문제집 등을 1day풀고 사진찍어 인증하기"),
    Challenge(title: "체지방 1kg 빼기", period: 14, desc: "근손실없이 건강하게 체지방 빼기", category: "운동", authenticationMethod: "매일 근력운동 1시간 + 유산소 1시간 하기")
]
