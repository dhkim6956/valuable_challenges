//
//  DetailChallengeList.swift
//  TableviewandCollectionview
//
//  Created by 왕지원 on 2021/08/16.
//

import Foundation
import UIKit

class DetailChallengeList : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    var certificationRecord: [CertificationRecord] = [
        CertificationRecord(title: "Front-End 정복", category: "Coding", challengeCount: 30, nowCount: 1, startDate: "2021.08.01", finishDate: "2021.08.30", description: "첫날! 열심히 해보자!", status: .onGoing),
        CertificationRecord(title: "Front-End 정복", category: "Coding", challengeCount: 30, nowCount: 2, startDate: "2021.08.01", finishDate: "2021.08.30", description: "둘째날 할만하다!", status: .onGoing),
        CertificationRecord(title: "Front-End 정복", category: "Coding", challengeCount: 30, nowCount: 3, startDate: "2021.08.01", finishDate: "2021.08.30", description: "셋째날 할만하다!", status: .onGoing),
        CertificationRecord(title: "Front-End 정복", category: "Coding", challengeCount: 30, nowCount: 4, startDate: "2021.08.01", finishDate: "2021.08.30", description: "점점 흥미가 생긴다", status: .onGoing),
]
    
    
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return certificationRecord.count
        default:
            return 0
        }
    }
    
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailChallengeCell", for: indexPath) as! DetailChallengeCell
            
            cell.titleLabel?.text = certificationRecord[indexPath.item].title
            cell.descriptionLabel?.text = certificationRecord[indexPath.item].description
            cell.finishPeriodLabel?.text = "\(certificationRecord[indexPath.item].challengeCount)일"
            cell.ongoingPeriodLabel?.text = "\(certificationRecord[indexPath.item].nowCount)일"
            cell.percentLabel?.text = "\(floor((Float(Float(certificationRecord[indexPath.item].nowCount) / (Float(certificationRecord[indexPath.item].challengeCount)))) * 100))%"
            cell.slashLabel?.text = .some("/")

            //cell UI
            cell.layer.cornerRadius = 20
            cell.contentView.layer.cornerRadius = 20
            cell.contentView.layer.borderWidth = 0
            cell.contentView.layer.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9249887572, blue: 0.9593478133, alpha: 1)
            cell.contentView.layer.borderColor = .none
            cell.backgroundColor = UIColor.white
            cell.layer.shadowColor = UIColor.darkGray
                .cgColor
            cell.layer.shadowOffset = CGSize(width: 2, height: 2)
            cell.layer.shadowRadius = 2
            cell.layer.shadowOpacity = 1
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            
            //progressbar UI
            cell.progressBar.progress = Float(Double(certificationRecord[indexPath.item].nowCount) / (Double(certificationRecord[indexPath.item].challengeCount)))
            cell.progressBar.progressViewStyle = .default
            cell.progressBar.progressTintColor = #colorLiteral(red: 0, green: 0.959014833, blue: 0.1501406729, alpha: 1)
            cell.progressBar.trackTintColor = .lightGray
        cell.challengeView.challengePeriodViewTopLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), width: 2.0)
        cell.challengeView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            
            return cell
            
        } else  {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailChallengeCell2", for: indexPath) as! DetailChallengeCell2
            
            cell.dateLabel?.text = ("yyyy-MM-dd".stringFromDate())
            cell.titleLabel?.text = ("HH:mm:ss".stringFromDate())
            cell.certificationImage?.image = #imageLiteral(resourceName: "스크린샷 2021-08-17 12.30.04.png")
            cell.titleLabel?.text = certificationRecord[indexPath.item].title
            cell.todayLabel?.text = "\(certificationRecord[indexPath.item].nowCount)일차"
            cell.recordLabel?.text = "오늘은 ~~을 했다."
            
            //cell UI
            cell.layer.cornerRadius = 20
            cell.contentView.layer.cornerRadius = 20
            cell.contentView.layer.borderWidth = 0
            cell.contentView.layer.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9249887572, blue: 0.9593478133, alpha: 1)
            cell.contentView.layer.borderColor = .none
            cell.backgroundColor = UIColor.white
            cell.layer.shadowColor = UIColor.darkGray
                .cgColor
            cell.layer.shadowOffset = CGSize(width: 2, height: 2)
            cell.layer.shadowRadius = 2
            cell.layer.shadowOpacity = 1
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            cell.recordView.challengePeriodViewTopLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), width: 2.0)
            cell.recordView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    performSegue(withIdentifier: "GoDetailChallengeList", sender: self)
        
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 30, right: 10)
    }
    
    
    //행 사이의 간격
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    // 셀사이의 간격


}


    extension String {
        func stringFromDate() -> String {
            let now = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = self
            dateFormatter.locale = Locale(identifier: "ko_KR")
            return dateFormatter.string(from: now)
        }
    }
