//
//  EnrollTableViewCell.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/14.
//

import UIKit

protocol SampleProtocol5:AnyObject {
    func activeSwitchTapped(index: Int)
}

class EnrollTableViewCell: UITableViewCell {
    
    @IBOutlet weak var RebornSwitch: UISwitch!
    @IBOutlet weak var StoreImageView: UIImageView!
    @IBOutlet weak var TimeImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var CautionLabel: UILabel!
    
    var index: Int = 0
    var cellDelegate: SampleProtocol5?

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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        StoreImageView.image = nil
    }

    @IBAction func timeSwitch(_ sender: Any) {
        if RebornSwitch.isOn {
            TimeImageView.alpha = 1
            timeLabel.alpha = 1
        } else {
            TimeImageView.alpha = 0
            timeLabel.alpha = 0
        }
        self.cellDelegate?.activeSwitchTapped(index: index)
    }
}

extension RebornEnrollViewController: UITableViewDelegate, UITableViewDataSource, SampleProtocol5 {
    
    func activeSwitchTapped(index: Int) {
        let rebornData = rebornDatas[index]
        let parameterDatas = RebornActiveModel(rebornIdx: rebornData.rebornIdx)
        APIHandlerActivePost.instance.SendingPostReborn(rebornId: rebornData.rebornIdx, parameters: parameterDatas) { result in self.rebornActiveData = result }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rebornData = rebornDatas[indexPath.section]
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "EditRebornViewController") as? EditRebornViewController else { return }
        nextVC.modalPresentationStyle = .overFullScreen
        nextVC.rebornId = rebornData.rebornIdx
        self.present(nextVC, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return rebornDatas.count
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
        let cell: EnrollTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Enroll_TableViewCell", for: indexPath) as! EnrollTableViewCell
        
        let rebornData = rebornDatas[indexPath.section]
        let limitTime = rebornData.productLimitTime
        let minuteLimit1 = limitTime[String.Index(encodedOffset: 3)]
        let minuteLimit2 = limitTime[String.Index(encodedOffset: 4)]
        let url = URL(string: rebornData.productImg ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/6f9043df-c35f-4f57-9212-cccaa0091315.png")
        cell.StoreImageView.load(url: url!)
        cell.foodName.text = rebornData.productName
        cell.Description.text = rebornData.productComment
        cell.CautionLabel.text = rebornData.productGuide
        cell.countLabel.text = "남은 수량: \(String(rebornData.productCnt))"
        cell.timeLabel.text = "\(minuteLimit1)\(minuteLimit2)분 내 수령"
        if (rebornData.status == "ACTIVE") {
            cell.RebornSwitch.isOn = true
            cell.timeLabel.alpha = 1
            cell.TimeImageView.alpha = 1
        } else {
            cell.RebornSwitch.isOn = false
            cell.timeLabel.alpha = 0
            cell.TimeImageView.alpha = 0
        }
        cell.index = indexPath.section
        cell.cellDelegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: nil) { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("삭제 클릭 됨")
            let rebornData = self.rebornDatas[indexPath.section]
            let parmeterDatas = RebornDeleteModel(rebornIdx: rebornData.rebornIdx)
            APIHandlerDeletePost.instance.SendingPostReborn(rebornId: rebornData.rebornIdx, parameters: parmeterDatas) { result in self.rebornData = result }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                  
                  self.rebornResult()
            }
            success(true)
        }
        delete.backgroundColor = .white
        delete.image = UIImage(named: "ic_delete")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    
}
