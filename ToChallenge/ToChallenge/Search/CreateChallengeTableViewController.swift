//
//  CreateChallengeTableViewController.swift
//  ToChallenge
//
//  Created by 김도훈 on 2021/08/12.
//

import UIKit
import Toast_Swift

class CreateChallengeTableViewController: UITableViewController {
    
    let category = ["자격증", "코딩", "운동", "외국어", "독서", "기타"]
    let period = ["매년", "매월", "매일", "일요일마다", "월요일마다", "화요일마다", "수요일마다", "목요일마다", "금요일마다", "토요일마다"]
    
    let startDatePicker = UIDatePicker()
    let finishDatePicker = UIDatePicker()
    
    var categoryPickerView = UIPickerView()
    var periodPickerView = UIPickerView()
    
    var startDate: Date!
    var finishDate: Date!
    
    var selectedChallenge: DefaultChallenge? = nil
    
    
    
    
    
    @IBOutlet weak var titleFrame: UIView!
    @IBOutlet var upperSide: [UIView]!
    @IBOutlet var lowerSide: [UIView]!
    
    
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var authenticationMethodTextField: UITextField!
    
    
    @IBOutlet weak var categoryTextField: PickerUITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var periodTextField: PickerUITextField!
    
    @IBOutlet weak var startDateTextField: PickerUITextField!
    @IBOutlet weak var finishDateTextField: PickerUITextField!
    
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
        
        categoryTextField.addTarget(self, action: #selector(categoryValueChanged(sender:)), for: UIControl.Event.editingDidEnd)
        periodTextField.addTarget(self, action: #selector(periodValueChanged(sender:)), for: UIControl.Event.editingDidEnd)
        
        
        if let selectedChallengeInfo = selectedChallenge {
            titleTextField.text = selectedChallengeInfo.title
            titleTextField.isUserInteractionEnabled = false
            
            descriptionTextField.text = selectedChallengeInfo.description
            descriptionTextField.isUserInteractionEnabled = false
            
            authenticationMethodTextField.text = selectedChallengeInfo.authenticationMethod
            authenticationMethodTextField.isUserInteractionEnabled = false
            
            categoryTextField.text = {
                switch selectedChallengeInfo.category {
                case .certificate:
                    return "자격증"
                case .coding:
                    return "코딩"
                case .health:
                    return "운동"
                case .language:
                    return "외국어"
                case .reading:
                    return "독서"
                case .etc:
                    return "기타"
                }
            }()
            changeCategoryImage()
            categoryTextField.isUserInteractionEnabled = false
            
            durationTextField.text = "\(selectedChallengeInfo.duration)"
            durationTextField.isUserInteractionEnabled = false
            
            periodTextField.text = {
                switch selectedChallengeInfo.authenticationPeriod {
                case .everyYear:
                    return "매년"
                case .everyMonth:
                    return "매월"
                case .everyDay:
                    return "매일"
                case .everySunday:
                    return "일요일마다"
                case .everyMonday:
                    return "월요일마다"
                case .everyTuesday:
                    return "화요일마다"
                case .everyWednesday:
                    return "수요일마다"
                case .everyThursday:
                    return "목요일마다"
                case .everyFriday:
                    return "금요일마다"
                case .everySaturday:
                    return "토요일마다"
                }
            }()
            periodTextField.isUserInteractionEnabled = false
        }
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
        self.view.endEditing(true)
        if today.start <= sender.date {
            startDateTextField.text = formatter.string(from: sender.date)
            startDate = sender.date
        } else {
            self.view.makeToast("시작일은 오늘 혹은 오늘 이후여야 합니다", duration: 3, position: .top, title: "날짜 오류", image: UIImage(named: "charactor1"), style: .init(), completion: nil)
        }
        
    }
    @objc func finishDatePickerValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        self.view.endEditing(true)
        if today.start <= sender.date {
            finishDateTextField.text = formatter.string(from: sender.date)
            finishDate = sender.date
        } else {
            self.view.makeToast("종료일은 오늘 혹은 오늘 이후여야 합니다", duration: 3, position: .top, title: "날짜 오류", image: UIImage(named: "charactor1"), style: .init(), completion: nil)
        }
        
    }
    
    @objc func periodValueChanged(sender: UITextField) {
        
    }
    
    @objc func categoryValueChanged(sender: UITextField) {
        changeCategoryImage()
    }
    
    func changeCategoryImage() {
        var stringToImageName: String? = nil
        
        switch categoryTextField.text {
        case "자격증":
            stringToImageName = "certificate"
        case "코딩":
            stringToImageName = "coding"
        case "운동":
            stringToImageName = "health"
        case "외국어":
            stringToImageName = "language"
        case "독서":
            stringToImageName = "reading"
        case "기타":
            stringToImageName = nil
        default:
            categoryTextField.text = nil
        }
        
        if let imageString = stringToImageName {
            categoryImageView.image = UIImage(named: "challenge_\(imageString)")
        } else {
            categoryImageView.image = nil
        }
    }
    
    func correctDate(changedStartDate: Bool, changedEndDate: Bool, changedDuration: Bool, datePicker: Date?) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        
        if changedStartDate == true {
            guard let selectedDate = datePicker else { return }
            startDate = selectedDate
            startDateTextField.text = formatter.string(from: startDate)
            if durationTextField.text != "" {
                guard let timeIntervalDouble = Double(durationTextField.text!) else { return }
                finishDate = Date(timeInterval: timeIntervalDouble, since: selectedDate)
                finishDateTextField.text = formatter.string(from: finishDate)
            }
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        if titleTextField.text != "" {
            guard let bringTitle = titleTextField.text else { return }
            if let bringColor = colorPickerView.selectedColor {
                if categoryTextField.text != "" {
                    guard let bringCategory = categoryTextField.text else { return }
                    if descriptionTextField.text != "" {
                        guard let bringDescription = descriptionTextField.text else { return }
                        if authenticationMethodTextField.text != "" {
                            guard let bringAuthenticationMethod = authenticationMethodTextField.text else { return }
                            if periodTextField.text != "" {
                                guard let bringPeriod = periodTextField.text else { return }
                                if let bringStartDate = startDate {
                                    if let bringFinishDate = finishDate {
                                        UserChallenges.append(UserChallenge(setTitle: bringTitle, setColor: bringColor, setSort: {
                                            if let selectedChallengeInfo = selectedChallenge {
                                                switch selectedChallengeInfo.sort {
                                                case .survival:
                                                    return .survival
                                                default:
                                                    for (index,eachChallenge) in DefaultChallenges.enumerated() {
                                                        if eachChallenge.title == selectedChallengeInfo.title {
                                                            DefaultChallenges[index].challengeAdded = true
                                                        }
                                                    }
                                                    return .normal
                                                }
                                            } else {
                                                return .userMade
                                            }
                                        }(), setCategory: {
                                            switch bringCategory {
                                            case "자격증":
                                                return .certificate
                                            case "코딩":
                                                return .coding
                                            case "운동":
                                                return .health
                                            case "외국어":
                                                return .language
                                            case "독서":
                                                return .reading
                                            default:
                                                return .etc
                                            }
                                        }(), setDescription: bringDescription, setAuthenticationMethod: bringAuthenticationMethod, setAuthenticationPeriod: {
                                            switch bringPeriod {
                                            case "매년":
                                                return .everyYear
                                            case "매월":
                                                return .everyMonth
                                            case "매일":
                                                return .everyDay
                                            case "일요일마다":
                                                return .everySunday
                                            case "월요일마다":
                                                return .everyMonday
                                            case "화요일마다":
                                                return .everyTuesday
                                            case "수요일마다":
                                                return .everyWednesday
                                            case "목요일마다":
                                                return .everyThursday
                                            case "금요일마다":
                                                return .everyFriday
                                            default:
                                                return .everySaturday
                                            }
                                        }(), setStartDate: bringStartDate, setFinishDate: bringFinishDate))
                                        self.navigationController?.popToRootViewController(animated: true)
                                        if let tabbarController = self.navigationController?.tabBarController {
                                            tabbarController.selectedIndex = 0
                                        }
                                    } else {
                                        self.view.makeToast("종료일이 지정되지 않았음", duration: 1, position: .top, title: "설정 미완료", image: UIImage(named: "charactor1"), style: .init(), completion: nil)
                                    }
                                } else {
                                    self.view.makeToast("시작일이 지정되지 않았음", duration: 1, position: .top, title: "설정 미완료", image: UIImage(named: "charactor1"), style: .init(), completion: nil)
                                }
                            } else {
                                self.view.makeToast("인증주기가 지정되지 않았음", duration: 1, position: .top, title: "설정 미완료", image: UIImage(named: "charactor1"), style: .init(), completion: nil)
                            }
                        } else {
                            self.view.makeToast("인증방법이 지정되지 않았음", duration: 1, position: .top, title: "설정 미완료", image: UIImage(named: "charactor1"), style: .init(), completion: nil)
                        }
                    } else {
                        self.view.makeToast("설명이 지정되지 않았음", duration: 1, position: .top, title: "설정 미완료", image: UIImage(named: "charactor1"), style: .init(), completion: nil)
                    }
                } else {
                    self.view.makeToast("카테고리이 지정되지 않았음", duration: 1, position: .top, title: "설정 미완료", image: UIImage(named: "charactor1"), style: .init(), completion: nil)
                }
            } else {
                self.view.makeToast("색이 지정되지 않았음", duration: 1, position: .top, title: "설정 미완료", image: UIImage(named: "charactor1"), style: .init(), completion: nil)
            }
        } else {
            self.view.makeToast("제목이 지정되지 않았음", duration: 1, position: .top, title: "설정 미완료", image: UIImage(named: "charactor1"), style: .init(), completion: nil)
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

