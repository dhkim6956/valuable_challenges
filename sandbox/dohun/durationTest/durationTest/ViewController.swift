//
//  ViewController.swift
//  durationTest
//
//  Created by 김도훈 on 2021/09/02.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {

    fileprivate let gregorian = Calendar(identifier: .gregorian)
    
    @IBOutlet weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        calendar.dataSource = self
        calendar.delegate = self
        calendar.allowsMultipleSelection = true
        
        calendar.calendarHeaderView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.1)
        calendar.calendarWeekdayView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.1)
        calendar.appearance.titleSelectionColor = UIColor.black
        calendar.appearance.eventOffset = CGPoint(x: 0, y: -7)
        calendar.today = nil // Hide the today circle
        calendar.register(DIYCalendarCell.self, forCellReuseIdentifier: "cell")
        
        
        // Uncomment this to perform an 'initial-week-scope'
        // self.calendar.scope = FSCalendarScopeWeek;
        
        let dates = [
            self.gregorian.date(byAdding: .day, value: -2, to: Date()),
            self.gregorian.date(byAdding: .day, value: -1, to: Date()),
            Date(),
            self.gregorian.date(byAdding: .day, value: 1, to: Date())
        ]
        dates.forEach { (date) in
            self.calendar.select(date, scrollToDate: false)
        }
        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"
        
    }
    
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        self.configure(cell: cell, for: date, at: position)
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 2
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        if self.gregorian.isDateInToday(date) {
            return [UIColor.orange]
        }
        return [appearance.eventDefaultColor]
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

