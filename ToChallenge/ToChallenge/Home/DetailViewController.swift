//
//  DetailViewController.swift
//  ToChallenge
//
//  Created by Yejin Lee on 2021/08/27.
//

import UIKit
import FSCalendar

class DetailViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    
    @IBOutlet var calendar: FSCalendar!

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var challengeProgressView: UIProgressView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var authenticationButton: UIButton!
    @IBOutlet weak var giveUpButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedChallenge: UserChallenge? = nil

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryLabel.text = selectedChallenge?.sort.rawValue
        titleLabel.text = selectedChallenge?.title
            
        authenticationButton.layer.cornerRadius = 15.0
        giveUpButton.layer.cornerRadius = 15.0
    }
    

    
    


}
