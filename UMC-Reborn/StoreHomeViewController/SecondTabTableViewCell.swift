//
//  SecondTabTableViewCell.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/25.
//

import UIKit

class SecondTabTableViewCell: UITableViewCell {

    let reviewImage = ["Review_image", "Review_image"]
    let flowlayout = UICollectionViewFlowLayout()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var reviewStar_a: UIImageView!
    @IBOutlet weak var reviewStar_b: UIImageView!
    @IBOutlet weak var reviewStar_c: UIImageView!
    @IBOutlet weak var reviewStar_d: UIImageView!
    @IBOutlet weak var reviewStar_e: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        flowlayout.minimumLineSpacing = 0
        commentLabel.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension SecondTabTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return reviewImage.count
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondTab_CollectionViewCell", for: indexPath) as! SecondTabCollectionViewCell
        
        cell.imageView.image = UIImage(named: reviewImage[indexPath.section])
        
        return cell
    }
}

extension SecondTabViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return shopList.count
    }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTab_TableViewCell", for: indexPath) as! SecondTabTableViewCell

            return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 433
    }
        
}
