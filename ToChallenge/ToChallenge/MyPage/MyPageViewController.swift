//
//  MyPageViewController.swift
//  ToChallenge
//
//  Created by Yejin Lee on 2021/08/06.
//

import Foundation
import UIKit

class MyPageTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myPageTableView: UITableView!
    
    @IBOutlet weak var inputNameViewBackground: UIView!
    @IBOutlet weak var inputNameView: UIView!
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var changeNameButton: UIButton!
    
    
    
    let sectionMenuArray = ["내 프로필", "유저 정보", "앱 정보"]
    let firstMenuArray = ["이름 변경"]
    let secondMenuArray = ["앱 초기화"]
    let challenges = Challenges()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputNameView.layer.cornerRadius = 10
        changeNameButton.layer.cornerRadius = 10
        changeNameButton.backgroundColor = UIColor.systemBlue
        
        myPageTableView.backgroundColor = #colorLiteral(red: 0.9720780253, green: 0.9662989974, blue: 0.9765200019, alpha: 1)
        myPageTableView.dataSource = self
        myPageTableView.delegate = self
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        myPageTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return firstMenuArray.count
        case 2:
            return secondMenuArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageCustomCell", for: indexPath) as! MyPageCustomCell
            
            cell.characterImage = .none
            
            cell.userName.text = userData.userName
            
            cell.startLevel?.text = "Lv 4"
            cell.finisedLevel?.text = "Lv 5"
            cell.presentPointLabel?.text = "82pts"
            cell.finishedPointLabel?.text = "500pts"
            cell.ongoingChallengeCount?.text =  "\(UserChallenges.filter({ $0.progression == .onGoing }).count)"
            cell.finishedChallengeCount?.text = "\(UserChallenges.filter({ $0.progression == .succeed }).count)"
            cell.failedChallengeCount?.text = "\(UserChallenges.filter({ $0.progression == .failed }).count)"
            cell.pointProgressView?.progress = (Float(Float(82) / Float(500)))
            
            cell.backgroundColor = #colorLiteral(red: 0.9720780253, green: 0.9662989974, blue: 0.9765200019, alpha: 1)
            
            cell.pointProgressView.progressTintColor = #colorLiteral(red: 0.2304375768, green: 1, blue: 0.3039473295, alpha: 1)
            cell.pointProgressView.trackTintColor = .darkGray
            
            return cell
    
        }  else if indexPath.section == 1 {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "MyPageCell")
            
            cell.textLabel?.text = firstMenuArray[indexPath.row]
            
            return cell
            
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "MyPageCell")
            cell.textLabel?.text = secondMenuArray[indexPath.row]
            
            return cell
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionMenuArray.count
    }
   
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionMenuArray[section]
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        myPageTableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                inputNameView.isHidden = false
                inputNameViewBackground.isHidden = false
            }
        }
        
        
        
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                manageUserData.restoreDefaults()
                
                if let tabbarController = self.view.window?.rootViewController as? UITabBarController {
                    tabbarController.selectedIndex = 0
                }
            }
        }
    }
    
    
    @IBAction func changeNameButtonTapped(_ sender: Any) {
        guard let nameString = userNameTextField.text else { return }
        if nameString == "" {
            self.view.makeToast("공백은 사용하실 수 없습니다")
        } else {
            userData.userName = nameString
            
            userNameTextField.text = nameString
            
            inputNameView.isHidden = true
            inputNameViewBackground.isHidden = true
        }
    }
    @IBAction func inputNameViewBackgroundTapped(_ sender: Any) {
        inputNameView.isHidden = true
        inputNameViewBackground.isHidden = true
    }
    
}
