//
//  SecondMainTableViewCell.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/26.
//

import UIKit

protocol ComponentProductCellDelegate2 {
    func completeButtonTapped2(index: Int)
    func cancelButtonTapped2(index: Int)
}

class SecondMainTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var foodnameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var limitLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var sharecancelButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    var index: Int = 0
    var delegate: ComponentProductCellDelegate2?
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        self.delegate?.completeButtonTapped2(index: index)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.delegate?.cancelButtonTapped2(index: index)
    }
}

extension SecondMainViewController: UITableViewDelegate, UITableViewDataSource, ComponentProductCellDelegate2 {
    func cancelButtonTapped2(index: Int) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CancelAlertViewController") as? CancelAlertViewController else { return }
        let rebornData = rebornGoingDatas[index]
        nextVC.rebornTaskId = rebornData.rebornTaskIdx
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: false, completion: nil)
    }
    
    func completeButtonTapped2(index: Int) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CodeViewController") as? CodeViewController else { return }
        let rebornData = rebornGoingDatas[index]
        nextVC.rebornTaskId = rebornData.rebornTaskIdx
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: false, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
        return rebornGoingDatas.count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondMain_TableViewCell", for: indexPath) as! SecondMainTableViewCell
        
        let rebornData = rebornGoingDatas[indexPath.section]
        let timeLimit = rebornData.productLimitTime
        let hourLimit = timeLimit.prefix(2)
        let minuteLimit1 = timeLimit[String.Index(encodedOffset: 3)]
        let minuteLimit2 = timeLimit[String.Index(encodedOffset: 4)]
        let createTime = rebornData.createdAt
        let yearTime = createTime.prefix(4)
        let monthTime1 = createTime[String.Index(encodedOffset: 5)]
        let monthTime2 = createTime[String.Index(encodedOffset: 6)]
        let dayTime1 = createTime[String.Index(encodedOffset: 8)]
        let dayTime2 = createTime[String.Index(encodedOffset: 9)]
        let url = URL(string: rebornData.productImg ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/6f9043df-c35f-4f57-9212-cccaa0091315.png")
        cell.foodImage.load(url: url!)
        cell.nicknameLabel.text = rebornData.userNickname
        cell.foodnameLabel.text = rebornData.productName
        cell.countLabel.text = "남은 수량: \(String(rebornData.productCnt))"
        cell.limitLabel.text = "\(hourLimit):\(minuteLimit1)\(minuteLimit2) 후 자동취소"
        cell.dateLabel.text = "\(yearTime)/\(monthTime1)\(monthTime2)/\(dayTime1)\(dayTime2)"
        
        cell.index = indexPath.section
        cell.delegate = self
        
        return cell
    }
}
