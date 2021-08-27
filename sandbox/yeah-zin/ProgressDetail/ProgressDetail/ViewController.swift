//
//  ViewController.swift
//  ProgressDetail
//
//  Created by Yejin Lee on 2021/08/25.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance{
    
    @IBOutlet var calendar: FSCalendar!
    
    var formatter = DateFormatter()
    
    let nums: [Int] = [1,2,3,4]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        
        // calendar.scrollDirection = .horizontal
        // calendar.scope = .month
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 13)
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 16)
        calendar.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 14)
        
        calendar.appearance.todayColor = .systemGreen
        calendar.appearance.titleTodayColor = .white
        // calendar.appearance.headerTitleColor = .systemRed
        // calendar.appearance.weekdayTextColor = .systemRed
        
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        calendar.allowsMultipleSelection = true


    }
    


}

