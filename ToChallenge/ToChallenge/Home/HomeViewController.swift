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
    
    var ongoingChallenges: [UserChallenge]!
    var selectedChallenge: UserChallenge? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ongoingChallenges = UserChallenges.filter{$0.getIsHaveToDoToday()}
        mainTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        levelProgressView.startCircularProgress(trackColor: UIColor(displayP3Red: 222/255, green: 234/255, blue: 224/255, alpha: 1), progressColor: UIColor.systemBlue, duration: 1.0, percentage: 0.3)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ongoingChallenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mainTableCell = mainTableView.dequeueReusableCell(withIdentifier: "MainCell") as! MainTableViewCell
        
        let arrayData = ongoingChallenges[indexPath.row]
        
        mainTableCell.categoryImage.image = arrayData.getCategoryImage()
        mainTableCell.sortLabel.text = arrayData.getSort()
        mainTableCell.progressLabel.text = "\(arrayData .getInProgressDate())/\(arrayData.getEstimatedEndDate())"
        mainTableCell.mainCellTitleLabel.text = arrayData.title
        
        
        let perc = Float(Float(arrayData.getDoneAuthenticationCount()) / Float(arrayData.getTotalAuthenticationCount()))
        
        mainTableCell.progressView.startCircularProgress(trackColor: arrayData.getColor().withAlphaComponent(0.3), progressColor: arrayData.getColor(), duration: 1.0, percentage: perc)
        
        
        mainTableCell.mainCellLayer.layer.cornerRadius = 10
        
        mainTableCell.mainCellLayer.layer.shadowOpacity = 0.3
        mainTableCell.mainCellLayer.layer.shadowOffset = CGSize(width: 3, height: 3)
        mainTableCell.mainCellLayer.layer.shadowRadius = 3
        mainTableCell.mainCellLayer.layer.masksToBounds = false
        
        return mainTableCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // let cell = mainTableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedChallenge = ongoingChallenges[indexPath.row]
        
        
        performSegue(withIdentifier: "ProgressDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? DetailViewController else { return }
        
        detailViewController.selectedChallenge = self.selectedChallenge
    }
    
    
    
}


