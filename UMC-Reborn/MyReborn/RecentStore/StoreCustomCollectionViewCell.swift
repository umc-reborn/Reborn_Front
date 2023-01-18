//
//  StoreCustomCollectionViewCell.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/01/18.
//

import UIKit

class StoreCustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    func setLabel(label:String) {
        textLabel.text = label
    }
    
}
