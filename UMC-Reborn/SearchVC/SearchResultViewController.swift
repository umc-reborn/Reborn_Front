//
//  SearchResultViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/25.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    var shopList: [String] = ["베이커리","어쩌구","저쩌구","베이커리","어쩌구","저쩌구","베이커리","어쩌구","저쩌구","베이커리","어쩌구","저쩌구"]
    var ratingNum: [String] = ["5.0","4.5","3.2","5.0","4.5","3.2","5.0","4.5","3.2","5.0","4.5","3.2"]
    
    @IBOutlet weak var ResultTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "Background")

        setSearchBar()
        
    }
    
    func setSearchBar(){
        
        //서치바 만들기
        //            let searchBar = UISearchBar()
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 400, height: 0))
        searchBar.placeholder = "Search"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
            
        }
        
    
}

// MARK: - Extensions
extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SearchResultTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! SearchResultTableViewCell
        
        cell.shopnameLabel.text = shopList[indexPath.row]
        cell.ratingnum.text = ratingNum[indexPath.row]
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    
}
