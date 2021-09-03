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
    
    var historyListModel: [String] = ["진행중인 도전", "완료한 도전", "실패한 도전", "시작 전 도전"]
    var selectedStatus: UserChallenge.challengeProgression = .onGoing

    override func viewDidLoad() {
        super.viewDidLoad()
    
        historyListTableView.tableFooterView = UIView(frame: CGRect.zero)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        historyListTableView.reloadData()
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

        performSegue(withIdentifier: "GoChallengeList", sender: self)


        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let index = historyListTableView.indexPathForSelectedRow!.row // 0, 1, 2
        var selectedStatus: UserChallenge.challengeProgression = .onGoing

        switch index {
        case 0: selectedStatus = .onGoing
        case 1: selectedStatus = .succeed
        case 2: selectedStatus = .failed
        case 3: selectedStatus = .waitForStart
            
        default:
            assertionFailure()
               }

               let vcDest = segue.destination as! HistoryChallengeList

        vcDest.selectedStatus = selectedStatus
        vcDest.challenges = vcDest.challenges.filter({ info in info.progression == selectedStatus
        })
           }

        
    
}
