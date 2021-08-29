//
//  categoryTableViewCell.swift
//  ToChallenge
//
//  Created by 김도훈 on 2021/08/29.
//

import UIKit

class categoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var selectCertificate: UIImageView!
    @IBOutlet weak var selectCoding: UIImageView!
    @IBOutlet weak var selectHealth: UIImageView!
    @IBOutlet weak var selectLanguage: UIImageView!
    @IBOutlet weak var selectReading: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
