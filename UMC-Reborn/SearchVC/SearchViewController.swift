//
//  SerachViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/23.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var latestCV: UICollectionView!

    @IBOutlet weak var searchBar: UISearchBar!
    
    var latestData: [String] = ["베이커리","어쩌구","저쩌구"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchControllerUI()
        self.view.backgroundColor = UIColor(named: "Background")

        
        
    }
    func setSearchControllerUI() {
        self.searchBar.searchBarStyle = .minimal
        self.searchBar.searchTextField.borderStyle = .none
        self.searchBar.searchTextField.backgroundColor = .white
        self.searchBar.searchTextField.layer.borderWidth = 0.5
        self.searchBar.searchTextField.layer.cornerRadius = 5
        self.searchBar.searchTextField.layer.borderColor = UIColor.black.cgColor
    }

}

extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return latestData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestSearchedCVC", for: indexPath) as! LatestSearchedCell
        
        cell.keyword.text = latestData[indexPath.row]
        
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 0
        cell.keyword.sizeToFit()
//        cell.backgroundColor =
        
        return cell
    }
    
    
}

extension SearchViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = latestCV.dequeueReusableCell(withReuseIdentifier: "LatestSearchedCVC", for: indexPath) as! LatestSearchedCell
        cell.keyword.text = latestData[indexPath.row]
        cell.keyword.sizeToFit()
        
        let cellWidth = cell.keyword.frame.width + 8 + 25 
        return CGSize(width: cellWidth, height: 25)
    }
}
