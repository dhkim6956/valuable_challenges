//
//  MainTableViewController.swift
//  challengeTable
//
//  Created by Yejin Lee on 2021/07/18.
//

import UIKit

class MainTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    let challengeM = ChallengesModel()


    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return challengeM.arrayList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let array = challengeM.arrayList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1")!
        
        cell.textLabel?.text = array.title
        cell.detailTextLabel?.text = array.desc
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vcDest = segue.destination as! DetailViewController
        let cellSelected = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cellSelected)!
        let info = challengeM.arrayList[indexPath.row]
        
        vcDest.challenge = info
    }
    
}
