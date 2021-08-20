//
//  sortTableViewCell.swift
//  ToChallenge
//
//  Created by 김도훈 on 2021/08/20.
//

import UIKit

class sortTableViewCell: UITableViewCell {

    @IBOutlet weak var sortTitle: UILabel!
    @IBOutlet weak var sortDescription: UILabel!
    @IBOutlet weak var sortOutLine: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
