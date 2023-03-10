//
//  JjimTableViewCell.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/30.
//

import UIKit

protocol JjimCellDelegate {
    func JjimBtn(index: Int)
}

class JjimTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var JjimButton: UIButton!
    
    var index: Int = 0
    var delegate: JjimCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        foodImage.layer.cornerRadius = 10
        foodImage.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        foodImage.image = nil
        JjimButton.setImage(UIImage(named: "ic_like"), for: .normal)
    }
    
    
    @IBAction func JjimTapped(_ sender: Any) {
        if (JjimButton.image(for: .selected) == UIImage(named: "ic_like")) {
            JjimButton.isSelected = false
            JjimButton.setImage(UIImage(named: "ic_like_gray"), for: .normal)
            JjimButton.setImage(UIImage(named: "ic_like_gray"), for: .selected)
            JjimButton.tintColor = .clear
            self.delegate?.JjimBtn(index: index)
        } else {
            JjimButton.isSelected = true
            JjimButton.setImage(UIImage(named: "ic_like"), for: .selected)
            JjimButton.tintColor = .clear
        }
    }
    
}

extension JjimViewController: UITableViewDelegate, UITableViewDataSource, JjimCellDelegate {
    func JjimBtn(index: Int) {
        let rebornData = jjimDatas[index]
        let parmeterData = JjimModel(storeIdx: rebornData.storeIdx, userIdx: jjimVC)
        APIHandlerJjimPost.instance.SendingPostJjim(parameters: parmeterData) { result in self.rebornJjimData = result
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.JjimResult()
            self.JjimCountResult()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jjimDatas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: JjimTableViewCell = tableView.dequeueReusableCell(withIdentifier: "JjimTableViewCell", for: indexPath) as! JjimTableViewCell
        
        let rebornData = jjimDatas[indexPath.row]
        let url = URL(string: rebornData.storeImage ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/6f9043df-c35f-4f57-9212-cccaa0091315.png")
        cell.foodImage.load(url: url!)
        cell.storeName.text = rebornData.storeName
        cell.rateLabel.text = String(rebornData.storeScore)
        if (rebornData.storeCategory == "CAFE") {
            cell.categoryLabel.text = "카페·디저트"
        } else if (rebornData.storeCategory == "FASHION") {
            cell.categoryLabel.text = "패션"
        } else if (rebornData.storeCategory == "SIDEDISH") {
            cell.categoryLabel.text = "반찬"
        } else if (rebornData.storeCategory == "LIFE") {
            cell.categoryLabel.text = "편의·생활"
        } else {
            cell.categoryLabel.text = "기타"
        }
        
        cell.index = indexPath.row
        cell.delegate = self
        
        return cell
//        } else if (JjimTextField.text == "인기순")  {
//            JjimTableView.beginUpdates()
//            print("인기순")
//            let rebornData2 = jjimPopularDatas[indexPath.row]
//            let url2 = URL(string: rebornData2.storeImage ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/6f9043df-c35f-4f57-9212-cccaa0091315.png")
//            cell.foodImage.load(url: url2!)
//            cell.storeName.text = rebornData2.storeName
//            cell.rateLabel.text = "\(String(rebornData2.storeScore))"
//            if (rebornData2.storeCategory == "CAFE") {
//                cell.categoryLabel.text = "카페·디저트"
//            } else if (rebornData2.storeCategory == "FASHION") {
//                cell.categoryLabel.text = "패션"
//            } else if (rebornData2.storeCategory == "SIDEDISH") {
//                cell.categoryLabel.text = "반찬"
//            } else if (rebornData2.storeCategory == "LIFE") {
//                cell.categoryLabel.text = "편의·생활"
//            } else {
//                cell.categoryLabel.text = "기타"
//            }
//            JjimTableView.endUpdates()
//            return cell
//        } else if (JjimTextField.text == "이름순")  {
//            print("이름순")
//            let rebornData3 = jjimNameDatas[indexPath.row]
//            let url3 = URL(string: rebornData3.storeImage ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/6f9043df-c35f-4f57-9212-cccaa0091315.png")
//            cell.foodImage.load(url: url3!)
//            cell.storeName.text = rebornData3.storeName
//            cell.rateLabel.text = "\(String(rebornData3.storeScore))"
//            if (rebornData3.storeCategory == "CAFE") {
//                cell.categoryLabel.text = "카페·디저트"
//            } else if (rebornData3.storeCategory == "FASHION") {
//                cell.categoryLabel.text = "패션"
//            } else if (rebornData3.storeCategory == "SIDEDISH") {
//                cell.categoryLabel.text = "반찬"
//            } else if (rebornData3.storeCategory == "LIFE") {
//                cell.categoryLabel.text = "편의·생활"
//            } else {
//                cell.categoryLabel.text = "기타"
//            }
//            return cell
//        } else {
//            print("별점순")
//            let rebornData4 = jjimScoreDatas[indexPath.row]
//            let url4 = URL(string: rebornData4.storeImage ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/6f9043df-c35f-4f57-9212-cccaa0091315.png")
//            cell.foodImage.load(url: url4!)
//            cell.storeName.text = rebornData4.storeName
//            cell.rateLabel.text = "\(String(rebornData4.storeScore))"
//            if (rebornData4.storeCategory == "CAFE") {
//                cell.categoryLabel.text = "카페·디저트"
//            } else if (rebornData4.storeCategory == "FASHION") {
//                cell.categoryLabel.text = "패션"
//            } else if (rebornData4.storeCategory == "SIDEDISH") {
//                cell.categoryLabel.text = "반찬"
//            } else if (rebornData4.storeCategory == "LIFE") {
//                cell.categoryLabel.text = "편의·생활"
//            } else {
//                cell.categoryLabel.text = "기타"
//            }
//            return cell
//        }
    }
}
