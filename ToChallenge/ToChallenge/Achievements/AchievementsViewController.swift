//
//  AchievementsViewController.swift
//  ToChallenge
//
//  Created by Yejin Lee on 2021/08/06.
//

import UIKit

class AchievementsViewController: UIViewController {
    @IBOutlet weak var collectView: UICollectionView!
    
    
    let collectModel = AchivementsModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        collectView.dataSource = self
        collectView.delegate = self
        
    }

}

extension AchievementsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectModel.arrayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectCell", for: indexPath) as? CollectCell
        else {
            return UICollectionViewCell()
        }
        
        cell.collectImage.image = UIImage(named: collectModel.arrayList[indexPath.row].imgTitle)
        cell.collectLabel.text = collectModel.arrayList[indexPath.row].title
        

        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 6.0
        cell.layer.shadowOpacity = 1.0
        
        return cell
    }
    
    
}



class CollectCell: UICollectionViewCell {
    @IBOutlet weak var collectImage: UIImageView!
    @IBOutlet weak var collectLabel: UILabel!
    
}
