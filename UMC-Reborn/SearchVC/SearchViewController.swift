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
    @IBOutlet var WillLikeShop: UICollectionView!
    
    @IBOutlet var titleLabel: UILabel!
    var latestData: [String] = ["베이커리","어쩌구","저쩌구"]
    var shopList: [String] = ["가나베이커리","하하베이커리","어쩌구","저쩌구","하이하이"]
    var shopLocationList: [String] = ["마포구","공릉동","홍제동","연남동","서초동"]
    var imageList: [String] = ["image 1","image 3","image 1","image 3","image 1"]
    let username = UserDefaults.standard.string(forKey: "userNickName")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNaviBar()
        configure()
        searchBar.delegate = self
        
        
        self.view.backgroundColor = UIColor(named: "Background")
        titleLabel.text = "\(username!)"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.searchBar.resignFirstResponder()
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
        
        if collectionView == latestCV {
            return latestData.count
            
        }
        if collectionView == WillLikeShop {
            return shopList.count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestSearchedCVC", for: indexPath) as! LatestSearchedCell
//
        if collectionView == latestCV {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestSearchedCVC", for: indexPath) as! LatestSearchedCell
            
            cell.keyword.text = latestData[indexPath.row]
            
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 0
            cell.keyword.sizeToFit()
            //        cell.backgroundColor =
            
            return cell
        }
        if collectionView == WillLikeShop {
            
            let shopcell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeShopCell", for: indexPath) as! WillLikeShopCell
            
            shopcell.backgroundColor = .clear
            shopcell.shopImage.layer.cornerRadius = 10
            shopcell.layer.borderWidth = 0
            
            shopcell.shopName.text = shopList[indexPath.row]
            shopcell.shopLocation.text = shopLocationList[indexPath.row]
            shopcell.shopImage.image = UIImage(named: imageList[indexPath.row]) ?? UIImage()
    //        cell.shopImage.reloadData()
            return shopcell
        }
        return UICollectionViewCell()
    }
    
    
}

extension SearchViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == latestCV{
            return 10
        }
         if collectionView == WillLikeShop {
            return 15
        }
      return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == latestCV{
            let cell = latestCV.dequeueReusableCell(withReuseIdentifier: "LatestSearchedCVC", for: indexPath) as! LatestSearchedCell
            cell.keyword.text = latestData[indexPath.row]
            cell.keyword.sizeToFit()
            
            let cellWidth = cell.keyword.frame.width + 8 + 25
            return CGSize(width: cellWidth, height: 25)
        }
        if collectionView == WillLikeShop {
            let width = 131
            let height = 164

            let size = CGSize(width: width, height: height)
            return size
        }
        return CGSize(width: 20, height:15)
    }
}

