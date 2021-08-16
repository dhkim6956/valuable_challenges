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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 
        default:
            <#code#>
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
    
    
    
}
