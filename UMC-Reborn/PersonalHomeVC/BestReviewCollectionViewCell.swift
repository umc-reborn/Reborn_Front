//
//  BestReviewCollectionViewCell.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/20.
//

import UIKit

class BestReviewCollectionViewCell:UICollectionViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var shopLocation: UILabel!
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var shopScore: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet var gradationView: UIView!
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
// MARK: - IBAction
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

extension UIView{
    func setGradient(color1:UIColor,color2:UIColor){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor,color2.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}

