//
//  CreateChallengeTableViewController.swift
//  ToChallenge
//
//  Created by 김도훈 on 2021/08/12.
//

import UIKit

class CreateChallengeTableViewController: UITableViewController {
    
    let category = ["독서", "자격증", "코딩", "운동", "외국어"]
    let period = ["매일", "매주", "매월"]
    
    let startDatePicker = UIDatePicker()
    let finishDatePicker = UIDatePicker()
    
    var categoryPickerView = UIPickerView()
    var periodPickerView = UIPickerView()
    
    var startDate: Date!
    var finishDate: Date!
    
    
    
    @IBOutlet weak var titleFrame: UIView!
    @IBOutlet var upperSide: [UIView]!
    @IBOutlet var lowerSide: [UIView]!
    
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var periodTextField: UITextField!
    
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var finishDateTextField: UITextField!
    
    @IBOutlet weak var colorPickerView: UIColorWell!
    
    @IBOutlet var sfSymbols: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for label in sfSymbols {
            label.attributedText = insertSymbol(textString: nil, symbolName: "square.and.pencil", symbolColor: UIColor(red: 199/255, green: 199/255, blue: 204/255, alpha: 1.0))
        }
        
        titleFrame.layer.cornerRadius = 10
        for upper in upperSide {
            upper.layer.cornerRadius = 10
            upper.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        }
        
        for lower in lowerSide {
            lower.layer.cornerRadius = 10
            lower.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        }
        
        colorPickerView.supportsAlpha = false
        colorPickerView.selectedColor = getRandomColor()
        colorPickerView.title = "도전 색상 지정"
        colorPickerView.addTarget(self, action: #selector(colorPickerValueChanged), for: .valueChanged)
        
        
        startDatePicker.datePickerMode = .date
        startDatePicker.addTarget(self, action: #selector(startDatePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        startDatePicker.preferredDatePickerStyle = .compact
        startDateTextField.inputView = startDatePicker
        
        finishDatePicker.datePickerMode = .date
        finishDatePicker.addTarget(self, action: #selector(finishDatePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        finishDatePicker.preferredDatePickerStyle = .compact
        finishDateTextField.inputView = finishDatePicker
        
        
        categoryTextField.inputView = categoryPickerView
        periodTextField.inputView = periodPickerView
        
        categoryPickerView.dataSource = self
        categoryPickerView.delegate = self
        periodPickerView.dataSource = self
        periodPickerView.delegate = self
        
        categoryPickerView.tag = 1
        periodPickerView.tag = 2
    }
    

    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor(displayP3Red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
    }
    
    @objc func colorPickerValueChanged() {
        print(colorPickerView.selectedColor!)
    }
    
    @objc func startDatePickerValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        startDateTextField.text = formatter.string(from: sender.date)
        startDate = sender.date
    }
    @objc func finishDatePickerValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        finishDateTextField.text = formatter.string(from: sender.date)
        finishDate = sender.date
    }
    
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        print("추가버튼 눌러짐")
        let index1 = IndexPath(row: 2, section: 1)
        if let cell = tableView.cellForRow(at: index1) as? challengeDescriptionTableViewCell {
            let name: String = cell.descriptionTextfield.text!
            print(name)
            print(startDate)
        }
    }
}


extension CreateChallengeTableViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return category.count
        case 2:
            return period.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return category[row]
        case 2:
            return period[row]
        default:
            return "Data not Found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            categoryTextField.text = category[row]
        case 2:
            periodTextField.text = period[row]
        default:
            return
        }
    }
}
