//
//  StoreReviewCollectionViewCell.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/23.
//

import UIKit

class StoreReviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet var reviewImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reviewImageView.layer.cornerRadius = 10
        reviewImageView.clipsToBounds = true
    }
}
