//
//  NewShopViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/18.
//

import UIKit

class NewShopViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var newDatas: [NewShopResponse] = []
    var shopList: [String] = ["가나베이커리","하하베이커리","어쩌구","저쩌구","하이하이"]
    var shopLocationList: [String] = ["마포구","공릉동","홍제동","연남동","서초동"]
    var imageList: [String] = ["image 2","image 4","image 2","image 4","image 2"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.backgroundColor = .clear
        getShopList()
    }
    override func viewWillAppear(_ animated: Bool) {
        getShopList()
    }
    
    func getShopList() {
        NewShopService.shared.getMiracle {
                    result in
                    switch result {
                    case .success(let data):
                        guard let twittList = data as? [NewShopResponse] else {return}
                        self.newDatas = twittList
                        self.collectionView.reloadData()
                        print("성공")
                    case .requestErr:
                        print("requestErr")
                    case .pathErr:
                        print("pathErr")
                    case .serverErr:
                        print("serverErr")
                    case .networkFail:
                        print("networkFail")
                    }
                }
    }


}

extension NewShopViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewShopCell", for: indexPath) as! NewShopCollectionViewCell
        
        cell.backgroundColor = .clear
        cell.shopImage.layer.cornerRadius = 10
        cell.layer.borderWidth = 0
        
        let shopData = newDatas[indexPath.row]
        let url = URL(string: shopData.storeImage)
        cell.shopImage.load(url: url!)
        cell.shopName.text = shopData.storeName
        cell.shopLocation.text = shopData.category
        return cell
    }
}

extension NewShopViewController: UICollectionViewDelegateFlowLayout {
    
    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
        
    }

    // cell 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = 131
        let height = 164

        let size = CGSize(width: width, height: height)
        return size
    }
    
    
}

