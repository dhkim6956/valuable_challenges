//
//  ViewController.swift
//  CustomTableTest
//
//  Created by Yejin Lee on 2021/07/28.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var customTableView: UITableView!
    @IBOutlet weak var levelProgressView: CircularProgressView!
    @IBOutlet var objectImageViews: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTableView.delegate = self
        customTableView.dataSource = self
        
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
        
        let modelCount = challengeModel.arrayList.count
        
        for i in 0...modelCount-1 {
            if challengeModel.arrayList[i].certification == .yes {
                objectImageViews[i].image = UIImage(systemName: "hexagon.fill")
            } else {
                objectImageViews[i].image = UIImage(systemName: "hexagon")
            }
        }
        
        

    }
    
    let challengeModel = HomeChallengesModel()


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challengeModel.arrayList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = customTableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        
        let arrayData = challengeModel.arrayList[indexPath.row]
        
        customCell.progressLabel.text = "\(arrayData.completionDate)/\(arrayData.period)"
        customCell.cellTitleLabel.text = arrayData.title
        if arrayData.category == .normal {
            customCell.cellCategoryLabel.text = "일반도전"
        } else {
            customCell.cellCategoryLabel.text = "서바이벌"
        }
        
        let per = Float(Float(arrayData.completionDate) / Float(arrayData.period))
        

        customCell.progressView.trackColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 224/255, alpha: 1)
        customCell.progressView.progressColor = UIColor.green
        customCell.progressView.setProgressWithAnimation(duration: 1.0, value: per)

        func animateProgress() {
            let cP = self.view.viewWithTag(101) as! CircularProgressView
            cP.setProgressWithAnimation(duration: 1.0, value: Float(1-per))

        }
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
//
        
        return customCell
    }
}

