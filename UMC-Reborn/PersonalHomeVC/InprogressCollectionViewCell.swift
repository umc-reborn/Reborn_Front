//
//  InprogressCollectionViewCell.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/02/10.
//

import UIKit

class InprogressCollectionViewCell:UICollectionViewCell {
    // MARK: - IBOutlet
    
    @IBOutlet var exchangeBtn: UIButton!
    @IBOutlet var ongoingtime: UILabel!
    @IBOutlet var ongoingProduct: UILabel!
    @IBOutlet var ongoingCategory: UILabel!
    @IBOutlet var ongoingName: UILabel!
    @IBOutlet var ongoingImg: UIImageView!
    @IBOutlet var ongoingView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        exchangeBtn.layer.cornerRadius = 5
//        exchangeBtn.layer.borderWidth = 1
        exchangeBtn.layer.borderColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1).cgColor
    }
    
}
