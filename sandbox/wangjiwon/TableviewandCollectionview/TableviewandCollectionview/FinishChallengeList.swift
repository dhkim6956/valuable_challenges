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
        CompleteChallenge(title: "필기시험 2주 준비", finishPeriod: 14, category: "자격증", startDate: "2021.06.01", finishDate: "2021.01.15"),
        CompleteChallenge(title: "토익영어단어 외우기", finishPeriod: 30, category: "외국어", startDate: "2021.07.01", finishDate: "2021.07.30"),
        CompleteChallenge(title: "독후감 작성", finishPeriod: 30, category: "독서", startDate: "2021.08.01", finishDate: "2021.08.30"),
        CompleteChallenge(title: "체지방 1kg 빼기", finishPeriod: 14, category: "운동", startDate: "2021.07.15", finishDate: "2021.07.29"),
        CompleteChallenge(title: "필기+실기시험 준비", finishPeriod: 45, category: "자격증", startDate: "2021.06.15", finishDate: "2021.07.30"),
        CompleteChallenge(title: "필기시험 4주 준비", finishPeriod: 30, category: "자격증", startDate: "2022.01.01", finishDate: "2022.01.30"),
        CompleteChallenge(title: "다이어트 30일", finishPeriod: 30, category: "운동", startDate: "2022.01.01", finishDate: "2020.01.30")
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
        cell.startDateLabel?.text = completeChallenges[indexPath.item].startDate
        cell.finishDateLabel?.text = completeChallenges[indexPath.item].finishDate
        
            
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
            cell.progressView.progress = 1
            cell.progressView.progressViewStyle = .default
            cell.progressView.progressTintColor = #colorLiteral(red: 0.01527210232, green: 0.1787953973, blue: 0.9026312828, alpha: 1)
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
        
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "DetailListHeader", for: indexPath) as! DetailListHeader
            
            header.detailListHeader?.text = "완료한 도전"
     
        return header
    
    }
}


extension UIView {
    func challengePeriodViewTopLine(color: UIColor, width: CGFloat) {
        
        let topBorderLine = CALayer()
        topBorderLine.backgroundColor = color.cgColor
        topBorderLine.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        
        self.layer.addSublayer(topBorderLine)
    }
    
}
