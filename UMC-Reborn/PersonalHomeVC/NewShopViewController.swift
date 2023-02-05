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
        cell.layer.borderWidth = 0
        
        let shopData = newDatas[indexPath.row]
        let url = URL(string: shopData.storeImage)
        cell.shopImage.load(url: url!)
        cell.shopName.text = shopData.storeName
        cell.shopLocation.text = shopData.category
        cell.shopScore.text = String(shopData.storeScore)
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

