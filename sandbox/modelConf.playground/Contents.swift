import UIKit

struct Challenge {
    var title : String
    var period : Int
    var desc : String
    var category : String
    var authenticationMethod : String
}

var chalenges: [chalenge] = [
    Challenge(title: "Front-end", period: 30, desc: "30일 동안 html, css, JS에 대한 개념을 잡아보자", category: "Coding", authenticationMethod: "Dream Coding 무료 동영상 강의를 듣고 해당 강의에서 작성한 코드를 캡쳐하여 인증"),
    Challenge(title: "독후감 작성하기", period: 30, desc: "한달동안 한권의 책을 읽고 독후감을 작성하여 인증하는 과정", category: "독서", authenticationMethod: "독후감을 작성한 후 작성 내용의 일부를 촬영하여 인증")
]


