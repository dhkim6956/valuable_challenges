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
    
    var doneDates = [String]()
    var absentDates = [String]()
    
    var categoryTitleArray = [String]()
    var categoryValueArray = [String]()
    
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryLabel.text = selectedChallenge?.sort.rawValue
        titleLabel.text = selectedChallenge?.title
            
        authenticationButton.layer.cornerRadius = 15.0
        giveUpButton.layer.cornerRadius = 15.0
        
        calendar.dataSource = self
        calendar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        // calendar.appearance.titleWeekendColor = .red
        calendar.appearance.todayColor = .none
        calendar.appearance.titleTodayColor = .black
        
        doneDates = ["2021-08-24", "2021-08-27", "2021-08-25", "2021-08-26"]
        absentDates = ["2021-08-23", "2021-08-28"]
        
        categoryTitleArray = ["카테고리", "반복"]
        let category = selectedChallenge!.category.rawValue
        let period = selectedChallenge!.authenticationPeriod.rawValue
        categoryValueArray = [category, period]
        

    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        let dateString: String = dateFormatter.string(from: date)
        
        if doneDates.contains(dateString) {
            return 1
        } else if absentDates.contains(dateString) {
            return 1
        } else {
            return 0
        }
        
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        let dateString: String = dateFormatter.string(from: date)
        
        if doneDates.contains(dateString) {
            return [UIColor.green]
        } else if absentDates.contains(dateString) {
            return [UIColor.red]
        } else {
            return nil
        }
    }

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        cell.textLabel?.text = categoryTitleArray[indexPath.row]
        cell.detailTextLabel?.text = categoryValueArray[indexPath.row]
        
        return cell
    }
    
}
