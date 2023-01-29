//
//  FirstMainTableViewCell.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/26.
//

import UIKit

class FirstMainTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var foodnameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var limitLabel: UILabel!
    @IBOutlet weak var foodimageView: UIImageView!
    @IBOutlet weak var sharecancelButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        foodimageView.layer.cornerRadius = 10
        foodimageView.clipsToBounds = true
        
        sharecancelButton.layer.cornerRadius = 5
        sharecancelButton.layer.borderWidth = 1
        sharecancelButton.layer.borderColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}

extension FirstMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return StoreArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 169
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstMain_TableViewCell", for: indexPath) as! FirstMainTableViewCell
        cell.nicknameLabel.text = StoreArray[indexPath.section]
        cell.foodnameLabel.text = FoodArray[indexPath.section]
        cell.countLabel.text = "남은 수량: \(CountArray[indexPath.section])"
        cell.limitLabel.text = "\(TimeArray[indexPath.section]) 후 자동취소"
        
        cell.shareButton.tag = indexPath.section
        cell.shareButton.addTarget(self, action: #selector(shareButtonTapped(sender:)), for: .touchUpInside)
        return cell
    }
}
