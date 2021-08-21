//
//  SearchViewController.swift
//  ToChallenge
//
//  Created by Yejin Lee on 2021/08/06.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var unAddedChallenges = DefaultChallenges.filter{$0.challengeAdded == false}
    var filteredChallenges: [DefaultChallenge]!
    
    
    @IBOutlet weak var sortTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        sortTable.delegate = self
        sortTable.dataSource = self
        filteredChallenges = unAddedChallenges
    }
    
    override func viewWillAppear(_ animated: Bool) {
        unAddedChallenges = DefaultChallenges.filter{$0.challengeAdded == false}
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
                performSegue(withIdentifier: "filterButtonClicked", sender: nil)
            }
        }
    }
    
    func reAlign(searchText: String) {
        if searchText == "" {
            filteredChallenges = unAddedChallenges
        } else {
            filteredChallenges = unAddedChallenges.filter{$0.title.lowercased().contains(searchText.lowercased())}
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController = segue.destination as? SearchListViewController else { return }
        
        nextViewController.filteredChallenges = self.filteredChallenges
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = sortTable.dequeueReusableCell(withIdentifier: "sortTableCell") as! sortTableViewCell
            var symbolString = ""
            var eachText = ""
            
            switch indexPath.row {
            case 0:
                eachText = "서바이벌 도전 리스트"
                cell.sortDescription.text = "포인트를 걸고 도전에 참가합니다. 도전 완수시 대량의 포인트를 받습니다."
                symbolString = "list.bullet"
            case 1:
                eachText = "일반 도전 리스트"
                cell.sortDescription.text = "포인트를 걸고 도전에 참가합니다. 도전 완수시 대량의 포인트를 받습니다."
                symbolString = "list.bullet"
            default:
                eachText = "나만의 도전 만들기"
                cell.sortDescription.text = "직접 만든 도전에 참가합니다. 도전 완수시 소량의 포인트를 받습니다."
                symbolString = "square.and.pencil"
            }
            cell.sortTitle.attributedText = insertSymbol(textString: eachText, symbolName: symbolString, symbolColor: UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0))
            cell.sortOutLine.layer.cornerRadius = 10
            return cell
        default :
            let cell = sortTable.dequeueReusableCell(withIdentifier: "sortTableCell") as! sortTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        sortTable.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                filteredChallenges = unAddedChallenges.filter{$0.sort == .survival}
                
                performSegue(withIdentifier: "filterButtonClicked", sender: nil)
            case 1:
                filteredChallenges = unAddedChallenges.filter{$0.sort == .normal}
                
                performSegue(withIdentifier: "filterButtonClicked", sender: nil)
            default:
                performSegue(withIdentifier: "createButtonClicked", sender: nil)
            }
        } else {
            manageUserChallenge.saveUserData()
        }
        
    }
}
