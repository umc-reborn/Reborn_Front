//
//  SecondMainTableViewCell.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/26.
//

import UIKit

class SecondMainTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var foodnameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var limitLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var sharecancelButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        foodImage.layer.cornerRadius = 10
        foodImage.clipsToBounds = true
        
        sharecancelButton.layer.cornerRadius = 5
        sharecancelButton.layer.borderWidth = 1
        sharecancelButton.layer.borderColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension SecondMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return StoreArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StoreArray[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 169
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondMain_TableViewCell", for: indexPath) as! SecondMainTableViewCell
        cell.nicknameLabel.text = StoreArray[indexPath.section][indexPath.row]
        cell.foodnameLabel.text = FoodArray[indexPath.section][indexPath.row]
        cell.countLabel.text = "남은 수량: \(CountArray[indexPath.section][indexPath.row])"
        cell.limitLabel.text = "\(TimeArray[indexPath.section][indexPath.row]) 후 자동취소"
        
        return cell
    }
}
