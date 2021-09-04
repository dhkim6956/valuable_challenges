//
//  ChallengeRecord.swift
//  ToChallenge
//
//  Created by 왕지원 on 2021/08/28.
//

import Foundation
import UIKit

class ChallengeRecordList : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var challengeRecordList: UICollectionView!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        var newCert = CertificationRecord(title: "해커스 토익 보카", category: "language", challengeCount: 30, nowCount: 1, startDate: "2021.09.05", finishDate: "2021.10.04", description: "첫날! 열심히 해보자!", status: .onGoing, todayDate: "2021.09.05")
        
        newCert.proofImage = info[.editedImage] as? UIImage
        
        
       // UserChallenge(from: newCert  as! Decoder) - 오류
        certificationRecord.append(newCert)
        challengeRecordList.reloadData()
        
    }
    
    @IBAction func addNewProof(_ sender: Any) {
        let picker = UIImagePickerController()
        
        picker.allowsEditing = true
        picker.sourceType = .camera
        
        picker.delegate = self
        
        present(picker, animated: true, completion: nil)
        
    }
    
    var detailSelectedStatus: ChallengeStatus = .onGoing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        challengeRecordList.backgroundColor = #colorLiteral(red: 0.9708310962, green: 0.9650595784, blue: 0.9752674699, alpha: 1)
    
        certificationRecord = certificationRecord.enumerated().map({
            if $0 % 2 == 0 {
               var fixed = $1

                fixed.proofImage = UIImage(named: "proofImage01")

                return fixed
            }
            return $1
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        challenges = UserChallenges.filter{ $0.progression == .onGoing }
//
//       if challenges.count > 0 {
//
//       challengeRecordList.reloadData()
           
       }


var certificationRecord: [CertificationRecord] = [
    CertificationRecord(title: "해커스 토익 보카", category: "language", challengeCount: 30, nowCount: 1, startDate: "2021.09.05", finishDate: "2021.10.04", description: "첫날! 열심히 해보자!", status: .onGoing, todayDate: "2021.09.05"),
    CertificationRecord(title: "해커스 토익 보카", category: "Coding", challengeCount: 30, nowCount: 2, startDate: "2021.09.05", finishDate: "2021.10.04", description: "둘째날 할만하다!", status: .onGoing, todayDate: "2021.09.06"),
    CertificationRecord(title: "해커스 토익 보카", category: "Coding", challengeCount: 30, nowCount: 3, startDate: "2021.09.05", finishDate: "2021.10.04", description: "셋째날.. 오늘만 넘기자", status: .onGoing, todayDate: "2021.09.07"),
    CertificationRecord(title: "해커스 토익 보카", category: "Coding", challengeCount: 30, nowCount: 4, startDate: "2021.09.05", finishDate: "2021.10.04", description: "아는 단어가 점점 많아진다..", status: .onGoing, todayDate: "2021.09.08"),
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
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChallengeRecordCell1", for: indexPath) as! ChallengeRecordCell1
    
    let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "ChallengeRecordCell2", for: indexPath) as! ChallengeRecordCell2
    
    
    switch detailSelectedStatus {
    
    case .onGoing:
        
        if indexPath.section == 0 {
            cell.todayDateLabel?.text = "\("yyyy-MM-dd".stringFromDate())"
            cell.challengeStatusLabel?.text = "진행 중"
            cell.titleLabel?.text = certificationRecord[indexPath.item].title
            cell.descriptionLabel?.text = "지왕님은 Dream Coding 무료 동영상 강의를 듣고 해당 강의에서 작성한 코드를 캡쳐하여 인증하는 과정을 목표일 \(certificationRecord[indexPath.item].challengeCount)일 중 \(certificationRecord[indexPath.item].nowCount)일간 해내셨습니다."
            cell.finishPeriodLabel?.text = "\(certificationRecord[indexPath.item].challengeCount)일"
            cell.ongoingPeriodLabel?.text = "\(certificationRecord[indexPath.item].nowCount)일"
            cell.percentLabel?.text = "\((String(format: "%.0f", ((Double(Double(certificationRecord[indexPath.item].nowCount) / (Double(certificationRecord[indexPath.item].challengeCount)))) * 100))))%"
            cell.slashLabel?.text = .some("/")
            cell.progressLabel?.text = .some("진행도")

            //cell UI
            cell.layer.cornerRadius = 20
            cell.contentView.layer.cornerRadius = 20
            cell.contentView.layer.borderWidth = 0
            cell.contentView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
            cell.challengeView.challengePeriodViewBottomLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), width: 2.0)
            cell.challengeView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            
            return cell
            
        } else if indexPath.section == 1 {
    
            
            cell1.dateLabel?.text = certificationRecord[indexPath.item].todayDate
            cell1.titleLabel?.text = certificationRecord[indexPath.item].title
            cell1.todayLabel?.text = "\(certificationRecord[indexPath.item].nowCount)일차"
            cell1.recordLabel?.text = certificationRecord[indexPath.item].description
            
        
            
           // cell1.certificationImage.image = challenges[indexPath.item].proofImage
            
            //cell UI
            cell1.layer.cornerRadius = 20
            cell1.contentView.layer.cornerRadius = 20
            cell1.contentView.layer.borderWidth = 0
            cell1.contentView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell1.contentView.layer.borderColor = .none
            cell1.backgroundColor = UIColor.white
            cell1.layer.shadowColor = UIColor.darkGray
                .cgColor
            cell1.layer.shadowOffset = CGSize(width: 2, height: 2)
            cell1.layer.shadowRadius = 2
            cell1.layer.shadowOpacity = 1
            cell1.layer.masksToBounds = false
            cell1.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell1.contentView.layer.cornerRadius).cgPath
            cell1.recordView.challengePeriodViewTopLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), width: 2.0)
            cell1.recordView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            
            return cell1
            
        }
            
            case .finished:
            
            if indexPath.section == 0 {
                
                cell.titleLabel?.text = certificationRecord[indexPath.item].title
                cell.todayDateLabel?.text = "\("yyyy-MM-dd".stringFromDate())"
                cell.challengeStatusLabel?.text = "완료"
                cell.descriptionLabel?.text = "지왕님은 Dream Coding 무료 동영상 강의를 듣고 해당 강의에서 작성한 코드를 캡쳐하여 인증하는 과정을 목표일.\(certificationRecord[indexPath.item].challengeCount)일 중 \(certificationRecord[indexPath.item].nowCount)일간 해내셨습니다."
                cell.finishPeriodLabel?.text = "\(certificationRecord[indexPath.item].challengeCount)일"
                cell.ongoingPeriodLabel?.text = "\(certificationRecord[indexPath.item].nowCount)일"
                cell.percentLabel?.text = "\((String(format: "%.0f", ((Double(Double(certificationRecord[indexPath.item].nowCount) / (Double(certificationRecord[indexPath.item].challengeCount)))) * 100))))%"
                cell.slashLabel?.text = .some("/")

                //cell UI
                cell.layer.cornerRadius = 20
                cell.contentView.layer.cornerRadius = 20
                cell.contentView.layer.borderWidth = 0
                cell.contentView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
                cell.challengeView.challengePeriodViewBottomLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), width: 2.0)
                cell.challengeView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                
                return cell
            
            } else if indexPath.section == 1 {
            
                cell1.dateLabel?.text = "\("yyyy-MM-dd".stringFromDate())"
                cell1.titleLabel?.text = "\("HH:mm:ss".stringFromDate())"
                cell1.certificationImage = .none
                cell1.titleLabel?.text = certificationRecord[indexPath.item].title
                cell1.todayLabel?.text = "\(certificationRecord[indexPath.item].nowCount)일차"
                cell1.recordLabel?.text = certificationRecord[indexPath.item].description
                
                //cell UI
                cell1.layer.cornerRadius = 20
                cell1.contentView.layer.cornerRadius = 20
                cell1.contentView.layer.borderWidth = 0
                cell1.contentView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell1.contentView.layer.borderColor = .none
                cell1.backgroundColor = UIColor.white
                cell1.layer.shadowColor = UIColor.darkGray
                    .cgColor
                cell1.layer.shadowOffset = CGSize(width: 2, height: 2)
                cell1.layer.shadowRadius = 2
                cell1.layer.shadowOpacity = 1
                cell1.layer.masksToBounds = false
                cell1.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell1.contentView.layer.cornerRadius).cgPath
                cell1.recordView.challengePeriodViewTopLine(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), width: 2.0)
                cell1.recordView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                
                return cell1
            }

    case .failed:
        return UICollectionViewCell()
    }
            
        return cell
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


    extension String {
        func stringFromDate() -> String {
            let now = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = self
            dateFormatter.locale = Locale(identifier: "ko_KR")
            return dateFormatter.string(from: now)
        }
    }

