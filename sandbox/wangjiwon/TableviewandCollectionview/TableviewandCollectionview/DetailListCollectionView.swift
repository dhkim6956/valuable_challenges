//
//  DetailListCollectionView.swift
//  TableviewandCollectionview
//
//  Created by 왕지원 on 2021/08/02.
//

import Foundation
import UIKit

class DetailListCollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    @IBOutlet weak var detailListView: UICollectionView!

    
    
    var ongoingChallenges: [OngoingChallenge] = [
        OngoingChallenge(title: "Front-end 정복", ongoingPeriod: 14, finishPeriod: 30, category: "Coding"),
        OngoingChallenge(title: "다양한 분야의 도서 읽기", ongoingPeriod: 189, finishPeriod: 365, category: "독서"),
        OngoingChallenge(title: "매일 영어일기 쓰기", ongoingPeriod: 23, finishPeriod: 100, category: "외국어"),
        OngoingChallenge(title: "1일 1commit", ongoingPeriod: 58, finishPeriod: 100, category: "Coding"),
        OngoingChallenge(title: "매일 러닝 30분", ongoingPeriod: 8, finishPeriod: 30, category: "운동")
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        detailListView.delegate = self
        detailListView.dataSource = self
    
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
        
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return ongoingChallenges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    let cell: DetailListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailListCell", for: indexPath) as! DetailListCell
        
        cell.titleLabel?.text = ongoingChallenges[indexPath.item].title
        cell.categoryLabel?.text = ongoingChallenges[indexPath.item].category
        //cell.finishedPeriodLabel1?.text = ongoingChallenges[indexPath.item].finishPeriod
        cell.finishedPeriodLabel.text = "\(ongoingChallenges[indexPath.item].finishPeriod)일"

        //cell.finishedPeriodLabel2?.text = ongoingChallenges[indexPath.item].finishPeriod
        cell.finishedPeriodLabelProgress.text = "\(ongoingChallenges[indexPath.item].finishPeriod)일"

        //cell.ongoingLabel?.text = ongoingChallenges[indexPath.item].ongoingPeriod
        cell.ongoingLabel?.text = "\(ongoingChallenges[indexPath.item].ongoingPeriod)일"
            cell.slashLabel?.text = .some("/")
            
        //소수점에 0이 붙음
        cell.percentLabel?.text = "\(floor((Float(Float(ongoingChallenges[indexPath.item].ongoingPeriod) / (Float(ongoingChallenges[indexPath.item].finishPeriod)))) * 100))%"
        
            
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
            cell.progressView.progress = Float(Double(ongoingChallenges[indexPath.item].ongoingPeriod) / (Double(ongoingChallenges[indexPath.item].finishPeriod)))
            cell.progressView.progressViewStyle = .default
            cell.progressView.progressTintColor = #colorLiteral(red: 0, green: 0.959014833, blue: 0.1501406729, alpha: 1)
           // cell.progressView.progressTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
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
            
            header.detailListHeader?.text = "진행중인 도전"

            return header
    
    }
}


