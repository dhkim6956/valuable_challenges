//
//  challengeTableViewCell.swift
//  ToChallenge
//
//  Created by 김도훈 on 2021/08/06.
//

import UIKit

class challengeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var challengeImage: UIImageView!
    @IBOutlet weak var challengeTitle: UILabel!
    @IBOutlet weak var challengeDescription: UILabel!
    @IBOutlet weak var challengeType: UILabel!
    @IBOutlet weak var challengeDuration: UILabel!
    @IBOutlet weak var listOutLine: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
