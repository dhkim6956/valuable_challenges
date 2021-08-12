//
//  OngoingChallengeList.swift
//  ToChallenge
//
//  Created by 왕지원 on 2021/08/08.
//

import Foundation
import UIKit

class OngoingChallengeList: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var selectedStatus: ChallengeStatus = .onGoing
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    let ongoingChallenge = OngoingChallnegeModel()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
        
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return ongoingChallenge.arraylist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    let cell:OngoingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OngoingCell", for: indexPath) as!OngoingCell
        
        cell.titleLabel?.text = ongoingChallenge.arraylist[indexPath.item].title
        cell.categoryLabel?.text = ongoingChallenge.arraylist[indexPath.item].category
        cell.finishedPeriodLabel.text = "\(ongoingChallenge.arraylist[indexPath.item].finishPeriod)일"
        cell.finishedPeriodLabelProgress.text = "\(ongoingChallenge.arraylist[indexPath.item].finishPeriod)일"
        cell.ongoingLabel?.text = "\(ongoingChallenge.arraylist[indexPath.item].ongoingPeriod)일"
            cell.slashLabel?.text = .some("/")
            
        //소수점에 0이 붙음
        cell.percentLabel?.text = "\(floor((Float(Float(ongoingChallenge.arraylist[indexPath.item].ongoingPeriod) / (Float(ongoingChallenge.arraylist[indexPath.item].finishPeriod)))) * 100))%"
        
            
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
            cell.progressView.progress = Float(Double(ongoingChallenge.arraylist[indexPath.item].ongoingPeriod) / (Double(ongoingChallenge.arraylist[indexPath.item].finishPeriod)))
            cell.progressView.progressViewStyle = .default
            cell.progressView.progressTintColor = #colorLiteral(red: 0, green: 0.959014833, blue: 0.1501406729, alpha: 1)
            cell.progressView.trackTintColor = .lightGray
        
        return cell
            
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 30, right: 5)
    }

    
    
    //행 사이의 간격
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: 50, height: 70)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HistoryListHeader", for: indexPath) as! HistoryListHeader
            
        var titleName = ""
        
        switch selectedStatus {
        case .onGoing: titleName = "진행중"
        case .finished: titleName = "완료됨"
        case .failed: titleName = "실패함"
        }
            header.historyListHeader?.text = titleName

            return header
    
    }
    
}
