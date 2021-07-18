//
//  DetailViewController.swift
//  challengeTable
//
//  Created by Yejin Lee on 2021/07/18.
//

import UIKit

class DetailViewController: UIViewController {
    
    var challenge : Challenge = Challenge(title: "", desc: "", period: 1, category: "")
    
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titlelabel.text = challenge.title
        descTextView.text = challenge.desc
        categoryLabel.text = challenge.category
        periodLabel.text = "\(challenge.period)일"
    }

}
