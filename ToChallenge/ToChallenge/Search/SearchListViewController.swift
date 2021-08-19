//
//  SearchListViewController.swift
//  ToChallenge
//
//  Created by 김도훈 on 2021/08/06.
//

import UIKit

class SearchListViewController: UIViewController, UISearchBarDelegate {
    
    var data: [String] = []
    
    var receivedData: [String] = []
    
    var challengeTitle: [String]!
    var challengeDescription: [String]!
    var challengeType: [String]!
    var challengeDuration: [String]!
    var challengeImage: [String]!
    
    
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
        
        
        for list in DefaultChallenges {
            data.append(list.title)
        }
        getData()
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
        receivedData = []
        if searchText == "" {
            receivedData = data
        } else {
            for title in data {
                if title.lowercased().contains(searchText.lowercased()) {
                    receivedData.append(title)
                }
            }
        }
        getData()
        self.challengeTable.reloadData()
    }
    
    
    func getData() {
        challengeTitle = []
        challengeDescription = []
        challengeType = []
        challengeDuration = []
        challengeImage = []
        
        
        for filteredTitle in receivedData {
            for challenge in DefaultChallenges {
                if filteredTitle == challenge.title {
                    switch challenge.category {
                    case .certificate:
                        challengeType.append("자격증")
                    case .coding:
                        challengeType.append("코딩")
                    case .health:
                        challengeType.append("운동")
                    case .language:
                        challengeType.append("외국어")
                    case .reading:
                        challengeType.append("독서")
                    case .etc:
                        challengeType.append("기타")
                    }
                    
                    
                    
                    challengeImage.append("challenge_\(challenge.category)")
                    challengeTitle.append(challenge.title)
                    challengeDuration.append("\(challenge.duration)days")
                    challengeDescription.append("미완성")
                }
            }
        }
    }
    
    
}




extension SearchListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = challengeTable.dequeueReusableCell(withIdentifier: "challengeTableCell") as! challengeTableViewCell
        
        
        cell.challengeImage.image = UIImage(named: challengeImage[indexPath.row])
        cell.challengeTitle.attributedText = insertSymbol(textString: challengeTitle[indexPath.row], symbolName: "chevron.forward", symbolColor: .label)
        cell.challengeDescription.text = challengeDescription[indexPath.row]
        cell.challengeType.text = challengeType[indexPath.row]
        cell.challengeDuration.text = challengeDuration[indexPath.row]
        cell.listOutLine.layer.cornerRadius = 10
        
        
        return cell
    }
    
}
