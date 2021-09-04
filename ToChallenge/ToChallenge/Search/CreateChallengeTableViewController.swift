//
//  CreateChallengeTableViewController.swift
//  ToChallenge
//
//  Created by 김도훈 on 2021/08/12.
//

import UIKit
import Toast_Swift

class CreateChallengeTableViewController: UITableViewController, ProtocolData {
    
    let category = ["자격증", "코딩", "운동", "외국어", "독서", "기타"]
    let period = ["매년", "매월", "매일", "일요일마다", "월요일마다", "화요일마다", "수요일마다", "목요일마다", "금요일마다", "토요일마다"]
    
    let startDatePicker = UIDatePicker()
    let finishDatePicker = UIDatePicker()
    
    var categoryPickerView = UIPickerView()
    var periodPickerView = UIPickerView()
    
    
    var selectedDateIsStartDate = true
    
    var startDate: Date?
    var finishDate: Date?
    
    var selectedChallenge: DefaultChallenge? = nil
    
    
    
    
    
    @IBOutlet weak var titleFrame: UIView!
    @IBOutlet var upperSide: [UIView]!
    @IBOutlet var lowerSide: [UIView]!
    
    
    @IBOutlet var shadowAndSeparator: [UIView]!
    
    
    
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var authenticationMethodTextField: UITextView!
    
    
    @IBOutlet weak var categoryTextField: PickerUITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var periodTextField: PickerUITextField!
    
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
        
        titleFrame.layer.shadowOpacity = 0.3
        titleFrame.layer.shadowOffset = CGSize(width: 3, height: 3)
        titleFrame.layer.shadowRadius = 3
        titleFrame.layer.masksToBounds = false
        
        for upper in upperSide {
            upper.layer.cornerRadius = 10
            upper.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
            
            
            upper.layer.shadowOpacity = 0.3
            upper.layer.shadowPath = UIBezierPath(rect: CGRect(x: 3, y: 9, width: upper.frame.width, height: upper.frame.height)).cgPath
            upper.layer.shadowRadius = 3
            upper.layer.masksToBounds = false
            
            let border = CALayer()
            border.frame = CGRect.init(x: 0, y: upper.frame.height - 1, width: upper.frame.width, height: 1)
            border.backgroundColor = UIColor.systemGray5.cgColor;
            upper.layer.addSublayer(border)
        }
        
        for lower in lowerSide {
            lower.layer.cornerRadius = 10
            lower.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
            
            
            lower.layer.shadowOpacity = 0.3
            lower.layer.shadowPath = UIBezierPath(rect: CGRect(x: 3, y: 0, width: lower.frame.width, height: lower.frame.height + 6)).cgPath
            lower.layer.shadowRadius = 3
            lower.layer.masksToBounds = false
        }
        
        for layer in shadowAndSeparator {
            layer.layer.shadowOpacity = 0.3
            layer.layer.shadowPath = UIBezierPath(rect: CGRect(x: 3, y: 0, width: layer.frame.width, height: layer.frame.height + 6)).cgPath
            layer.layer.shadowRadius = 3
            layer.layer.masksToBounds = false
            
            let border = CALayer()
            border.frame = CGRect.init(x: 0, y: layer.frame.height - 1, width: layer.frame.width, height: 1)
            border.backgroundColor = UIColor.systemGray5.cgColor;
            layer.layer.addSublayer(border)
        }
        
        
        colorPickerView.supportsAlpha = false
        colorPickerView.selectedColor = getRandomColor()
        colorPickerView.title = "도전 색상 지정"
        colorPickerView.addTarget(self, action: #selector(colorPickerValueChanged), for: .valueChanged)
        
        
//        startDatePicker.datePickerMode = .date
//        startDatePicker.addTarget(self, action: #selector(startDatePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
//        startDatePicker.preferredDatePickerStyle = .inline
//        startDateTextField.inputView = startDatePicker
//
//        finishDatePicker.datePickerMode = .date
//        finishDatePicker.addTarget(self, action: #selector(finishDatePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
//        finishDatePicker.preferredDatePickerStyle = .compact
//        finishDateTextField.inputView = finishDatePicker
        
        
        categoryTextField.inputView = categoryPickerView
        periodTextField.inputView = periodPickerView
        
        categoryPickerView.dataSource = self
        categoryPickerView.delegate = self
        periodPickerView.dataSource = self
        periodPickerView.delegate = self
        
        categoryPickerView.tag = 1
        periodPickerView.tag = 2
        
        categoryTextField.addTarget(self, action: #selector(categoryValueChanged(sender:)), for: UIControl.Event.editingDidEnd)
        durationTextField.addTarget(self, action: #selector(durationValueChanged(sender:)), for: UIControl.Event.editingDidEnd)
        
        
        
        descriptionTextField.delegate = self
        descriptionTextField.textColor = UIColor.lightGray
        descriptionTextField.tag = 1
        authenticationMethodTextField.delegate = self
        authenticationMethodTextField.textColor = UIColor.lightGray
        authenticationMethodTextField.tag = 2
        
        
        if let selectedChallengeInfo = selectedChallenge {
            titleTextField.text = selectedChallengeInfo.title
            titleTextField.isUserInteractionEnabled = false
            
            descriptionTextField.text = selectedChallengeInfo.description
            descriptionTextField.textColor = UIColor.label
            descriptionTextField.isUserInteractionEnabled = false
            
            authenticationMethodTextField.text = selectedChallengeInfo.authenticationMethod
            authenticationMethodTextField.textColor = UIColor.label
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if indexPath.row == 1 {
                selectedDateIsStartDate = true
                performSegue(withIdentifier: "selectDate", sender: nil)
            } else if indexPath.row == 2 {
                selectedDateIsStartDate = false
                performSegue(withIdentifier: "selectDate", sender: nil)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let datePickerViewController = segue.destination as? DatePickerViewController else { return }
        
        datePickerViewController.delegate = self
        
        datePickerViewController.selectedDateIsStartDate = self.selectedDateIsStartDate
    }
    
    func protocolData(dataSent: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        switch selectedDateIsStartDate {
        case true:
            if today.start <= dataSent {
                correctDate(changedStartDate: true, changedEndDate: false, changedDuration: false, datePicker: dataSent)
            } else {
                self.view.makeToast("시작일은 오늘 혹은 오늘 이후여야 합니다", duration: 3, position: .top, title: "날짜 오류", image: UIImage(named: "charactor1"), style: .init(), completion: nil)
            }
        case false:
            if today.start <= dataSent {
                correctDate(changedStartDate: false, changedEndDate: true, changedDuration: false, datePicker: dataSent)
            } else {
                self.view.makeToast("종료일은 오늘 혹은 오늘 이후여야 합니다", duration: 3, position: .top, title: "날짜 오류", image: UIImage(named: "charactor1"), style: .init(), completion: nil)
            }
        }
    }
    
//    @objc func startDatePickerValueChanged(sender: UIDatePicker) {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy년 MM월 dd일"
//        self.view.endEditing(true)
//        if today.start <= sender.date {
//            correctDate(changedStartDate: true, changedEndDate: false, changedDuration: false, datePicker: sender.date)
//        } else {
//            self.view.makeToast("시작일은 오늘 혹은 오늘 이후여야 합니다", duration: 3, position: .top, title: "날짜 오류", image: UIImage(named: "charactor1"), style: .init(), completion: nil)
//        }
//    }
//    
//    @objc func finishDatePickerValueChanged(sender: UIDatePicker) {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy년 MM월 dd일"
//        self.view.endEditing(true)
//        if today.start <= sender.date {
//            correctDate(changedStartDate: false, changedEndDate: true, changedDuration: false, datePicker: sender.date)
//        } else {
//            self.view.makeToast("종료일은 오늘 혹은 오늘 이후여야 합니다", duration: 3, position: .top, title: "날짜 오류", image: UIImage(named: "charactor1"), style: .init(), completion: nil)
//        }
//
//    }
    
    @objc func durationValueChanged(sender: UITextField) {
        correctDate(changedStartDate: false, changedEndDate: false, changedDuration: true, datePicker: nil)
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
            stringToImageName = "etc"
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
            startDateTextField.text = formatter.string(from: startDate!)
            guard let durationText = durationTextField.text else { return }
            if durationText != "" {
                let timeIntervalDouble = (Double(durationText)! - 1) * 86400
                finishDate = Date(timeInterval: timeIntervalDouble, since: selectedDate)
                finishDateTextField.text = formatter.string(from: finishDate!)
            } else {
                if let haveFinishDate = finishDate {
                    let getInterval = DateInterval(start: selectedDate, end: haveFinishDate)
                    durationTextField.text = "\(Int(getInterval.duration / 86400) + 1)"
                }
            }
        } else if changedEndDate == true {
            guard let selectedDate = datePicker else { return }
            finishDate = selectedDate
            finishDateTextField.text = formatter.string(from: finishDate!)
            guard let durationText = durationTextField.text else { return }
            if durationText != "" {
                let timeIntervalDouble = (Double(durationText)! - 1) * -86400
                let startDateBackup = startDate
                startDate = Date(timeInterval: timeIntervalDouble, since: selectedDate)
                if startDate! < today.start {
                    startDate = startDateBackup
                    finishDate = nil
                    finishDateTextField.text = ""
                    self.view.makeToast("종료일이 진행기간보다 짧게 지정되었습니다", duration: 3, position: .top, title: "날짜 오류", image: UIImage(named: "charactor1"), style: .init(), completion: nil)
                } else {
                    startDateTextField.text = formatter.string(from: startDate!)
                }
            } else {
                if let haveStartDate = startDate {
                    let getInterval = DateInterval(start: haveStartDate, end: selectedDate)
                    durationTextField.text = "\(Int(getInterval.duration / 86400) + 1)"
                }
            }
        } else {
            if let haveStartDate = startDate {
                if let durationText = durationTextField.text {
                    let timeIntervalDouble = (Double(durationText)! - 1) * 86400
                    finishDate = Date(timeInterval: timeIntervalDouble, since: haveStartDate)
                    finishDateTextField.text = formatter.string(from: finishDate!)
                }
            } else if let haveFinishDate = finishDate {
                if let durationText = durationTextField.text {
                    let timeIntervalDouble = (Double(durationText)! - 1) * -86400
                    startDate = Date(timeInterval: timeIntervalDouble, since: haveFinishDate)
                    if startDate! < today.start {
                        startDate = nil
                        durationTextField.text = ""
                        self.view.makeToast("진행기간이 종료일보다 길게 지정되었습니다", duration: 3, position: .top, title: "날짜 오류", image: UIImage(named: "charactor1"), style: .init(), completion: nil)
                    } else {
                        startDateTextField.text = formatter.string(from: startDate!)
                    }
                }
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
                                        
                                        manageUserData.saveUserData()
                                        
                                        self.navigationController?.popToRootViewController(animated: false)
                                        
                                        if let tabbarController = self.view.window?.rootViewController as? UITabBarController {
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

extension CreateChallengeTableViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
                    textView.text = nil
                    textView.textColor = UIColor.label
                }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            if textView.tag == 1 {
                textView.text = "설명을 입력하세요"
                textView.textColor = UIColor.lightGray
            } else if textView.tag == 2 {
                textView.text = "인증 방법을 입력하세요"
                
            }
            textView.textColor = UIColor.lightGray
        }
    }
}
