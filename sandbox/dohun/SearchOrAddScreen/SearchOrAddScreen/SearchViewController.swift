//
//  SearchViewController.swift
//  SearchOrAddScreen
//
//  Created by 김도훈 on 2021/07/29.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchBar.delegate = self
        
        filteredData = data
    }

    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        
        if searchText == "" {
            return
        } else {
            for challenge in data {
                if challenge.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(challenge)
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if filteredData == [] {
            print("찾는 내용이 없습니다.")
        } else {
            performSegue(withIdentifier: "SearchClicked", sender: nil)
        }
    }
   
}

