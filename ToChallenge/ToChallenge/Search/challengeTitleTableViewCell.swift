//
//  challengeTitleTableViewCell.swift
//  ToChallenge
//
//  Created by 김도훈 on 2021/08/12.
//

import UIKit

class challengeTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var challengeImage: UIImageView!
    @IBOutlet weak var challengeTitle: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
