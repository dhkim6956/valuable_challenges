//
//  FinishedChallengeList.swift
//  ToChallenge
//
//  Created by 왕지원 on 2021/08/08.
//

import Foundation
import UIKit

class HistoryChallengeList: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var historyChallengeList: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    var selectedStatus: UserChallenge.challengeProgression = .onGoing
    var challenges: [UserChallenge] = []
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        challenges = UserChallenges.filter{ $0.progression == .onGoing }
        
        if challenges.count > 0 {
         
        historyChallengeList.reloadData()
            
        }
    }
    
    
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        historyChallengeList.reloadData()
//    }
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
        
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return challenges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryChallengeCell", for: indexPath) as! HistoryChallengeCell
        
        switch selectedStatus {
        
        case .onGoing:
            cell.titleLabel?.text = challenges[indexPath.item].title
            cell.categoryLabel?.text = "\(challenges[indexPath.item].category)"
            cell.finishedPeriodLabel.text = "\(challenges[indexPath.item].getTotalAuthenticationCount())일"
            cell.finishedPeriodLabelProgress.text = "\(challenges[indexPath.item].getTotalAuthenticationCount())일"
            cell.ongoingLabel?.text = "\(challenges[indexPath.item].getInProgressDate())일"
                cell.slashLabel?.text = .some("/")
            cell.startDateLabel?.text = "\(challenges[indexPath.item].getStartDate(yyyyMMdd: "yyyy.MM.dd"))"
            cell.finishDateLabel?.text = "\(challenges[indexPath.item].getFinishDate(yyyyMMdd: "yyyy.MM.dd"))"
                
            //소수점에 0이 붙음
            cell.percentLabel?.text = "\((String(format: "%.0f", ((Double(Double(challenges[indexPath.item].getInProgressDate()) / (Double(challenges[indexPath.item].getTotalAuthenticationCount())))) * 100))))%"
            
                
            cell.layer.cornerRadius = 20
            cell.contentView.layer.cornerRadius = 20
            cell.contentView.layer.borderWidth = 0
            //cell색깔
            cell.contentView.layer.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9249887572, blue: 0.9593478133, alpha: 1)
            //셀 테두리
            cell.contentView.layer.borderColor = .none
            //폰 배경화면 색
            cell.backgroundColor = UIColor.white
            //셀 레이어 그림자색깔
            cell.layer.shadowColor = UIColor.darkGray
                .cgColor
            cell.layer.shadowOffset = CGSize(width: 2, height: 2)
            cell.layer.shadowRadius = 2
            cell.layer.shadowOpacity = 1
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
                
            //프로그레스 바
                cell.progressView.progress = Float(Double(challenges[indexPath.item].getInProgressDate()) / (Double(challenges[indexPath.item].getTotalAuthenticationCount())))
                cell.progressView.progressViewStyle = .default
                cell.progressView.progressTintColor = #colorLiteral(red: 0, green: 0.959014833, blue: 0.1501406729, alpha: 1)
                cell.progressView.trackTintColor = .lightGray
            cell.challengePeriodView.challengePeriodViewTopLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), width: 2.0)
            cell.challengePeriodView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
     

        case .succeed:
            cell.titleLabel?.text = challenges[indexPath.item].title
            cell.categoryLabel?.text = "\(challenges[indexPath.item].category)"
            cell.finishedPeriodLabel.text = "\(challenges[indexPath.item].getTotalAuthenticationCount())일"
            cell.finishedPeriodLabelProgress?.text = "\(challenges[indexPath.item].getTotalAuthenticationCount())일"
            cell.ongoingLabel?.text = .none
            cell.slashLabel?.text = .none
            cell.percentLabel?.text = "100%"
            cell.startDateLabel?.text = challenges[indexPath.item].getStartDate(yyyyMMdd: "yyyy.MM.dd")
            cell.finishDateLabel?.text = challenges[indexPath.item].getFinishDate(yyyyMMdd: "yyyy.MM.dd")
            
                
            cell.layer.cornerRadius = 20
            cell.contentView.layer.cornerRadius = 20
            cell.contentView.layer.borderWidth = 0
            //cell색깔
            cell.contentView.layer.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9249887572, blue: 0.9593478133, alpha: 1)
            //셀 테두리
            cell.contentView.layer.borderColor = .none
            //폰 배경화면 색
            cell.backgroundColor = UIColor.white
            //셀 레이어 그림자색깔
            cell.layer.shadowColor = UIColor.darkGray
                .cgColor
            cell.layer.shadowOffset = CGSize(width: 2, height: 2)
            cell.layer.shadowRadius = 2
            cell.layer.shadowOpacity = 1
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
                
            //프로그레스 바
                cell.progressView.progress = Float(Double(challenges[indexPath.item].getInProgressDate()) / (Double(challenges[indexPath.item].getTotalAuthenticationCount())))
                cell.progressView.progressViewStyle = .default
                cell.progressView.progressTintColor = #colorLiteral(red: 0.01527210232, green: 0.1787953973, blue: 0.9026312828, alpha: 1)
                cell.progressView.trackTintColor = .lightGray
                cell.challengePeriodView.challengePeriodViewTopLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), width: 2.0)
                cell.challengePeriodView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            
        case .failed:
            cell.titleLabel?.text = challenges[indexPath.item].title
            cell.categoryLabel?.text = "\(challenges[indexPath.item].category)"
            cell.finishedPeriodLabel.text = "\(challenges[indexPath.item].getTotalAuthenticationCount())일"
            cell.finishedPeriodLabelProgress.text = "\(challenges[indexPath.item].getTotalAuthenticationCount())일"
            cell.ongoingLabel?.text = "\(challenges[indexPath.item].getInProgressDate())일"
            cell.slashLabel?.text = .some("/")
            cell.percentLabel?.text =  "\((String(format: "%.0f", ((Double(Double(challenges[indexPath.item].getInProgressDate()) / (Double(challenges[indexPath.item].getTotalAuthenticationCount())))) * 100))))%"
            cell.startDateLabel?.text = challenges[indexPath.item].getStartDate(yyyyMMdd: "yyyy.MM.dd")
            cell.finishDateLabel?.text = challenges[indexPath.item].getFinishDate(yyyyMMdd: "yyyy.MM.dd")
            
                
            cell.layer.cornerRadius = 20
            cell.contentView.layer.cornerRadius = 20
            cell.contentView.layer.borderWidth = 0
            //cell색깔
            cell.contentView.layer.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9249887572, blue: 0.9593478133, alpha: 1)
            //셀 테두리
            cell.contentView.layer.borderColor = .none
            //폰 배경화면 색
            cell.backgroundColor = UIColor.white
            //셀 레이어 그림자색깔
            cell.layer.shadowColor = UIColor.darkGray
                .cgColor
            cell.layer.shadowOffset = CGSize(width: 2, height: 2)
            cell.layer.shadowRadius = 2
            cell.layer.shadowOpacity = 1
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
                
            //프로그레스 바
            cell.progressView.progress =  (Float(Float(challenges[indexPath.item].getInProgressDate()) / (Float(challenges[indexPath.item].getDoneAuthenticationCount()))))
                cell.progressView.progressViewStyle = .default
                cell.progressView.progressTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                cell.progressView.trackTintColor = .lightGray
                
            
                cell.challengePeriodView.challengePeriodViewTopLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), width: 2.0)
                cell.challengePeriodView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
 
       
        case .waitForStart:
            return cell
        }
        
        return cell
}

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 30, right: 5)
    }
    
    
    //행 사이의 간격
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    // 셀사이의 간격
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: 50, height: 70)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HistoryListHeader", for: indexPath) as! HistoryListHeader
            
        var titleName = ""

                switch selectedStatus {
                case .onGoing: titleName = "진행중인 도전"
                case .succeed: titleName = "완료한 도전"
                case .failed: titleName = "실패한 도전"
                case .waitForStart: titleName = "시작 전 도전"
                
                }
                    header.historyListHeader?.text = titleName
     
        return header
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        performSegue(withIdentifier: "GoChallengeRecordList", sender: self)
        
        }
    
    }




extension UIView {
    func challengePeriodViewTopLine(color: UIColor, width: CGFloat) {
        
        let topBorderLine = CALayer()
        topBorderLine.backgroundColor = color.cgColor
        topBorderLine.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
       
        self.layer.addSublayer(topBorderLine)
    }
    
    func challengePeriodViewBottomLine(color: UIColor, width: CGFloat) {
        
        let bottomBorderLine = CALayer()
        bottomBorderLine.backgroundColor = color.cgColor
        bottomBorderLine.frame = CGRect(x: 0, y: frame.height - width, width: frame.width, height: width)
        
        self.layer.addSublayer(bottomBorderLine)
    }
    
}
