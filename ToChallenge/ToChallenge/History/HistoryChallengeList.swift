//
//  FinishedChallengeList.swift
//  ToChallenge
//
//  Created by 왕지원 on 2021/08/08.
//

import Foundation
import UIKit

class HistoryChallengeList: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    
    }
    
    var selectedStatus: ChallengeStatus = .onGoing
    let challenges = Challenges()
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var sectionTitle = ""
        switch selectedStatus {
        case .failed:
            sectionTitle = "실패한 도전"
        case .onGoing:
            sectionTitle = "진행중인 도전"
        case .finished:
            sectionTitle = "완료한 도전"
        }
        return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenges.arraylist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryChallengeCell", for: indexPath) as! HistoryChallengeCell
        
        switch selectedStatus {
        
        case .onGoing:
            cell.titleLabel?.text = challenges.arraylist[indexPath.item].title
            cell.categoryLabel?.text = challenges.arraylist[indexPath.item].category
            cell.finishedPeriodLabel.text = "\(challenges.arraylist[indexPath.item].finishPeriod)일"
            cell.finishedPeriodLabelProgress.text = "\(challenges.arraylist[indexPath.item].finishPeriod)일"
            cell.ongoingLabel?.text = "\(challenges.arraylist[indexPath.item].ongoingPeriod)일"
            cell.slashLabel?.text = .some("/")
            //소수점에 0이 붙음
            cell.percentLabel?.text = "\(floor(Float(Float(challenges.arraylist[indexPath.item].ongoingPeriod) / (Float(challenges.arraylist[indexPath.item].finishPeriod)))) * 100)%"
            //프로그레스 바
            cell.progressView.progress = Float(Double(challenges.arraylist[indexPath.item].ongoingPeriod) / (Double(challenges.arraylist[indexPath.item].finishPeriod)))
            cell.progressView.progressViewStyle = .default
            cell.progressView.progressTintColor = #colorLiteral(red: 0, green: 0.959014833, blue: 0.1501406729, alpha: 1)
            cell.progressView.trackTintColor = .lightGray
     

        case .finished:
            cell.titleLabel?.text = challenges.arraylist[indexPath.item].title
            cell.categoryLabel?.text = challenges.arraylist[indexPath.item].category
            cell.finishedPeriodLabel.text = "\(challenges.arraylist[indexPath.item].finishPeriod)일"
            cell.finishedPeriodLabelProgress?.text = "\(challenges.arraylist[indexPath.item].finishPeriod)일"
            cell.ongoingLabel?.text = .none
            cell.slashLabel?.text = .none
            cell.percentLabel?.text = "100%"
            cell.startDateLabel?.text = challenges.arraylist[indexPath.item].startDate
            cell.finishDateLabel?.text = challenges.arraylist[indexPath.item].finishDate
                
            //프로그레스 바
            cell.progressView.progress = 1
            cell.progressView.progressViewStyle = .default
            cell.progressView.progressTintColor = #colorLiteral(red: 0.01527210232, green: 0.1787953973, blue: 0.9026312828, alpha: 1)
            cell.progressView.trackTintColor = .lightGray
            
        case .failed:
            cell.titleLabel?.text = challenges.arraylist[indexPath.item].title
            cell.categoryLabel?.text = challenges.arraylist[indexPath.item].category
            cell.finishedPeriodLabel.text = "\(challenges.arraylist[indexPath.item].finishPeriod)일"
            cell.finishedPeriodLabelProgress.text = "\(challenges.arraylist[indexPath.item].finishPeriod)일"
            cell.ongoingLabel?.text = "\(challenges.arraylist[indexPath.item].ongoingPeriod)일"
            cell.slashLabel?.text = .some("/")
            cell.percentLabel?.text =  "\(floor((Double(Double(challenges.arraylist[indexPath.item].ongoingPeriod) / (Double(challenges.arraylist[indexPath.item].finishPeriod)))) * 100))%"
            cell.startDateLabel?.text = challenges.arraylist[indexPath.item].startDate
            cell.finishDateLabel?.text = challenges.arraylist[indexPath.item].finishDate
            
            //프로그레스 바
            cell.progressView.progress =  (Float(Float(challenges.arraylist[indexPath.item].ongoingPeriod) / (Float(challenges.arraylist[indexPath.item].finishPeriod))))
            cell.progressView.progressViewStyle = .default
            cell.progressView.progressTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cell.progressView.trackTintColor = .lightGray
        }
        cell.layout.layer.cornerRadius = 20
        cell.layout.layer.shadowColor = UIColor.darkGray
            .cgColor
        cell.layout.layer.shadowOpacity = 0.5
        cell.layout.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.layout.layer.shadowRadius = 2
        cell.layout.layer.masksToBounds = false
        return cell
    }
}
