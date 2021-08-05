//
//  DetailListCell.swift
//  TableviewandCollectionview
//
//  Created by 왕지원 on 2021/08/02.
//

import Foundation
import UIKit

class DetailListCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var finishedPeriodLabel: UILabel!
    
    @IBOutlet weak var percentLabel: UILabel!
    
    @IBOutlet weak var finishedPeriodLabelProgress: UILabel!
    @IBOutlet weak var slashLabel: UILabel!
    @IBOutlet weak var ongoingLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
}
