//
//  searchListTableViewController.swift
//  ToChallenge
//
//  Created by 김도훈 on 2021/08/06.
//

import UIKit

class searchListTableViewController: UITableViewController {

    var receivedData: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        return receivedData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchListCell")! as UITableViewCell
        
        cell.textLabel?.text = receivedData[indexPath.row]
        
        return cell
    }
}
