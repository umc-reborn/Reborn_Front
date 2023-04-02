//
//  SearchResultTableViewCell.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/26.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shopnameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var shopImg: UIImageView!
    @IBOutlet weak var ratingnum: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        // Configure the view for the selected state
//    }
    
}
