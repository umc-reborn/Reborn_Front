////
////  ReviewManageTableViewCell.swift
////  UMC-Reborn
////
////  Created by yeonsu on 2023/03/15.
////

import UIKit

class ReviewManageTableViewCell: UITableViewCell {
    
    let flowlayout = UICollectionViewFlowLayout()
    
    var reviewImageDatas : [ReviewManageModelResponse] = []
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var storeNameLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var reviewCommentLabel: UILabel!
    @IBOutlet var reviewStar_a: UIImageView!
    @IBOutlet var reviewStar_b: UIImageView!
    @IBOutlet var reviewStar_c: UIImageView!
    @IBOutlet var reviewStar_d: UIImageView!
    @IBOutlet var reviewStar_e: UIImageView!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var reviewImg: UIImageView!
    @IBOutlet var productName: UILabel!
}
    
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        flowlayout.minimumLineSpacing = 0
//        reviewCommentLabel.sizeToFit()
//        
//        reviewImg.layer.cornerRadius = 10
//        reviewImg.clipsToBounds = true
//    }
//    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//    }
//}
//
////extension ReviewManageViewController: UITableViewDelegate, UITableViewDataSource {
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return reviewDatas.count
////    }
////
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: "myReviewTableViewCell", for: indexPath) as! ReviewManageTableViewCell
////
////        let rebornData = reviewDatas[indexPath.row]
////
////        let url = URL(string: rebornData.reviewImg ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/20959843-0000-46c8-aaff-38342f93dd47.jpg")
////        cell.dateLabel.text = rebornData.reviewCreatedAt
////        cell.storeNameLabel.text = rebornData.storeName
////        cell.categoryLabel.text = rebornData.storeCategory
////        cell.productName.text = rebornData.productName
////        cell.reviewImg.load(url: url!)
////        cell.reviewCommentLabel.text = rebornData.reviewComment
////
////        return cell
////    }
////
////}
////
