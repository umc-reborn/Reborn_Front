//
//  BestReviewViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/18.
//

import UIKit

class BestReviewViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    var reivewDatas: [BestReivewResponse] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        // Do any additional setup after loading the view.
        BestReviewService.shared.getBestReview{ result in
                    switch result {
                    case .success(let response):
//                        dump(response)
                        guard let response = response as? BestReviewModel else {
                            break
                        }
                        self.reivewDatas = response.result
                    
                    default:
                        break
                    }
                    self.collectionView.reloadData()
                }
    }


}

extension BestReviewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reivewDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCell", for: indexPath) as! BestReviewCollectionViewCell
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 0
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowOpacity = 0.15
        cell.layer.shadowRadius = 10
        cell.contentView.layer.masksToBounds = true
        cell.layer.masksToBounds = false
        
//        cell.userName.text = userList[indexPath.row]
//        cell.shopName.text = shopList[indexPath.row]
//        cell.shopLocation.text = shopLocationList[indexPath.row]
        
        let reviewData = reivewDatas[indexPath.row]
        let url = URL(string: reviewData.reviewImage1)
        cell.shopImage.load(url: url!)
        cell.userName.text = reviewData.userNickname
        cell.shopName.text = reviewData.storeName
        cell.shopLocation.text = reviewData.storeCategory
        cell.comment.text = reviewData.reviewComment
        cell.date.text = String(reviewData.reviewCreatedAt.prefix(10))
        cell.shopScore.text = String(reviewData.reviewScore)
        
//        cell.shopImage.reloadData()
        return cell
    }
}
extension BestReviewViewController: UICollectionViewDelegateFlowLayout {
    
    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 29
        
    }

    // cell 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = 215
        let height = 305

        let size = CGSize(width: width, height: height)
        return size
    }
    
    
}
