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
    let username = UserDefaults.standard.string(forKey: "userNickName")
    
    private var recentSearchKeywordList: [String] = []
    var willLikeDatas: [LikeShopsponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNaviBar()
        configure()
        searchBar.delegate = self
        
        
        self.view.backgroundColor = UIColor(named: "Background")
        self.latestCV.backgroundColor = UIColor(named: "Background")
        titleLabel.text = "\(username!)"
        
        WillLikeShopService.shared.getLikeShop{ result in
                    switch result {
                    case .success(let response):
                        
//                        dump(response)
                        guard let response = response as? WillLikeShopModel else {
                            break
                        }
                        self.willLikeDatas = response.result
                    
                    default:
                        
                        break
                    }
                    self.WillLikeShop.reloadData()
                }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         SearchKeywordList()
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
         button.addTarget(self, action: #selector(didTapClearButton), for: .touchUpInside)

         return button
     }()
    
    @objc func didTapClearButton() {
        searchBar.text?.removeAll()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == self.searchBar {
            userPressedToEnter(keyword: searchBar.text ?? "")
        }

        return true

    }
    
    
    private func SearchKeywordList() {
         recentSearchKeywordList = UserDefaults.standard.stringArray(forKey: "recentSearchKeywordList") ?? [String]()
        latestCV.reloadData()
     }
    
    private func saveSearchInput(_ inputKeyword: String) {
            if inputKeyword.count > 0 {
                recentSearchKeywordList.append(inputKeyword)
                UserDefaults.standard.set(recentSearchKeywordList, forKey: "recentSearchKeywordList")
            }
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
        saveSearchInput(text)
        Resultvc.SearchInput = text
        navigationController?.pushViewController(Resultvc, animated: true)

    }
    
    @objc func deletePreview(sender: UIButton){
        recentSearchKeywordList.remove(at: sender.tag)
        UserDefaults.standard.removeObject(forKey: "recentSearchKeywordList")
        latestCV.reloadData()

    }

}

extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == latestCV {
            return recentSearchKeywordList.count
            
        }
        if collectionView == WillLikeShop {
            return willLikeDatas.count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestSearchedCVC", for: indexPath) as! LatestSearchedCell
//
        if collectionView == latestCV {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestSearchedCVC", for: indexPath) as! LatestSearchedCell
            
            cell.keyword.text = recentSearchKeywordList[indexPath.row]
            
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 0
            cell.keyword.sizeToFit()
            //        cell.backgroundColor =
            cell.deleteBtn.tag = indexPath.row
                    cell.deleteBtn.addTarget(self, action: #selector(deletePreview(sender:)), for: .touchUpInside)
            
            
            return cell
        }
        if collectionView == WillLikeShop {
            
            let shopcell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeShopCell", for: indexPath) as! WillLikeShopCell
            
            shopcell.backgroundColor = .clear
            shopcell.shopImage.layer.cornerRadius = 10
            shopcell.layer.borderWidth = 0
            
            let willLikeData = willLikeDatas[indexPath.row]
            shopcell.shopName.text = willLikeData.storeName
            shopcell.shopLocation.text = willLikeData.category
            shopcell.shopScore.text = String(willLikeData.storeScore)
            let url = URL(string: willLikeData.userImage!)
            shopcell.shopImage.load(url: url!)
            return shopcell
        }
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == WillLikeShop {
            let storyboard: UIStoryboard = UIStoryboard(name: "Personal_Home", bundle: nil)
            guard let svc1 = storyboard.instantiateViewController(identifier: "ModalPersonalViewController") as? ModalPersonalViewController else { return }
            svc1.storeIdm1 = willLikeDatas[indexPath.row].storeIdx
            UserDefaults.standard.set(willLikeDatas[indexPath.row].storeIdx, forKey: "storeid")
            self.present(svc1, animated: true)
        }
    }
    
    
}

extension SearchViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == latestCV{
            return 8
        }
         if collectionView == WillLikeShop {
            return 15
        }
      return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == latestCV{
            let cell = latestCV.dequeueReusableCell(withReuseIdentifier: "LatestSearchedCVC", for: indexPath) as! LatestSearchedCell
            cell.keyword.text = recentSearchKeywordList[indexPath.row]
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
