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
    
    var ongoingChallenges: [UserChallenge]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        
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
    override func viewWillAppear(_ animated: Bool) {
        ongoingChallenges = UserChallenges.filter{$0.progression == .onGoing}
        mainTableView.reloadData()
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ongoingChallenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mainTableCell = mainTableView.dequeueReusableCell(withIdentifier: "MainCell") as! MainTableViewCell
        
        let arrayData = ongoingChallenges[indexPath.row]
        
        
        mainTableCell.progressLabel.text = "\(manageUserChallenge.getInProgressDate(from: arrayData))/\(manageUserChallenge.getEstimatedEndDate(from: arrayData))"
        mainTableCell.mainCellTitleLabel.text = arrayData.title
        
        let perc = Float(Float(manageUserChallenge.getDoneAuthenticationCount(from: arrayData)) / Float(manageUserChallenge.getTotalAuthenticationCount(from: arrayData)))
        
        mainTableCell.progressView.trackColor = UIColor(displayP3Red: arrayData.color.redFloat, green: arrayData.color.greenFloat, blue: arrayData.color.blueFloat, alpha: 0.3)
        mainTableCell.progressView.progressColor = UIColor(displayP3Red: arrayData.color.redFloat, green: arrayData.color.greenFloat, blue: arrayData.color.blueFloat, alpha: 1.0)
        mainTableCell.progressView.setProgressWithAnimation(duration: 1.0, value: perc)
        
        func animateProgress() {
            let cP = self.view.viewWithTag(101) as! CircularProgressView
            cP.setProgressWithAnimation(duration: 1.0, value: Float(1-perc))

        }
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
        return mainTableCell
    }
}


