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
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var CautionLabel: UILabel!

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
        if RebornSwitch.isOn {
            TimeImageView.alpha = 1
            timeLabel.text = "10분 내 수령"
        } else {
            TimeImageView.alpha = 0
            timeLabel.text = ""
        }
    }
}

extension RebornEnrollViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return FoodArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Enroll_TableViewCell", for: indexPath) as! EnrollTableViewCell
        
        cell.foodName.text = FoodArray[indexPath.section]
        cell.timeLabel.text = "\(TimeArray[indexPath.section])분 내 수령"
        cell.countLabel.text = "남은 수량: \(CountArray[indexPath.section])"
        cell.Description.text = DescriptionArray[indexPath.section]
        cell.CautionLabel.text = CautionArray[indexPath.section]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: nil) { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
                    success(true)
                }
                delete.backgroundColor = .white
        delete.image = UIImage(named: "ic_delete")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
