//
//  SecondTabCollectionViewCell.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/26.
//

import UIKit

class SecondTabCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
    }
}
