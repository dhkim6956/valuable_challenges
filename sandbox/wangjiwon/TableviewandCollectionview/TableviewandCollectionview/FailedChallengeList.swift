//
//  FailedChallengeList.swift
//  TableviewandCollectionview
//
//  Created by 왕지원 on 2021/08/03.
//

import Foundation
import UIKit


class FailedChallengeList: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
   @IBOutlet weak var failedListView: UICollectionView!
    
    var failedChallenge: [FailedChallenge] = [
        FailedChallenge(title: "아침 7시 기상", finishPeriod: 30, ongoingPeriod: 3, category: "자기계발", startDate: "2021.01.01", finishDate: "2021.01.03")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
        
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return failedChallenge.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FailedChallengeCell", for: indexPath) as! FailedChallengeCell
        
        cell.titleLabel?.text = failedChallenge[indexPath.item].title
        cell.categoryLabel?.text = failedChallenge[indexPath.item].category
        //cell.finishedPeriodLabel1?.text = ongoingChallenges[indexPath.item].finishPeriod
        cell.finishedPeriodLabel.text = "\(failedChallenge[indexPath.item].finishPeriod)일"

        //cell.finishedPeriodLabel2?.text = ongoingChallenges[indexPath.item].finishPeriod
        cell.finishedPeriodProgressLabel.text = "\(failedChallenge[indexPath.item].finishPeriod)일"

        //cell.ongoingLabel?.text = ongoingChallenges[indexPath.item].ongoingPeriod
        cell.ongoingLabel?.text = "\(failedChallenge[indexPath.item].ongoingPeriod)일"
        cell.slashLabel?.text = .some("/")
        cell.percentLabel?.text =  "\(floor((Double(Double(failedChallenge[indexPath.item].ongoingPeriod) / (Double(failedChallenge[indexPath.item].finishPeriod)))) * 100))%"
        cell.startDateLabel?.text = failedChallenge[indexPath.item].startDate
        cell.finishDateLabel?.text = failedChallenge[indexPath.item].finishDate
        
            
        cell.layer.cornerRadius = 20
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.borderWidth = 0
        //cell색깔
        cell.contentView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
        cell.progressView.progress =  (Float(Float(failedChallenge[indexPath.item].ongoingPeriod) / (Float(failedChallenge[indexPath.item].finishPeriod))))
            cell.progressView.progressViewStyle = .default
            cell.progressView.progressTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cell.progressView.trackTintColor = .lightGray
            
        
            cell.challengePeriodView.challengePeriodViewTopLine(color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), width: 2.0)
            cell.challengePeriodView.backgroundColor = #colorLiteral(red: 0.9581941962, green: 0.9524978995, blue: 0.9625726342, alpha: 1)
            cell.challengePeriodView.clipsToBounds = true
            cell.challengePeriodView.layer.cornerRadius = 10
            cell.challengePeriodView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner )

        
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
        
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "DetailListHeader", for: indexPath) as! DetailListHeader
            
            header.detailListHeader?.text = "실패한 도전"
     
        return header
    
    }
}



    

    

