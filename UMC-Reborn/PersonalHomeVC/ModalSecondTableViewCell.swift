//
//  ModalSecondTableViewCell.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/15.
//

import UIKit

class ModalSecondTableViewCell: UITableViewCell {
    
    let flowlayout = UICollectionViewFlowLayout()
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var nickName: UILabel!
    @IBOutlet var foodName: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var reviewstar_a: UIImageView!
    @IBOutlet var reviewstar_b: UIImageView!
    @IBOutlet var reviewstar_c: UIImageView!
    @IBOutlet var reviewstar_d: UIImageView!
    @IBOutlet var reviewstar_e: UIImageView!
    
    
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

extension ModalSecondTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondTab_CollectionViewCell", for: indexPath) as! SecondTabCollectionViewCell
        
        let url = URL(string: "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/ee808a37-a23d-482f-95e0-b57c5d6cb1cb.jpg")
        cell.imageView.load(url: url!)
        return cell
    }
}
