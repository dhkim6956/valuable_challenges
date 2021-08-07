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
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        self.performSegue(withIdentifier: "DetailSegue", sender: self)
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//          if let detailList = segue.destination as? DetailListCollectionView {
//
//
//
//    }
//
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChallengeListCell")!
        
        cell.textLabel?.text = self.challengeListModel[indexPath.row]
        
        return cell
    }
    //추가
//
//    override func viewWillAppear(_ animated: Bool) {
//
//            super.viewWillAppear(animated)
//            self.navigationController?.navigationBar.prefersLargeTitles = true
//        }
//        override func viewWillDisappear(_ animated: Bool) {
//            super.viewWillDisappear(animated)
//            self.navigationController?.navigationBar.prefersLargeTitles = false
//        }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

           tableView.deselectRow(at: indexPath, animated: false)

           switch indexPath.row {

           case 0: performSegue(withIdentifier: "GoOngoingList", sender: self)

           case 1: performSegue(withIdentifier: "GoFinishChallenges", sender: self)

           case 2: performSegue(withIdentifier: "GoFailedChallnegeLIst", sender: nil)

           default:

               return

           }
       }
}
