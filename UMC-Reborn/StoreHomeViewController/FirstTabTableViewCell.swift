//
//  FirstTabTableViewCell.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/25.
//

import UIKit

class FirstTabTableViewCell: UITableViewCell {

    
    @IBOutlet weak var FTimageView: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var LimitLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var timeImage: UIImageView!
    @IBOutlet weak var limitTimeLabel: UILabel!
    @IBOutlet weak var rebornButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        FTimageView.layer.cornerRadius = 10
        FTimageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
