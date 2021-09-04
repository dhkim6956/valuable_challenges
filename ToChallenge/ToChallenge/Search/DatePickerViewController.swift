//
//  DatePickerViewController.swift
//  ToChallenge
//
//  Created by 김도훈 on 2021/09/04.
//

import UIKit

protocol ProtocolData {
    func protocolData(dataSent: Date)
}


class DatePickerViewController: UIViewController {
    
    
    @IBOutlet weak var foregroundView: UIView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var selectDateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var selectButtonLayout: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: ProtocolData?
    
    var selectedDateIsStartDate: Bool!
    
    
    var selectedDate = Date()
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foregroundView.layer.cornerRadius = 20
        selectButtonLayout.layer.cornerRadius = 10
        
        datePicker.addTarget(self, action: #selector(dateSelected(_:)), for: .valueChanged)
        
        formatter.dateFormat = "yyyy년 MM월 dd일"
        dateLabel.text = formatter.string(from: selectedDate)
        
        let isStartDate: Bool = selectedDateIsStartDate
        switch isStartDate {
        case true:
            selectDateLabel.text = "시작일을 선택해주세요"
        case false:
            selectDateLabel.text = "종료일을 선택해주세요"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    @IBAction func selectButtonTapped(_ sender: Any) {
        
        backgroundView.backgroundColor = UIColor.clear
        
        
        self.delegate?.protocolData(dataSent: selectedDate)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        backgroundView.backgroundColor = UIColor.clear
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dateSelected(_ sender: UIDatePicker) {
        
        selectedDate = sender.date
        dateLabel.text = formatter.string(from: sender.date)
    }
}
