//
//  CustomCellTableViewCell.swift
//  CustomTableTest
//
//  Created by Yejin Lee on 2021/07/28.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var progressView: CircularProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellCategoryLabel: UILabel!
    @IBOutlet weak var cellButtonLabel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
