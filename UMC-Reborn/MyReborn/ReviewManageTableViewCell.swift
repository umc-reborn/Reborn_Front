//
//  ReviewManageTableViewCell.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/03/15.
//

import UIKit

class ReviewManageTableViewCell: UITableViewCell {

    var reviewImageDatas : [ReviewManageModelResponse] = []
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var storeNameLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var reviewCommentLabel: UILabel!
    @IBOutlet var reviewImg: UIImageView!
    @IBOutlet var productName: UILabel!
    
    @IBOutlet var reviewStar_a: UIImageView!
    @IBOutlet var reviewStar_b: UIImageView!
    @IBOutlet var reviewStar_c: UIImageView!
    @IBOutlet var reviewStar_d: UIImageView!
    @IBOutlet var reviewStar_e: UIImageView!
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reviewCommentLabel.sizeToFit()
        
        reviewImg.layer.cornerRadius = 10
        reviewImg.clipsToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension ReviewManageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return reviewDatas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 443
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myReviewTableViewCell", for: indexPath) as! ReviewManageTableViewCell
        
        let rebornData = reviewDatas[indexPath.section]
        
        let url = URL(string: rebornData.reviewImg ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/20959843-0000-46c8-aaff-38342f93dd47.jpg")
        
        let createTime = rebornData.reviewCreatedAt
        let yearTime = createTime.prefix(4)
        let monthTime1 = createTime[String.Index(encodedOffset: 5)]
        let monthTime2 = createTime[String.Index(encodedOffset: 6)]
        let dayTime1 = createTime[String.Index(encodedOffset: 8)]
        let dayTime2 = createTime[String.Index(encodedOffset: 9)]
        cell.dateLabel.text = "\(yearTime)/\(monthTime1)\(monthTime2)/\(dayTime1)\(dayTime2)"
        cell.storeNameLabel.text = rebornData.storeName
        cell.categoryLabel.text = rebornData.storeCategory
        cell.productName.text = rebornData.productName
        cell.reviewImg.load(url: url!)
        cell.reviewCommentLabel.text = rebornData.reviewComment
        if (rebornData.reviewScore == 5) {
            cell.reviewStar_a.image = UIImage(named: "review_star")
            cell.reviewStar_b.image = UIImage(named: "review_star")
            cell.reviewStar_c.image = UIImage(named: "review_star")
            cell.reviewStar_d.image = UIImage(named: "review_star")
            cell.reviewStar_e.image = UIImage(named: "review_star")
        } else if (rebornData.reviewScore == 4) {
            cell.reviewStar_a.image = UIImage(named: "review_star")
            cell.reviewStar_b.image = UIImage(named: "review_star")
            cell.reviewStar_c.image = UIImage(named: "review_star")
            cell.reviewStar_d.image = UIImage(named: "review_star")
            cell.reviewStar_e.image = UIImage(named: "review_star_gray")
        } else if (rebornData.reviewScore == 3) {
            cell.reviewStar_a.image = UIImage(named: "review_star")
            cell.reviewStar_b.image = UIImage(named: "review_star")
            cell.reviewStar_c.image = UIImage(named: "review_star")
            cell.reviewStar_d.image = UIImage(named: "review_star_gray")
            cell.reviewStar_e.image = UIImage(named: "review_star_gray")
        } else if (rebornData.reviewScore == 2) {
            cell.reviewStar_a.image = UIImage(named: "review_star")
            cell.reviewStar_b.image = UIImage(named: "review_star")
            cell.reviewStar_c.image = UIImage(named: "review_star_gray")
            cell.reviewStar_d.image = UIImage(named: "review_star_gray")
            cell.reviewStar_e.image = UIImage(named: "review_star_gray")
        } else {
            cell.reviewStar_a.image = UIImage(named: "review_star")
            cell.reviewStar_b.image = UIImage(named: "review_star_gray")
            cell.reviewStar_c.image = UIImage(named: "review_star_gray")
            cell.reviewStar_d.image = UIImage(named: "review_star_gray")
            cell.reviewStar_e.image = UIImage(named: "review_star_gray")
        }
        
        return cell
    }
}
