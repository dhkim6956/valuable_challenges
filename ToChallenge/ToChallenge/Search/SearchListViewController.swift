//
//  SearchListViewController.swift
//  ToChallenge
//
//  Created by 김도훈 on 2021/08/06.
//

import UIKit

class SearchListViewController: UIViewController, UISearchBarDelegate {
    
    var unAddedChallenges = DefaultChallenges.filter{$0.challengeAdded == false}
    var filteredChallenges: [DefaultChallenge]!
    
    var challengeTitle: [String]!
    var challengeDescription: [String]!
    var challengeType: [String]!
    var challengeDuration: [String]!
    var challengeImage: [String]!
    
    var selectedChallenge: DefaultChallenge? = nil
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var innerSearchBar: UISearchBar!
    @IBOutlet weak var challengeTable: UITableView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        challengeTable.delegate = self
        challengeTable.dataSource = self
        innerSearchBar.delegate = self
        
        tableView.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        unAddedChallenges = DefaultChallenges.filter{$0.challengeAdded == false}
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reAlign(searchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.searchTextField.text {
            if searchText == "" {
                print("찾는 내용이 없습니다.")
            } else {
                reAlign(searchText: searchText)
            }
        }
    }
    
    func reAlign(searchText: String) {
        if searchText == "" {
            filteredChallenges = unAddedChallenges
        } else {
            filteredChallenges = unAddedChallenges.filter{$0.title.lowercased().contains(searchText.lowercased())}
        }
        self.challengeTable.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController = segue.destination as? CreateChallengeTableViewController else { return }
        
        nextViewController.selectedChallenge = self.selectedChallenge
    }
}




extension SearchListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredChallenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = challengeTable.dequeueReusableCell(withIdentifier: "challengeTableCell") as! challengeTableViewCell
        
        
        cell.challengeImage.image = UIImage(named: "challenge_\(filteredChallenges[indexPath.row].category)")
        cell.challengeTitle.attributedText = insertSymbol(textString: filteredChallenges[indexPath.row].title, symbolName: "chevron.forward", symbolColor: .label)
        cell.challengeDescription.text = filteredChallenges[indexPath.row].description
        cell.challengeType.text = {
            var categoryInString: String = ""
            switch filteredChallenges[indexPath.row].category {
            case .certificate:
                categoryInString = "자격증"
            case .coding:
                categoryInString = "코딩"
            case .health:
                categoryInString = "운동"
            case .language:
                categoryInString = "외국어"
            case .reading:
                categoryInString = "독서"
            case .etc:
                categoryInString = "기타"
            }
            return categoryInString
        }()
        cell.challengeDuration.text = "\(filteredChallenges[indexPath.row].duration)days"
        cell.listOutLine.layer.cornerRadius = 10
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedChallenge = filteredChallenges[indexPath.row]
        performSegue(withIdentifier: "challengeSelected", sender: nil)
    }
}
