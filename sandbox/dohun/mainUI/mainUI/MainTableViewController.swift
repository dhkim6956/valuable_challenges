//
//  MainTableViewController.swift
//  mainUI
//
//  Created by 김도훈 on 2021/07/18.
//
import UIKit
import Foundation

class MainTableViewController: UITableViewController {
    
    let objectiveTable = Objectives()
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectiveTable.arrayList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let info = objectiveTable.arrayList[indexPath.row]
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        cell.textLabel?.text = info.title
        cell.detailTextLabel?.text = "\(info.duration)"
        
        return cell
    }
}





