//
//  FailedChallengeList.swift
//  ToChallenge
//
//  Created by 왕지원 on 2021/08/08.
//

import Foundation
import UIKit

class FailedChallengeList: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    let failedChallenge = FailedChallengeModel()

    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
        
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return failedChallenge.arraylist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FailedCell", for: indexPath) as! FailedCell
        
        cell.titleLabel?.text = failedChallenge.arraylist[indexPath.item].title
        cell.categoryLabel?.text = failedChallenge.arraylist[indexPath.item].category
        cell.finishedPeriodLabel.text = "\(failedChallenge.arraylist[indexPath.item].finishPeriod)일"
        cell.finishedPeriodProgressLabel.text = "\(failedChallenge.arraylist[indexPath.item].finishPeriod)일"
        cell.ongoingLabel?.text = "\(failedChallenge.arraylist[indexPath.item].ongoingPeriod)일"
        cell.slashLabel?.text = .some("/")
        cell.percentLabel?.text =  "\(floor((Double(Double(failedChallenge.arraylist[indexPath.item].ongoingPeriod) / (Double(failedChallenge.arraylist[indexPath.item].finishPeriod)))) * 100))%"
        cell.startDateLabel?.text = failedChallenge.arraylist[indexPath.item].startDate
        cell.finishDateLabel?.text = failedChallenge.arraylist[indexPath.item].finishDate
        
            
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
        cell.progressView.progress =  (Float(Float(failedChallenge.arraylist[indexPath.item].ongoingPeriod) / (Float(failedChallenge.arraylist[indexPath.item].finishPeriod))))
            cell.progressView.progressViewStyle = .default
            cell.progressView.progressTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cell.progressView.trackTintColor = .lightGray
            
        
            cell.challengePeriodView.challengePeriodViewTopLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), width: 2.0)
            cell.challengePeriodView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
//            cell.challengePeriodView.clipsToBounds = true
//            cell.challengePeriodView.layer.cornerRadius = 10
//            cell.challengePeriodView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner )

        
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
            
            header.historyListHeader?.text = "실패한 도전"
     
        return header
    
    }
}
    
    
