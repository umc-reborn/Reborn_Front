//
//  recruitedRebronViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/18.
//

import UIKit

class RecruitedRebronViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
//    var shopList: [String] = ["가나베이커리","하하베이커리","어쩌구","저쩌구","하이하이"]
//    var shopLocationList: [String] = ["마포구","공릉동","홍제동","연남동","서초동"]
//    var imageList: [String] = ["image 1","image 3","image 1","image 3","image 1"]
    var likeshopDatas: [LikeShopsponse] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        // Do any additional setup after loading the view.
        WillLikeShopService.shared.getLikeShop{ result in
                    switch result {
                    case .success(let response):
                        
//                        dump(response)
                        guard let response = response as? WillLikeShopModel else {
                            break
                        }
                        self.likeshopDatas = response.result
                    
                    default:
                        
                        break
                    }
                    self.collectionView.reloadData()
                }
    }

}

extension RecruitedRebronViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likeshopDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecruitedShopCell", for: indexPath) as! RecruitedShopCollectionViewCell
        
        cell.shopImage.layer.cornerRadius = 10
        cell.layer.borderWidth = 0
        
        let likeshopData = likeshopDatas[indexPath.row]
        cell.shopName.text = likeshopData.storeName
        cell.shopLocation.text = likeshopData.category
//        cell.shopImage.image = UIImage(named: imageList[indexPath.row]) ?? UIImage()
        let url = URL(string: likeshopData.userImage!)
        cell.shopImage.load(url: url!)
//        cell.shopImage.reloadData()
        return cell
    }
}
extension RecruitedRebronViewController: UICollectionViewDelegateFlowLayout {
    
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
