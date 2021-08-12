//
//  achievementsModel.swift
//  ToChallenge
//
//  Created by Yejin Lee on 2021/08/12.
//

import Foundation
import UIKit

struct Collectibles {
    let title: String
    let imgTitle: String
    var image: UIImage? {
        return UIImage(named: "\(imgTitle)")
    }
    init(title: String, imgTitle: String) {
        self.title = title
        self.imgTitle = imgTitle
    }
}


class AchivementsModel {
    var arrayList: [Collectibles] = []
    init() {
        arrayList.append(Collectibles(title: "Level1", imgTitle: "charactor1"))
        arrayList.append(Collectibles(title: "Level2", imgTitle: "charactor2"))
        arrayList.append(Collectibles(title: "Level3", imgTitle: "charactor3"))
        arrayList.append(Collectibles(title: "Level4", imgTitle: "charactor4"))
        arrayList.append(Collectibles(title: "Level5", imgTitle: "charactor5"))
        arrayList.append(Collectibles(title: "Level6", imgTitle: "charactor6"))
    }
}
