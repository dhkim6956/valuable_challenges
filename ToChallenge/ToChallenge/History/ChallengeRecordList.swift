//
//  ChallengeRecord.swift
//  ToChallenge
//
//  Created by 왕지원 on 2021/08/28.
//

import Foundation
import UIKit

class ChallengeRecordList : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var challengeRecordList: UICollectionView!
    
    
    
    var selectedChallenge: UserChallenge!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        challengeRecordList.backgroundColor = #colorLiteral(red: 0.9708310962, green: 0.9650595784, blue: 0.9752674699, alpha: 1)
    
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
           
    }

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return selectedChallenge.dueDates.count
        default:
            return 0
        }
     }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChallengeRecordCell1", for: indexPath) as! ChallengeRecordCell1
        
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "ChallengeRecordCell2", for: indexPath) as! ChallengeRecordCell2
        
        
        let dateFormatter = selectedChallenge.customDateFormat(yyyyMMdd: "yyyy.MM.dd")
        let dateFormatter1 = selectedChallenge.customDateFormat(yyyyMMdd: "yyyy.MM.dd hh:mm a")
        
        
        
        if indexPath.section == 0 {
            cell.titleLabel?.text = selectedChallenge.title
            cell.todayDateLabel?.text = dateFormatter.string(from: Date())
            cell.challengeStatusLabel?.text = selectedChallenge.getProgression()
            
            if selectedChallenge.progression == .waitForStart {
                cell.descriptionLabel?.text = "\(userData.userName)님은 \(selectedChallenge.description)을 목표일.\(selectedChallenge.getEstimatedEndDate())일간 계획하셨습니다."
                
            } else {
                cell.descriptionLabel?.text = "\(userData.userName)님은 \(selectedChallenge.description)을 목표일.\(selectedChallenge.getEstimatedEndDate())일 중 \(selectedChallenge.getInProgressDate())일간 해내셨습니다."
            }
            
            cell.finishPeriodLabel?.text = "\(selectedChallenge.getEstimatedEndDate())일"
            cell.ongoingPeriodLabel?.text = "\(selectedChallenge.getInProgressDate())일"
            cell.percentLabel?.text = "\(Int(selectedChallenge.getDoneAuthenticationCount() / selectedChallenge.getTotalAuthenticationCount()))%"
            cell.slashLabel?.text = "/"
            cell.progressLabel.text = "진행도"

            //cell UI
//            cell.layer.cornerRadius = 20
//            cell.contentView.layer.cornerRadius = 20
//            cell.contentView.layer.borderWidth = 0
//            cell.contentView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//            cell.contentView.layer.borderColor = .none
//            cell.backgroundColor = UIColor.white
//            cell.layer.shadowColor = UIColor.darkGray.cgColor
//            cell.layer.shadowOffset = CGSize(width: 2, height: 2)
//            cell.layer.shadowRadius = 2
//            cell.layer.shadowOpacity = 1
//            cell.layer.masksToBounds = false
//            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            
            cell.layout.layer.cornerRadius = 20
            cell.layout.layer.masksToBounds = true
            cell.layer.masksToBounds = false
            cell.layer.shadowOffset = CGSize(width: 3, height: 3)
            cell.layer.shadowRadius = 3
            cell.layer.shadowOpacity = 0.3
                
            //progressbar UI
            cell.progressBar.progress = selectedChallenge.getDoneAuthenticationCount() / selectedChallenge.getTotalAuthenticationCount()
            cell.progressBar.progressViewStyle = .default
            cell.progressBar.progressTintColor = selectedChallenge.getColor()
            cell.progressBar.trackTintColor = .lightGray
            cell.challengeView.challengePeriodViewTopLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), width: 2.0)
            cell.challengeView.challengePeriodViewBottomLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), width: 2.0)
            cell.challengeView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                
            return cell
            
        } else {
            
            cell1.dateLabel?.text = dateFormatter1.string(from: selectedChallenge.dueDates[indexPath.item].date)
            cell1.titleLabel?.text = selectedChallenge.title
            cell1.certificationImage.image = selectedChallenge.getAuthenticationImage(dueDateIndex: indexPath.item)
            cell1.todayLabel?.text = "\(indexPath.item + 1)일차"
            cell1.recordLabel?.text = selectedChallenge.dueDates[indexPath.item].authenticationReview
                
            //cell UI
//            cell1.layer.cornerRadius = 20
//            cell1.contentView.layer.cornerRadius = 20
//            cell1.contentView.layer.borderWidth = 0
//            cell1.contentView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//            cell1.contentView.layer.borderColor = .none
//            cell1.backgroundColor = UIColor.white
//            cell1.layer.shadowColor = UIColor.darkGray.cgColor
//            cell1.layer.shadowOffset = CGSize(width: 2, height: 2)
//            cell1.layer.shadowRadius = 2
//            cell1.layer.shadowOpacity = 1
//            cell1.layer.masksToBounds = false
//            cell1.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell1.contentView.layer.cornerRadius).cgPath
            cell1.layout.layer.cornerRadius = 20
            cell1.layout.layer.masksToBounds = true
            cell1.layer.masksToBounds = false
            cell1.layer.shadowOffset = CGSize(width: 3, height: 3)
            cell1.layer.shadowRadius = 3
            cell1.layer.shadowOpacity = 0.3
            cell1.recordView.challengePeriodViewTopLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), width: 2.0)
            cell1.recordView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                
            return cell1
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 30, right: 10)
    }
    
    
    //행 사이의 간격
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
   
}

