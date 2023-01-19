//
//  NewShopViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/18.
//

import UIKit

import UIKit

class NewShopViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var shopList: [String] = ["가나베이커리","하하베이커리","어쩌구","저쩌구","하이하이"]
    var shopLocationList: [String] = ["마포구","공릉동","홍제동","연남동","서초동"]
    var imageList: [String] = ["bread_image","bread_image","bread_image","bread_image","bread_image"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension NewShopViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewShopCell", for: indexPath) as! NewShopCollectionViewCell
        
        cell.backgroundColor = .white
        cell.shopImage.layer.cornerRadius = 10
        cell.layer.borderWidth = 0
//        cell.layer.borderColor = UIColor.black.cgColor
//        cell.layer.shadowColor = UIColor.black.cgColor
//        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
//        cell.layer.shadowOpacity = 0.15
//        cell.layer.shadowRadius = 10
        cell.contentView.layer.masksToBounds = true
        cell.layer.masksToBounds = false
        
        cell.shopName.text = shopList[indexPath.row]
        cell.shopLocation.text = shopLocationList[indexPath.row]
        
//        cell.shopImage.reloadData()
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

