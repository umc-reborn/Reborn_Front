//
//  NewShopViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/18.
//

import UIKit

class NewShopViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
//    var shopList: [String] = ["가나베이커리","하하베이커리","어쩌구","저쩌구","하이하이"]
//    var shopLocationList: [String] = ["마포구","공릉동","홍제동","연남동","서초동"]
//    var imageList: [String] = ["image 1","image 3","image 1","image 3","image 1"]
    
    var newDatas: [NewShopResponse] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.backgroundColor = .clear
        
        NewShopService.shared.getNewShop{ result in
                    switch result {
                    case .success(let response):
//                        dump(response)
                        guard let response = response as? NewShopModel else {
                            break
                        }
                        self.newDatas = response.result
                    
                    default:
                        break
                    }
                    self.collectionView.reloadData()
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
        cell.shopImage.clipsToBounds = true
        cell.layer.borderWidth = 0
        
        let newData = newDatas[indexPath.row]
        cell.shopName.text = newData.storeName
        cell.shopLocation.text = newData.category
        let url = URL(string: newData.userImage)
        cell.shopImage.load(url: url!)
//        cell.shopImage.image = UIImage(named: imageList[indexPath.row]) ?? UIImage()
//        cell.shopImage.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let svc1 = self.storyboard?.instantiateViewController(identifier: "ModalPersonalViewController") as? ModalPersonalViewController else { return }
        svc1.storeIdm1 = newDatas[indexPath.row].storeIdx
        UserDefaults.standard.set(newDatas[indexPath.row].storeIdx, forKey: "storeid")
        self.present(svc1, animated: true)
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

