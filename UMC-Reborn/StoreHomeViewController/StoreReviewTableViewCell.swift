//
//  StoreReviewTableViewCell.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/21.
//

import UIKit

class StoreReviewTableViewCell: UITableViewCell {

    let flowlayout = UICollectionViewFlowLayout()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var reviewStar_a: UIImageView!
    @IBOutlet weak var reviewStar_b: UIImageView!
    @IBOutlet weak var reviewStar_c: UIImageView!
    @IBOutlet weak var reviewStar_d: UIImageView!
    @IBOutlet weak var reviewStar_e: UIImageView!
    @IBOutlet weak var foodnameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var reviewComment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        flowlayout.minimumLineSpacing = 0
        reviewComment.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension StoreReviewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Rdata[collectionView.tag].reviewimage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoreReview_CollectionViewCell", for: indexPath) as! StoreReviewCollectionViewCell
        cell.imageView.image = UIImage(named: Rdata[collectionView.tag].reviewimage[indexPath.row])
        
        return cell
    }
}

extension StoreReviewViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
        return NickNameArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 433
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreReview_TableViewCell", for: indexPath) as! StoreReviewTableViewCell
        
        cell.nicknameLabel.text = NickNameArray[indexPath.section]
        cell.personImage.image = UIImage(named: ImageArray[indexPath.section])
        cell.countLabel.text = "\(CountArray[indexPath.section])개"
        cell.foodnameLabel.text = FoodArray[indexPath.section]
        if (RateArray[indexPath.section] == "5") {
            cell.reviewStar_a.image = UIImage(named: "review_star")
            cell.reviewStar_b.image = UIImage(named: "review_star")
            cell.reviewStar_c.image = UIImage(named: "review_star")
            cell.reviewStar_d.image = UIImage(named: "review_star")
            cell.reviewStar_e.image = UIImage(named: "review_star")
        } else if (RateArray[indexPath.section] == "4") {
            cell.reviewStar_a.image = UIImage(named: "review_star")
            cell.reviewStar_b.image = UIImage(named: "review_star")
            cell.reviewStar_c.image = UIImage(named: "review_star")
            cell.reviewStar_d.image = UIImage(named: "review_star")
            cell.reviewStar_e.image = UIImage(named: "review_star_gray")
        } else if (RateArray[indexPath.section] == "3") {
            cell.reviewStar_a.image = UIImage(named: "review_star")
            cell.reviewStar_b.image = UIImage(named: "review_star")
            cell.reviewStar_c.image = UIImage(named: "review_star")
            cell.reviewStar_d.image = UIImage(named: "review_star_gray")
            cell.reviewStar_e.image = UIImage(named: "review_star_gray")
        } else if (RateArray[indexPath.section] == "2") {
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
        cell.reviewComment.text = CommentArray[indexPath.section]
        cell.collectionView.tag = indexPath.section
        return cell
    }
}
