//
//  SerachViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/23.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var latestCV: UICollectionView!
    @IBOutlet weak var searchBar: UITextField!
    
    var latestData: [String] = ["베이커리","어쩌구","저쩌구"]
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNaviBar()
        configure()
        searchBar.delegate = self
        self.view.backgroundColor = UIColor(named: "Background")

    }

    private lazy var searchButton: UIButton = {
          let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -10)
          return button
      }()
    
    private lazy var clearButton: UIButton = {
         let button = UIButton()
         button.setImage(#imageLiteral(resourceName:"ic_Xmark"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 2)
        
//         button.addTarget(self, action: #selector(didTapClearButton), for: .touchUpInside)

         return button
     }()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == self.searchBar {
            userPressedToEnter(keyword: searchBar.text ?? "")
            
        }

        return true

    }
    
    func configure(){
        searchBar.layer.borderWidth = 1.0
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.layer.cornerRadius = 4.0
        searchBar.clearButtonMode = .never
        searchBar.leftView = searchButton
        searchBar.leftViewMode = .always
        searchBar.rightView = clearButton
        searchBar.rightViewMode = .whileEditing
    }

}
extension SearchViewController {
    private func configureNaviBar() {
        navigationController?.additionalSafeAreaInsets.top = 6
        navigationItem.title = "검색"
        navigationController?.navigationBar.tintColor = .black
    }
}
// MARK: - Custom Methods
extension SearchViewController {
    func userPressedToEnter(keyword: String) {
        guard let text = searchBar.text else { return }
        guard let Resultvc = self.storyboard?.instantiateViewController(identifier: "SearchResultVC") as? SearchResultViewController else {
                    return
                }
        
        Resultvc.keyword = text
        navigationController?.pushViewController(Resultvc, animated: true)
    }
    
//    @objc func deleteSearchList(sender : UIButton) {
//        latestCV.deleteItems(at: [IndexPath.init(row: sender.tag, section: 0)])
////        var items = latestData.value
//        items.remove(at: sender.tag)
////        latestData.accept(items)
//    }
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
