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
    }
}

extension SecondTabTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Rdatas[collectionView.tag].reviewImgList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondTab_CollectionViewCell", for: indexPath) as! SecondTabCollectionViewCell
        
        let url = URL(string: Rdatas[collectionView.tag].reviewImgList[indexPath.row])
        cell.imageView.load(url: url!)
        return cell
    }
}
