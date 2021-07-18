//
//  MainTableViewController.swift
//  tableviewex
//
//  Created by 왕지원 on 2021/07/18.
//

import Foundation
import UIKit

class MainTableViewController: UITableViewController {
    
    let modelChallenge = challengemodel()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return modelChallenge.arraylist.count
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let info = modelChallenge.arraylist[indexPath.row]
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        cell.textLabel?.text = info.title
        
        cell.detailTextLabel?.text = info.description
        
        return cell
    }
    
    
    
    
    
}
