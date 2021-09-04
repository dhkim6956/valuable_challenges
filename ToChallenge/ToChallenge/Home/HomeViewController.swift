//
//  HomeViewController.swift
//  ToChallenge
//
//  Created by Yejin Lee on 2021/07/25.
//

import UIKit

class MessageCell: UITableViewCell {
    
    
    @IBOutlet weak var messageLayer: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class HomeViewController: UIViewController {
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var levelProgressView: CircularProgressView!
    
    var ongoingChallenges: [UserChallenge]!
    var selectedChallenge: UserChallenge? = nil
    
    
    var haveVisibleChallege = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manageUserData.loadUserData()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ongoingChallenges = UserChallenges.filter{$0.getIsHaveToDoToday()}
        if ongoingChallenges.count > 0 {
            haveVisibleChallege = true
        }
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
        if haveVisibleChallege {
            return ongoingChallenges.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if haveVisibleChallege {
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
        } else {
            let messageCell = mainTableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
            
            messageCell.messageLabel.attributedText = insertSymbol(textString: "오늘까지 인증이 필요한 도전이 없습니다.\n도전 생성하기", symbolName: "chevron.forward", symbolColor: UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0))
            messageCell.messageLayer.layer.cornerRadius = 10
            
            messageCell.messageLayer.layer.shadowOpacity = 0.3
            messageCell.messageLayer.layer.shadowOffset = CGSize(width: 3, height: 3)
            messageCell.messageLayer.layer.shadowRadius = 3
            messageCell.messageLayer.layer.masksToBounds = false
            
            return messageCell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // let cell = mainTableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if haveVisibleChallege {
            selectedChallenge = ongoingChallenges[indexPath.row]
            
            performSegue(withIdentifier: "ProgressDetail", sender: nil)
        } else {
            if let tabbarController = self.navigationController?.tabBarController {
                tabbarController.selectedIndex = 1
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? DetailViewController else { return }
        
        detailViewController.selectedChallenge = self.selectedChallenge
    }
}


