//
//  ModalSecondTableViewCell.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/15.
//

import UIKit

class ModalSecondTableViewCell: UITableViewCell {
    
    let flowlayout = UICollectionViewFlowLayout()
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var nickName: UILabel!
    @IBOutlet var foodName: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var reviewstar_a: UIImageView!
    @IBOutlet var reviewstar_b: UIImageView!
    @IBOutlet var reviewstar_c: UIImageView!
    @IBOutlet var reviewstar_d: UIImageView!
    @IBOutlet var reviewstar_e: UIImageView!
    @IBOutlet var reviewImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        flowlayout.minimumLineSpacing = 0
        commentLabel.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reviewImage?.image = nil
    }
}
