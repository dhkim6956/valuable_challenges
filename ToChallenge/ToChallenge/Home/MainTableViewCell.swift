//
//  MainTableViewCell.swift
//  ToChallenge
//
//  Created by Yejin Lee on 2021/08/05.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var progressView: CircularProgressView!
    @IBOutlet weak var mainCellTitleLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var mainCellLayer: UIView!
    @IBOutlet weak var sortLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
