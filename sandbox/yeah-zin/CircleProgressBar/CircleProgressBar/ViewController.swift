//
//  ViewController.swift
//  CircleProgressBar
//
//  Created by Yejin Lee on 2021/07/27.
//

import UIKit


class ViewController: UIViewController {


    @IBOutlet weak var CircularProgress: CircularProgressView!
    @IBOutlet weak var progressPercentageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        CircularProgress.trackColor = UIColor.white
        CircularProgress.progressColor = UIColor.green
        CircularProgress.setProgressWithAnimation(duration: 1.0, value: 0.7)
        progressPercentageLabel.text = "7/10"
            }

            @objc func animateProgress() {
                let cP = self.view.viewWithTag(101) as! CircularProgressView
                cP.setProgressWithAnimation(duration: 1.0, value: 0.3)
                
            }
            override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
            }

}

