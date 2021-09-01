//
//  DetailViewController.swift
//  ToChallenge
//
//  Created by Yejin Lee on 2021/08/27.
//

import UIKit
import FSCalendar

class DetailViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    
    @IBOutlet var calendar: FSCalendar!

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var challengeProgressView: UIProgressView!
    @IBOutlet weak var chanceLabel: UILabel!
    
    @IBOutlet weak var authenticationButton: UIButton!
    @IBOutlet weak var giveUpButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    var selectedChallenge: UserChallenge!
    
    
    var categoryTitleArray = [String]()
    var categoryValueArray = [String]()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        challengeProgressView.transform = challengeProgressView.transform.scaledBy(x: 1, y: 2)
        
        challengeProgressView.setProgress(Float(selectedChallenge.getInProgressDate()/selectedChallenge.getEstimatedEndDate()), animated: true)
        
        
        categoryLabel.text = selectedChallenge.getSort()
        titleLabel.text = selectedChallenge.title
        progressLabel.text = "\(selectedChallenge.getInProgressDate())/\(selectedChallenge.getEstimatedEndDate())일"
        
            
        authenticationButton.layer.cornerRadius = 15.0
        giveUpButton.layer.cornerRadius = 15.0
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        calendar.dataSource = self
        calendar.delegate = self
        calendar.allowsMultipleSelection = true
        
        calendar.calendarHeaderView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.1)
        calendar.calendarWeekdayView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.1)
        calendar.appearance.titleSelectionColor = UIColor.black
        calendar.appearance.eventOffset = CGPoint(x: 0, y: -7)
        calendar.today = nil // Hide the today circle
        calendar.register(DIYCalendarCell.self, forCellReuseIdentifier: "cell")
        
        
        categoryTitleArray = ["카테고리", "반복"]
        let category = selectedChallenge.getCategory()
        let period = selectedChallenge.getPeriod()
        categoryValueArray = [category, period]
        
        chanceLabel.text = "남은 기회: \(selectedChallenge.remainTry)"
        
        
        var checkDate = selectedChallenge.interval.start
        while checkDate < selectedChallenge.interval.end {
            self.calendar.select(checkDate, scrollToDate: false)
            checkDate = self.gregorian.date(byAdding: .day, value: 1, to: checkDate)!
        }
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if selectedChallenge.interval.start <= date && selectedChallenge.interval.end >= date {
            if selectedChallenge.checkDateStatus(specificDate: date) != nil{
                return 1
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        if selectedChallenge.interval.start <= date && selectedChallenge.interval.end >= date {
            if let dateStatus = selectedChallenge.checkDateStatus(specificDate: date) {
                switch dateStatus {
                case .authenticated:
                    return [UIColor.green]
                case .waiting:
                    return [UIColor.lightGray]
                case .failed:
                    return [UIColor.red]
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
        if selectedChallenge.interval.start <= date && selectedChallenge.interval.end >= date {
            if let dateStatus = selectedChallenge.checkDateStatus(specificDate: date) {
                switch dateStatus {
                case .authenticated:
                    return [UIColor.green]
                case .waiting:
                    return [UIColor.lightGray]
                case .failed:
                    return [UIColor.red]
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        self.configure(cell: cell, for: date, at: position)
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
    
    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        
        let diyCell = (cell as! DIYCalendarCell)
        

        
        diyCell.todayCircle.isHidden = !self.gregorian.isDateInToday(date)
        
        var selectionType = SelectionType.none
        
        if calendar.selectedDates.contains(date) {
            let previousDate = self.gregorian.date(byAdding: .day, value: -1, to: date)!
            let nextDate = self.gregorian.date(byAdding: .day, value: 1, to: date)!
            if calendar.selectedDates.contains(date) {
                if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(nextDate) {
                    selectionType = .middle
                }
                else if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(date) {
                    selectionType = .rightBorder
                }
                else if calendar.selectedDates.contains(nextDate) {
                    selectionType = .leftBorder
                }
                else {
                    selectionType = .single
                }
            }
            
            if date < Date() {
                diyCell.selectionLayer.fillColor = UIColor.systemGray3.cgColor
            } else {
                diyCell.selectionLayer.fillColor = UIColor.systemGray5.cgColor
            }
        }
        else {
            selectionType = .none
        }
        if selectionType == .none {
            diyCell.selectionLayer.isHidden = true
            return
        }
        diyCell.selectionLayer.isHidden = false
        diyCell.selectionType = selectionType
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
