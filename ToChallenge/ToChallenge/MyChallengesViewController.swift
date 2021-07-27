//
//  MyChallengesViewController.swift
//  ToChallenge
//
//  Created by Yejin Lee on 2021/07/25.
//

import UIKit

class MyChallengesViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var challengeCollectionView: UICollectionView!
    
    
    var ongoingChallenges: [OngoingChallenge] = [
        OngoingChallenge(title: "Front-end 정복", ongoingPeriod: 14, finishPeriod: 30, category: "Coding"),
        OngoingChallenge(title: "다양한 분야의 도서 읽기", ongoingPeriod: 189, finishPeriod: 365, category: "독서"),
        OngoingChallenge(title: "매일 영어일기 쓰기", ongoingPeriod: 23, finishPeriod: 100, category: "외국어"),
        OngoingChallenge(title: "1일 1commit", ongoingPeriod: 58, finishPeriod: 100, category: "Coding"),
        OngoingChallenge(title: "매일 러닝 30분", ongoingPeriod: 8, finishPeriod: 30, category: "운동")
    ]
    
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

        // Do any additional setup after loading the view.
        challengeCollectionView.delegate = self
        challengeCollectionView.dataSource = self
    }
    
    //섹션 수 2개 : 진행중인 도전/완료한 도전
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    //각 섹션 마다 들어갈 데이터
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return ongoingChallenges.count
        } else if section == 1 {
            return completeChallenges.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell: ChallengeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChallengeCell", for: indexPath) as! ChallengeCell
            
            cell.myChallengeTitleLabel?.text = ongoingChallenges[indexPath.item].title
            cell.myChallengeCategoryLabel?.text = ongoingChallenges[indexPath.item].category
            cell.myChallengeFinishLabel?.text = "\(ongoingChallenges[indexPath.item].finishPeriod)일"
            cell.myChallengeFinishPeriodLabel?.text = "\(ongoingChallenges[indexPath.item].finishPeriod)일"
            cell.myChallengeIngLabel?.text = "\(ongoingChallenges[indexPath.item].ongoingPeriod)일"
            cell.myChallengeSlashLabel?.text = "/"
            //소수점에 0이 붙음..
            cell.myChallengePercentLabel?.text = "\(floor((Float(Float(ongoingChallenges[indexPath.item].ongoingPeriod) / (Float(ongoingChallenges[indexPath.item].finishPeriod)))) * 100))%"
            
            //cell UI
            cell.layer.cornerRadius = 20
            cell.contentView.layer.cornerRadius = 20
            cell.contentView.layer.borderWidth = 4
            cell.contentView.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            cell.backgroundColor = UIColor.white
            cell.layer.shadowColor = UIColor.darkGray.cgColor
            cell.layer.shadowOffset = CGSize(width: 3, height: 3)
            cell.layer.shadowRadius = 2
            cell.layer.shadowOpacity = 1
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            
            //progress view
            cell.myChallegneProgressBar.progress = Float(Double(ongoingChallenges[indexPath.item].ongoingPeriod) / (Double(ongoingChallenges[indexPath.item].finishPeriod)))
            cell.myChallegneProgressBar.progressViewStyle = . default
            cell.myChallegneProgressBar.progressTintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            cell.myChallegneProgressBar.trackTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
            return cell
        } else if indexPath.section == 1 {
            let cell: ChallengeCell =
                collectionView.dequeueReusableCell(withReuseIdentifier: "ChallengeCell", for: indexPath) as! ChallengeCell
            
            cell.myChallengeTitleLabel?.text = completeChallenges[indexPath.item].title
            cell.myChallengeCategoryLabel?.text = completeChallenges[indexPath.item].category
            cell.myChallengeFinishLabel?.text = "\(completeChallenges[indexPath.item].finishPeriod)일"
            cell.myChallengeFinishPeriodLabel?.text = .none
            cell.myChallengeSlashLabel?.text = .none
            cell.myChallengeIngLabel?.text = .none
            cell.myChallengePercentLabel?.text = "100%"
            
            //cell UI
            
            cell.layer.cornerRadius = 20
            cell.contentView.layer.cornerRadius = 20
            cell.contentView.layer.borderWidth = 4
            cell.contentView.layer.backgroundColor = UIColor.white.cgColor
            cell.contentView.layer.borderColor = UIColor.darkGray.cgColor
            cell.backgroundColor = UIColor.white
            cell.layer.shadowColor = UIColor.darkGray.cgColor
            cell.layer.shadowOffset = CGSize(width: 3, height: 3)
            cell.layer.shadowRadius = 2
            cell.layer.shadowOpacity = 1
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            
            // progress bar
            cell.myChallegneProgressBar.progress = 1
            cell.myChallegneProgressBar.progressViewStyle = .default
            cell.myChallegneProgressBar.progressTintColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
            cell.myChallegneProgressBar.trackTintColor = .darkGray
        
            return cell
        }
            return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 5, bottom: 20, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: 50, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! MyChallengeHeaderView
            
            header.headerLabel?.text = "진행중인 도전"
            
            return header
            
        } else if indexPath.section == 1 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! MyChallengeHeaderView
            
            header.headerLabel?.text = "완료한 도전"
            
            return header
        }
        
        return UICollectionReusableView()
    }
    
}
