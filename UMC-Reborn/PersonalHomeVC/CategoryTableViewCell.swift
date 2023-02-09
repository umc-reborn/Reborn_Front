//
//  CategoryListCell.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/20.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shopnameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var shopImg: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var shopScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
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

