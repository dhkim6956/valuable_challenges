//
//  SearchViewController.swift
//  ToChallenge
//
//  Created by Yejin Lee on 2021/08/06.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    let challengeModel = UsersChallengesModel()
    
    var data: [String] = []
    var filteredData: [String]!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var createChallengeWay: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        searchBar.delegate = self
        for list in challengeModel.arrayList {
            data.append(list.title)
        }
        filteredData = data
        
        for index in 0...2 {
            createChallengeWay[index].layer.cornerRadius = 10
        }
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reAlign(searchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if  let searchText = searchBar.searchTextField.text {
            reAlign(searchText: searchText)
        
            if searchText == "" {
                print("찾는 내용이 없습니다.")
            } else {
                performSegue(withIdentifier: "searchButtonClicked", sender: nil)
            }
        }
    }
    
    func reAlign(searchText: String) {
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController = segue.destination as? searchListViewController else { return }
        
        nextViewController.receivedData = self.filteredData
    }
    
    @IBAction func survivalChallengeTapped(_ sender: Any) {
        filteredData = []
                
        for challenge in challengeModel.arrayList {
            if challenge.category == .serviver {
                filteredData.append(challenge.title)
            }
        }
        
        performSegue(withIdentifier: "searchButtonClicked", sender: nil)
    }
    
    @IBAction func normalChallengeTapped(_ sender: Any) {
        filteredData = []
                
        for challenge in challengeModel.arrayList {
            if challenge.category == .normal {
                filteredData.append(challenge.title)
            }
        }
        
        performSegue(withIdentifier: "searchButtonClicked", sender: nil)
    }
}
