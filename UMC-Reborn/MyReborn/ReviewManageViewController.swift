//
//  ReviewManageViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/01/18.
//

import UIKit

class ReviewManageViewController: UIViewController {
    
    // 이미지 사이즈 지정
    let imageView: UIImageView = {

        let aImageView = UIImageView()
        
        aImageView.contentMode = .scaleAspectFill
        aImageView.layer.cornerRadius = 16
        
        aImageView.translatesAutoresizingMaskIntoConstraints = false
                return aImageView
    }()
    
    
    var imageArray = [UIImage(named: "dummyImage1"), UIImage(named: "dummyImage1"),]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ReviewManageViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewImageCollectionViewCell", for: indexPath) as! ReviewImageCollectionViewCell
        
        cell.reviewImage.image = imageArray[indexPath.row]
        
        return cell
    }
    
}
