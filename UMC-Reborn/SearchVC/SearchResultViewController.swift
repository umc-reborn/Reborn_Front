//
//  SearchResultViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/25.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBar()
        
    }
    
    func setSearchBar(){
        
        //서치바 만들기
        //            let searchBar = UISearchBar()
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 0))
        searchBar.placeholder = "Search"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
    
            
        }
        
}
