//
//  FinishedCell.swift
//  ToChallenge
//
//  Created by 왕지원 on 2021/08/08.
//

import Foundation
import UIKit

class HistoryChallengeCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var finishedPeriodLabel: UILabel!
    @IBOutlet weak var finishedPeriodLabelProgress: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var ongoingLabel: UILabel!
    @IBOutlet weak var slashLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var finishDateLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var challengePeriodView: UIView!
}
