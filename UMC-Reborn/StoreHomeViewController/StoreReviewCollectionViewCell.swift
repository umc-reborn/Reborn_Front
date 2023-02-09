//
//  StoreReviewCollectionViewCell.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/23.
//

import UIKit

class StoreReviewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
