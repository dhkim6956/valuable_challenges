//
//  ChallengeList.swift
//  TableviewandCollectionview
//
//  Created by 왕지원 on 2021/08/02.
//

import Foundation
import UIKit

class ChallengeList: UITableViewController {
    
    
    var challengeListModel: [String] = ["진행중인 도전", "완료한 도전", "실패한 도전"]
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.backgroundColor = #colorLiteral(red: 0.9512260556, green: 0.9455711246, blue: 0.9555727839, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return challengeListModel.count
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChallengeListCell")!
        
        cell.textLabel?.text = self.challengeListModel[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "GoChallengeList", sender: self)

        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let index = tableView.indexPathForSelectedRow!.row // 0, 1, 2
        var selectedStatus: ChallengeStatus = .onGoing

        switch index {
        case 0: selectedStatus = .onGoing
        case 1: selectedStatus = .finished
        case 2: selectedStatus = .failed
        default:
            assertionFailure()
               }

               let vcDest = segue.destination as! HistoryChallengeList

               vcDest.selectedStatus = selectedStatus

               vcDest.challenges.arraylist = vcDest.challenges.arraylist.filter({ info in
                   info.status == selectedStatus
               })
           }
}
