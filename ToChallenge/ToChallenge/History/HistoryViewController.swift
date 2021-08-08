//
//  HistoryViewController.swift
//  ToChallenge
//
//  Created by Yejin Lee on 2021/08/06.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var historyListTableView: UITableView!
    
    var historyListModel: [String] = ["진행중인 도전", "완료한 도전", "실패한 도전"]

    override func viewDidLoad() {
        super.viewDidLoad()
    
        historyListTableView.tableFooterView = UIView(frame: CGRect.zero)
        

    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return historyListModel.count
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryListCell")!
        
        cell.textLabel?.text = self.historyListModel[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

           tableView.deselectRow(at: indexPath, animated: false)

           switch indexPath.row {

           case 0: performSegue(withIdentifier: "GoOngoingList", sender: self)

           case 1: performSegue(withIdentifier: "GoFinishChallenges", sender: self)

           case 2: performSegue(withIdentifier: "GoFailedChallnegeList", sender: self)

           default:

               return

           }
       }
}
