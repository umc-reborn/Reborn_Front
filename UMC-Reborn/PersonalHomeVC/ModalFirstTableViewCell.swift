//
//  ModalFirstTableViewCell.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/15.
//

import UIKit

class ModalFirstTableViewCell: UITableViewCell {
    
    @IBOutlet var mfImageView: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var timeImage: UIImageView!
    @IBOutlet var foodName: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var cautionLabel: UILabel!
    @IBOutlet var rebornButton: UIButton!
    
    var index: Int = 0
    var delegate: ComponentProductCellDelegate3?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mfImageView?.image = nil
    }
    
    @IBAction func rebornButtonTapped(_ sender: Any) {
        self.delegate?.rebornButtonTapped(index: index)
    }
}
