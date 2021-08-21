//
//  SearchViewController.swift
//  ToChallenge
//
//  Created by Yejin Lee on 2021/08/06.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let range = ["제목만", "제목 + 설명"]
    let category = ["자격증", "코딩", "운동", "외국어", "독서", "기타", "전부"]
    
    let durationAtLeast = ["1일 이상", "1주일 이상", "1달 이상", "1년 이상"]
    var selectedAtLeast = -1
    let durationAtMost = ["1주일 이하", "1달 이하", "1년 이하", "전부"]
    var selectedAtMost = -1
    
    let period = ["매년", "매월", "매일", "일요일마다", "월요일마다", "화요일마다", "수요일마다", "목요일마다", "금요일마다", "토요일마다", "전부"]
    
    var rangePickerView = UIPickerView()
    var categoryPickerView = UIPickerView()
    var durationPickerView = UIPickerView()
    var periodPickerView = UIPickerView()
    
    
    var unAddedChallenges = DefaultChallenges.filter{$0.challengeAdded == false}
    var filteredChallenges: [DefaultChallenge]!
    var selectedChallenges: [DefaultChallenge]!
    
    @IBOutlet var filterViews: [UIView]!
    @IBOutlet weak var filterButton: UIView!
    
    @IBOutlet weak var filterSwitch: UISwitch!
    @IBOutlet weak var filterSwitchText: UILabel!
    @IBOutlet weak var searchRangeTextField: PickerUITextField!
    @IBOutlet weak var searchCategoryTextField: PickerUITextField!
    @IBOutlet weak var searchDurationTextField: PickerUITextField!
    @IBOutlet weak var searchPeriodTextField: PickerUITextField!
    
    
    @IBOutlet weak var sortTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        sortTable.delegate = self
        sortTable.dataSource = self
        selectedChallenges = unAddedChallenges
        
        filterButton.layer.cornerRadius = filterButton.frame.height/2
        filterViews[1].layer.cornerRadius = 10
        filterSwitch.addTarget(self, action: #selector(switchValueChanged(sender:)), for: UIControl.Event.valueChanged)
        
        searchRangeTextField.inputView = rangePickerView
        searchCategoryTextField.inputView = categoryPickerView
        searchDurationTextField.inputView = durationPickerView
        searchPeriodTextField.inputView = periodPickerView
        
        rangePickerView.dataSource = self
        rangePickerView.delegate = self
        categoryPickerView.dataSource = self
        categoryPickerView.delegate = self
        durationPickerView.dataSource = self
        durationPickerView.delegate = self
        periodPickerView.dataSource = self
        periodPickerView.delegate = self
        
        rangePickerView.tag = 1
        categoryPickerView.tag = 2
        durationPickerView.tag = 3
        periodPickerView.tag = 4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        unAddedChallenges = DefaultChallenges.filter{$0.challengeAdded == false}
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reAlign(searchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if  let searchText = searchBar.searchTextField.text {
            reAlign(searchText: searchText)
        
            performSegue(withIdentifier: "filterButtonClicked", sender: nil)
        }
    }
    
    func reAlign(searchText: String) {
        switch filterSwitch.isOn {
        case true:
            if searchText == "" {
                selectedChallenges = filteredChallenges
            } else {
                switch searchRangeTextField.text {
                case "제목만":
                    selectedChallenges = filteredChallenges.filter{$0.title.lowercased().contains(searchText.lowercased())}
                default:
                    selectedChallenges = filteredChallenges.filter{$0.title.lowercased().contains(searchText.lowercased()) || $0.description.lowercased().contains(searchText.lowercased()) || $0.authenticationMethod.lowercased().contains(searchText.lowercased())}
                }
            }
        case false:
            if searchText == "" {
                selectedChallenges = unAddedChallenges
            } else {
                selectedChallenges = unAddedChallenges.filter{$0.title.lowercased().contains(searchText.lowercased())}
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController = segue.destination as? SearchListViewController else { return }
        
        nextViewController.selectedChallenges = self.selectedChallenges
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = sortTable.dequeueReusableCell(withIdentifier: "sortTableCell") as! sortTableViewCell
            var symbolString = ""
            var eachText = ""
            
            switch indexPath.row {
            case 0:
                eachText = "서바이벌 도전 리스트"
                cell.sortDescription.text = "포인트를 걸고 도전에 참가합니다. 도전 완수시 대량의 포인트를 받습니다."
                symbolString = "list.bullet"
            case 1:
                eachText = "일반 도전 리스트"
                cell.sortDescription.text = "포인트를 걸고 도전에 참가합니다. 도전 완수시 대량의 포인트를 받습니다."
                symbolString = "list.bullet"
            default:
                eachText = "나만의 도전 만들기"
                cell.sortDescription.text = "직접 만든 도전에 참가합니다. 도전 완수시 소량의 포인트를 받습니다."
                symbolString = "square.and.pencil"
            }
            cell.sortTitle.attributedText = insertSymbol(textString: eachText, symbolName: symbolString, symbolColor: UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0))
            cell.sortOutLine.layer.cornerRadius = 10
            return cell
        default :
            let cell = sortTable.dequeueReusableCell(withIdentifier: "sortTableCell") as! sortTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        sortTable.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                switch filterSwitch.isOn {
                case true:
                    selectedChallenges = filteredChallenges.filter{$0.sort == .survival}
                case false:
                    selectedChallenges = unAddedChallenges.filter{$0.sort == .survival}
                }
                
                performSegue(withIdentifier: "filterButtonClicked", sender: nil)
            case 1:
                switch filterSwitch.isOn {
                case true:
                    selectedChallenges = filteredChallenges.filter{$0.sort == .normal}
                case false:
                    selectedChallenges = unAddedChallenges.filter{$0.sort == .normal}
                }
                
                performSegue(withIdentifier: "filterButtonClicked", sender: nil)
            default:
                performSegue(withIdentifier: "createButtonClicked", sender: nil)
            }
        } else {
            manageUserChallenge.saveUserData()
        }
        
    }
    
    @objc func switchValueChanged(sender: UISwitch) {
        switch sender.isOn {
        case true:
            filterSwitchText.text = "필터 켬"
        case false:
            filterSwitchText.text = "필터 끔"
        }
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        for filterView in filterViews {
            switch filterView.isHidden {
            case true:
                filterView.isHidden = false
            case false:
                filterView.isHidden = true
            }
            
        }
    }
    
    @IBAction func filterApplyButtonTapped(_ sender: Any) {
        for filterView in filterViews {
            filterView.isHidden = true
        }
        self.view.endEditing(true)
        
        var categoryFilteredChallenges: [DefaultChallenge]
        
        if searchCategoryTextField.text == "전부" || searchCategoryTextField.text == "" {
            categoryFilteredChallenges = unAddedChallenges
        } else {
            categoryFilteredChallenges = unAddedChallenges.filter{$0.category == {
                switch searchCategoryTextField.text {
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
            }()}
        }
        
        var durationFilteredChallenges: [DefaultChallenge]
        
        if selectedAtLeast == 0 && selectedAtMost == 3 || selectedAtLeast == -1 || selectedAtMost == -1 {
            durationFilteredChallenges = categoryFilteredChallenges
        } else {
            durationFilteredChallenges = categoryFilteredChallenges.filter({(challenge: DefaultChallenge) -> Bool in
                var atLeastDate: Int
                var atMostDate: Int
                switch selectedAtLeast {
                case 0:
                    atLeastDate = 1
                case 1:
                    atLeastDate = 7
                case 2:
                    atLeastDate = 30
                default:
                    atLeastDate = 365
                }
                switch selectedAtMost {
                case 0:
                    atMostDate = 7
                case 1:
                    atMostDate = 30
                case 2:
                    atMostDate = 365
                default:
                    atMostDate = Int.max
                }
                
                if challenge.duration >= atLeastDate && challenge.duration <= atMostDate {
                    return true
                } else {
                    return false
                }
            })
        }
        
        var periodFilteredChallenges: [DefaultChallenge]
        
        switch searchPeriodTextField.text {
        case "매년":
            periodFilteredChallenges = categoryFilteredChallenges.filter{$0.authenticationPeriod == .everyYear}
        case "매월":
            periodFilteredChallenges = categoryFilteredChallenges.filter{$0.authenticationPeriod == .everyMonth}
        case "매일":
            periodFilteredChallenges = categoryFilteredChallenges.filter{$0.authenticationPeriod == .everyDay}
        case "일요일마다":
            periodFilteredChallenges = categoryFilteredChallenges.filter{$0.authenticationPeriod == .everySunday}
        case "월요일마다":
            periodFilteredChallenges = categoryFilteredChallenges.filter{$0.authenticationPeriod == .everyMonday}
        case "화요일마다":
            periodFilteredChallenges = categoryFilteredChallenges.filter{$0.authenticationPeriod == .everyTuesday}
        case "수요일마다":
            periodFilteredChallenges = categoryFilteredChallenges.filter{$0.authenticationPeriod == .everyWednesday}
        case "목요일마다":
            periodFilteredChallenges = categoryFilteredChallenges.filter{$0.authenticationPeriod == .everyThursday}
        case "금요일마다":
            periodFilteredChallenges = categoryFilteredChallenges.filter{$0.authenticationPeriod == .everyFriday}
        case "토요일마다":
            periodFilteredChallenges = categoryFilteredChallenges.filter{$0.authenticationPeriod == .everySaturday}
        default:
            periodFilteredChallenges = durationFilteredChallenges
        }
        filteredChallenges = periodFilteredChallenges
    }
    
    @IBAction func filterBackgroundTapped(_ sender: Any) {
        for filterView in filterViews {
            filterView.isHidden = true
        }
        self.view.endEditing(true)
    }
    @IBAction func filterViewTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
}

extension SearchViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView.tag {
        case 3:
            return 2
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return range.count
        case 2:
            return category.count
        case 3:
            switch component {
            case 0:
                return durationAtLeast.count
            default:
                return durationAtMost.count
            }
        case 4:
            return period.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return range[row]
        case 2:
            return category[row]
        case 3:
            switch component {
            case 0:
                return durationAtLeast[row]
            default:
                return durationAtMost[row]
            }
        case 4:
            return period[row]
        default:
            return "잘못된 접근입니다"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            searchRangeTextField.text = range[row]
        case 2:
            searchCategoryTextField.text = category[row]
        case 3:
            switch component {
            case 0:
                if selectedAtMost == -1 {
                    selectedAtMost = 0
                }
                
                if row - selectedAtMost > 1 {
                    print("최소기간을 최대 기간보다 짧게 설정하세요")
                } else {
                    selectedAtLeast = row
                    searchDurationTextField.text = "\(durationAtLeast[selectedAtLeast]) \(durationAtMost[selectedAtMost])"
                }
            default:
                if selectedAtLeast == -1 {
                    selectedAtLeast = 0
                }
                
                if selectedAtLeast - row > 1 {
                    print("최대 기간을 최소 기간보다 길게 설정하세요")
                } else {
                    selectedAtMost = row
                    searchDurationTextField.text = "\(durationAtLeast[selectedAtLeast]) \(durationAtMost[selectedAtMost])"
                }
            }
        case 4:
            searchPeriodTextField.text = period[row]
        default:
            return
        }
    }
}
