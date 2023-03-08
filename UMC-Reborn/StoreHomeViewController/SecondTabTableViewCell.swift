//
//  SecondTabTableViewCell.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/25.
//

import UIKit

class SecondTabTableViewCell: UITableViewCell {

    let reviewImage = ["Review_image", "Review_image"]
    let flowlayout = UICollectionViewFlowLayout()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var reviewStar_a: UIImageView!
    @IBOutlet weak var reviewStar_b: UIImageView!
    @IBOutlet weak var reviewStar_c: UIImageView!
    @IBOutlet weak var reviewStar_d: UIImageView!
    @IBOutlet weak var reviewStar_e: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet var reviewImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        flowlayout.minimumLineSpacing = 0
        commentLabel.sizeToFit()
        
        personImage.layer.cornerRadius = self.personImage.frame.size.height / 2
        personImage.layer.masksToBounds = true
        personImage.clipsToBounds = true
        reviewImg.layer.cornerRadius = 10
        reviewImg.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
