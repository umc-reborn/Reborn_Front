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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func cautionButton(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "RebornCautionViewController") as? RebornCautionViewController else { return }
        nextVC.modalPresentationStyle = .overCurrentContext
        self.present(nextVC, animated: true, completion: nil)
    }
    

}
