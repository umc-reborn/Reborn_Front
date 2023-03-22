//
//  FirstMainTableViewCell.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/26.
//

import UIKit

protocol ComponentProductCellDelegate {
    func completeButtonTapped(index: Int)
    func cancelButtonTapped(index: Int)
}

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
    
    var index: Int = 0
    var delegate: ComponentProductCellDelegate?
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        self.delegate?.completeButtonTapped(index: index)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.delegate?.cancelButtonTapped(index: index)
    }
}

extension FirstMainViewController: UITableViewDelegate, UITableViewDataSource, ComponentProductCellDelegate {
    
    func cancelButtonTapped(index: Int) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CancelAlertViewController") as? CancelAlertViewController else { return }
        let rebornData = rebornWholeDatas[index]
        nextVC.rebornTaskId = rebornData.rebornTaskIdx
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: false, completion: nil)
    }
    
    func completeButtonTapped(index: Int) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CodeViewController") as? CodeViewController else { return }
        let rebornData = rebornWholeDatas[index]
        nextVC.rebornTaskId = rebornData.rebornTaskIdx
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: false, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return rebornWholeDatas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rebornData = rebornWholeDatas[indexPath.section]
        if (rebornData.status == "ACTIVE") {
            return 169
        } else {
            return 131
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FirstMainTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FirstMain_TableViewCell", for: indexPath) as! FirstMainTableViewCell
        
        var timeSecond = 10 {
            willSet(newValue) {
                var days = String(newValue / 86400)
                var hours = String(newValue / 3600)
                var minutes = String(newValue / 60)
                var seconds = String(newValue % 60)
                if days.count == 1 { hours = "00" }
                if hours.count == 1 { hours = "0"+hours }
                if minutes.count == 1 { minutes = "0"+minutes }
                if seconds.count == 1 { seconds = "0"+seconds }
                cell.limitLabel.text = "\(hours):\(minutes) 이후 자동취소"
            }
        }
        
        let rebornData = rebornWholeDatas[indexPath.section]
        let timeLimit = rebornData.productLimitTime
        let hourLimit = timeLimit.prefix(2)
        let minuteLimit1 = timeLimit[String.Index(encodedOffset: 3)]
        let minuteLimit2 = timeLimit[String.Index(encodedOffset: 4)]
        
        let hourCLimit1 = timeLimit[String.Index(encodedOffset: 0)].wholeNumberValue ?? 0
        let hourCLimit2 = timeLimit[String.Index(encodedOffset: 1)].wholeNumberValue ?? 0
        let minuteCLimit1 = timeLimit[String.Index(encodedOffset: 3)].wholeNumberValue ?? 0
        let minuteCLimit2 = timeLimit[String.Index(encodedOffset: 4)].wholeNumberValue ?? 0
        let hourTimer2 = 3600 * (hourCLimit1 * 10 + hourCLimit2)
        let minuteTimer2 = 60 * (minuteCLimit1 * 10 + minuteCLimit2)
        
        let createTime = rebornData.createdAt
        let yearTime = createTime.prefix(4)
        let monthTime1 = createTime[String.Index(encodedOffset: 5)]
        let monthTime2 = createTime[String.Index(encodedOffset: 6)]
        let dayTime1 = createTime[String.Index(encodedOffset: 8)]
        let dayTime2 = createTime[String.Index(encodedOffset: 9)]
        
        let hourCTime1 = createTime[String.Index(encodedOffset: 12)].wholeNumberValue ?? 0
        let minuteCTime1 = createTime[String.Index(encodedOffset: 14)].wholeNumberValue ?? 0
        let minuteCTime2 = createTime[String.Index(encodedOffset: 15)].wholeNumberValue ?? 0
        let secondCTime1 = createTime[String.Index(encodedOffset: 17)].wholeNumberValue ?? 0
        let secondCTime2 = createTime[String.Index(encodedOffset: 18)].wholeNumberValue ?? 0
        let hourTimer = 3600 * hourCTime1
        let minuteTimer = 60 * (minuteCTime1 * 10 + minuteCTime2)
        let secondTimer = secondCTime1 * 10 + secondCTime2
        
        let wholeSeconds = hourTimer2 + minuteTimer2 + hourTimer + minuteTimer + secondTimer
        
        let url = URL(string: rebornData.productImg ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/6f9043df-c35f-4f57-9212-cccaa0091315.png")
        cell.foodimageView.load(url: url!)
        cell.nicknameLabel.text = rebornData.userNickname
        cell.foodnameLabel.text = rebornData.productName
        cell.countLabel.text = "남은 수량: \(String(rebornData.productCnt))"
        if (rebornData.status == "ACTIVE") {
            timeSecond = wholeSeconds
//            cell.limitLabel.text = "\(hourLimit):\(minuteLimit1)\(minuteLimit2) 후 자동취소"
            cell.statusLabel.text = "진행중"
            cell.shareButton.isEnabled = true
            cell.sharecancelButton.isEnabled = true
        } else {
            cell.limitLabel.text = ""
            cell.statusLabel.text = "완료"
            cell.shareButton.isEnabled = false
            cell.sharecancelButton.isEnabled = false
        }
        cell.dateLabel.text = "\(yearTime)/\(monthTime1)\(monthTime2)/\(dayTime1)\(dayTime2)"
        
        cell.index = indexPath.section
        cell.delegate = self
        
        return cell
    }
}
