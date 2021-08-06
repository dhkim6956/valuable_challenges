//
//  SearchViewController.swift
//  ToChallenge
//
//  Created by Yejin Lee on 2021/08/06.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    var data: [String] = []
    var filteredData: [String]!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let challengeModel = UsersChallengesModel()
        
        
        searchBar.delegate = self
        for list in challengeModel.arrayList {
            data.append(list.title)
        }
        filteredData = data
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        if searchText == "" {
            filteredData = data
        } else {
            for title in data {
                if title.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(title)
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if filteredData == [] {
            print("찾는 내용이 없습니다.")
        } else {
            performSegue(withIdentifier: "searchButtonClicked", sender: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController = segue.destination as? searchListViewController else { return }
        
        nextViewController.receivedData = self.filteredData
    }
}
