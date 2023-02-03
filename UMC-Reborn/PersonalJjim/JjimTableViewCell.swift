//
//  JjimTableViewCell.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/30.
//

import UIKit

class JjimTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var JjimButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        foodImage.layer.cornerRadius = 10
        foodImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func JjimTapped(_ sender: Any) {
        if (JjimButton.image(for: .selected) == UIImage(named: "ic_like")) {
            JjimButton.isSelected = false
            JjimButton.setImage(UIImage(named: "ic_like_gray"), for: .normal)
            JjimButton.setImage(UIImage(named: "ic_like_gray"), for: .selected)
            JjimButton.tintColor = .clear
        } else {
            JjimButton.isSelected = true
            JjimButton.setImage(UIImage(named: "ic_like"), for: .selected)
            JjimButton.tintColor = .clear
        }
    }
    
}

extension JjimViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FoodArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JjimTableViewCell", for: indexPath) as! JjimTableViewCell
        
        return cell
    }
}
