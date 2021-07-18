//
//  ViewController.swift
//  mainUI
//
//  Created by 김도훈 on 2021/07/18.
//

import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableview_cell") else {
            fatalError("이런 셀은 존재하지 않아!")
        }
        
        cell.textLabel?.text = self.tableArray[indexPath.row]
        
        return cell
    }

}

