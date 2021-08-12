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
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return collectModel.arrayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectModel.arrayList[1].collectList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "CollectCell", for: indexPath) as! CollectCell
        
        
        cell.collectImage?.image = UIImage(named: "charactor6")
        cell.collectLabel?.text = collectModel.arrayList[1].collectList[indexPath.row]
        
        return cell
        
    }
    
    
}



class CollectCell: UICollectionViewCell {
    @IBOutlet weak var collectImage: UIImageView!
    @IBOutlet weak var collectLabel: UILabel!
    
}
