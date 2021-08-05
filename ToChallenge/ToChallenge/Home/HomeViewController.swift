//
//  HomeViewController.swift
//  ToChallenge
//
//  Created by Yejin Lee on 2021/07/25.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var levelProgressView: CircularProgressView!
    @IBOutlet var objectImageViews: [UIImageView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        levelProgressView.trackColor = UIColor(displayP3Red: 222/255, green: 234/255, blue: 224/255, alpha: 1)
        levelProgressView.progressColor = UIColor.systemBlue
        levelProgressView.setProgressWithAnimation(duration: 1.0, value: 0.3)
        
        func animateProgress() {
            let cP = self.view.viewWithTag(101) as! CircularProgressView
            cP.setProgressWithAnimation(duration: 1.0, value: 0.7)

        }
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
        
        
    }

}


