//
//  FinishChallengeList.swift
//  TableviewandCollectionview
//
//  Created by 왕지원 on 2021/08/03.
//

import Foundation
import UIKit



class FinishChallengeList: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var finishListView: UICollectionView!
    
    
    
    var completeChallenges: [CompleteChallenge] = [
        CompleteChallenge(title: "필기시험 2주 준비", finishPeriod: 14, category: "자격증"),
        CompleteChallenge(title: "토익영어단어 외우기", finishPeriod: 30, category: "외국어"),
        CompleteChallenge(title: "독후감 작성", finishPeriod: 30, category: "독서"),
        CompleteChallenge(title: "체지방 1kg 빼기", finishPeriod: 14, category: "운동"),
        CompleteChallenge(title: "필기+실기시험 준비", finishPeriod: 45, category: "자격증"),
        CompleteChallenge(title: "필기시험 4주 준비", finishPeriod: 30, category: "자격증"),
        CompleteChallenge(title: "다이어트 30일", finishPeriod: 30, category: "운동")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
        
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return completeChallenges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FinishChallengeCell", for: indexPath) as! FinishChallengeCell
        
        cell.titleLabel?.text = completeChallenges[indexPath.item].title
        cell.categoryLabel?.text = completeChallenges[indexPath.item].category
        //cell.finishedPeriodLabel1?.text = ongoingChallenges[indexPath.item].finishPeriod
        cell.finishedPeriodLabel.text = "\(completeChallenges[indexPath.item].finishPeriod)일"

        //cell.finishedPeriodLabel2?.text = ongoingChallenges[indexPath.item].finishPeriod
        cell.finishedPeriodProgressLabel.text = "\(completeChallenges[indexPath.item].finishPeriod)일"

        //cell.ongoingLabel?.text = ongoingChallenges[indexPath.item].ongoingPeriod
        cell.ongoingLabel?.text = .none
        cell.slashLabel?.text = .none
        cell.percentLabel?.text = "100%"
        
            
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
            cell.progressView.progress = 1
            cell.progressView.progressViewStyle = .default
            cell.progressView.progressTintColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
            cell.progressView.trackTintColor = .lightGray
            
        
        return cell
            
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 30, right: 5)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width:  , height: cellSize - 80)
//    }
    
    
    //행 사이의 간격
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    // 셀사이의 간격
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        
        
        return CGSize(width: 50, height: 70)
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "DetailListHeader", for: indexPath) as! DetailListHeader
            
            header.detailListHeader?.text = "완료한 도전"

            return header
    
    }

    
    
}
