//
//  CreateChallengeTableViewController.swift
//  ToChallenge
//
//  Created by 김도훈 on 2021/08/12.
//

import UIKit

class CreateChallengeTableViewController: UITableViewController {
    
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var titleFrame: UIView!
    @IBOutlet var upperSide: [UIView]!
    @IBOutlet var lowerSide: [UIView]!
    
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var periodTextField: UITextField!
    
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var finishDateTextField: UITextField!
    
    let category = ["독서", "자격증", "코딩", "운동", "외국어"]
    let period = ["매일", "매주", "매월"]
    
    var categoryPickerView = UIPickerView()
    var periodPickerView = UIPickerView()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControl.Event.editingChanged)
        datePicker.preferredDatePickerStyle = .compact
        
        
        titleFrame.layer.cornerRadius = 10
        
        for upper in upperSide {
            upper.layer.cornerRadius = 10
            upper.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        }
        
        for lower in lowerSide {
            lower.layer.cornerRadius = 10
            lower.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        }
        
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
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor(displayP3Red: 0.93, green: 0.93, blue: 0.93, alpha: 1.0)
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        
    }
    
    
    @objc func addTapped() {
        print("추가버튼 눌러짐")
        let index1 = IndexPath(row: 2, section: 1)
        if let cell = tableView.cellForRow(at: index1) as? challengeDescriptionTableViewCell {
            let name: String = cell.descriptionTextfield.text!
            print(name)
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
