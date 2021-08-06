//
//  MainTableViewCell.swift
//  ToChallenge
//
//  Created by Yejin Lee on 2021/08/05.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var progressView: CircularProgressView!
    @IBOutlet weak var mainCellTitleLabel: UILabel!
    @IBOutlet weak var mainCellButtonLabel: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
