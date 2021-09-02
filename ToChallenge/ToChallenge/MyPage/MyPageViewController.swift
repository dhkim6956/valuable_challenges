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
    
    let sectionMenuArray = ["내 프로필", "로그인 정보", "나의 도전", "앱 정보"]
    let firstMenuArray = ["연결 ID"]
    let secondMenuArray = ["관심 분야 설정", "포인트 교환"]
    let thirdMenuArray = ["개인 정보 정책", "이용 약관"]
    let challenges = Challenges()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myPageTableView.backgroundColor = #colorLiteral(red: 0.9720780253, green: 0.9662989974, blue: 0.9765200019, alpha: 1)
        myPageTableView.dataSource = self
        myPageTableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return firstMenuArray.count
        case 2:
            return secondMenuArray.count
        case 3:
            return thirdMenuArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageCustomCell", for: indexPath) as! MyPageCustomCell
            
            cell.characterImage = .none
            cell.startLevel?.text = "Lv 4"
            cell.finisedLevel?.text = "Lv 5"
            cell.presentPointLabel?.text = "82pts"
            cell.finishedPointLabel?.text = "500pts"
//            cell.ongoingChallengeCount?.text = "\(UserChallenge.challengeProgression.onGoing.count)"
//            cell.finishedChallengeCount?.text = "\(challenges.arraylist.count)"
//            cell.failedChallengeCount?.text = "\(challenges.arraylist.count)"
            cell.pointProgressView?.progress = (Float(Float(82) / Float(500)))
            
            cell.backgroundColor = #colorLiteral(red: 0.9720780253, green: 0.9662989974, blue: 0.9765200019, alpha: 1)
            
            cell.pointProgressView.progressTintColor = #colorLiteral(red: 0.2304375768, green: 1, blue: 0.3039473295, alpha: 1)
            cell.pointProgressView.trackTintColor = .darkGray
            
            return cell
    
        }  else if indexPath.section == 1 {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "MyPageCell")
            
            cell.textLabel?.text = firstMenuArray[indexPath.row]
            
            return cell
            
        } else if indexPath.section == 2 {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "MyPageCell")
            cell.textLabel?.text = secondMenuArray[indexPath.row]
            
            return cell
            
        } else {
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: "MyPageCell")
            
            cell.textLabel?.text = thirdMenuArray[indexPath.row]
            
            return cell
            
        }
    
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionMenuArray.count
    }
   
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionMenuArray[section]
    }
}
