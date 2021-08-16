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
        
        let challengeModel = UsersChallengesModel()
        for list in challengeModel.arrayList {
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
        let challengeModel = UsersChallengesModel()
        
        challengeTitle = []
        challengeDescription = []
        challengeType = []
        challengeDuration = []
        challengeImage = []
        
        
        for filteredTitle in receivedData {
            for challenge in challengeModel.arrayList {
                if filteredTitle == challenge.title {
                    switch challenge.type {
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
                    }
                    challengeImage.append("challenge_\(challenge.type)")
                    challengeTitle.append(challenge.title)
                    challengeDuration.append("\(challenge.period)days")
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
        let cell = challengeTable.dequeueReusableCell(withIdentifier: "challengeTableCell") as! ChallengeTableViewCell
        
        cell.challengeImage.image = UIImage(named: challengeImage[indexPath.row])
        cell.challengeTitle.text = challengeTitle[indexPath.row]
        cell.challengeDescription.text = challengeDescription[indexPath.row]
        cell.challengeType.text = challengeType[indexPath.row]
        cell.challengeDuration.text = challengeDuration[indexPath.row]
        cell.listOutLine.layer.cornerRadius = 10
        
        
        return cell
    }
    
}
