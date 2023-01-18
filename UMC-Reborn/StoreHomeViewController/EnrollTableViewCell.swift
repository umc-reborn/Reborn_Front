//
//  EnrollTableViewCell.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/14.
//

import UIKit

class EnrollTableViewCell: UITableViewCell {

    @IBOutlet weak var RebornSwitch: UISwitch!
    @IBOutlet weak var StoreImageView: UIImageView!
    @IBOutlet weak var TimeImageView: UIImageView!
    @IBOutlet weak var TimeSwitch: UISwitch!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        RebornSwitch.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        StoreImageView.layer.cornerRadius = 10
        StoreImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func timeSwitch(_ sender: Any) {
        if TimeSwitch.isOn {
            TimeImageView.alpha = 1
            timeLabel.text = "10분 내 수령"
        } else {
            TimeImageView.alpha = 0
            timeLabel.text = ""
        }
    }
}
