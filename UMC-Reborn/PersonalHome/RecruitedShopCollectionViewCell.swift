//
//  RecruitedShopCollectionViewCell.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/18.
//

import UIKit

class RecruitedShopCollectionViewCell:UICollectionViewCell {
    
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var shopLocation: UILabel!
    @IBOutlet weak var likeButton: UIButton!
        
    var likeBool: Bool = false {
        willSet(newValue) {
            if newValue {
                likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                likeButton.tintColor = UIColor.red
            }
            else {
                likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                likeButton.tintColor = UIColor.lightGray
            }
        }
    }
    @IBAction func likeButtonAction(_ sender: UIButton) {
        if likeBool {
            likeBool = false
//            removeDataAcion()
        }
        else {
            likeBool = true
//            pullDataAcion()
        }
    }
    
}
