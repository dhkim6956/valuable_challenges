//
//  ViewController.swift
//  CovChallenges
//
//  Created by Yejin Lee on 2021/07/04.
//

import UIKit

class ViewController: UIViewController {
    struct Challenge {
        var title : String
        var period : Int
        var desc : String
        var category : String
        var authenticationMethod : String
    }

    var challenges: [Challenge] = [
        Challenge(title: "Front-end", period: 30, desc: "30일 동안 html, css, JS에 대한 개념을 잡아보자", category: "Coding", authenticationMethod: "Dream Coding 무료 동영상 강의를 듣고 해당 강의에서 작성한 코드를 캡쳐하여 인증")
    ]

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        titleLabel.text = challenges[0].title
        descLabel.text = challenges[0].desc
    }


}

