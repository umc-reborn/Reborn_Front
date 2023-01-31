//
//  StoreReviewViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/21.
//

import UIKit

var Rdata = [
    ReviewImages(reviewimage: ["Review_image", "Review_image"]),
    ReviewImages(reviewimage: ["store_image", "store_image"])
]

class StoreReviewViewController: UIViewController {

    @IBOutlet weak var StoreReviewTableView: UITableView!
    
    let ImageArray = ["person_image", "person_image_w"]
    let NickNameArray = ["빵좋아하는사람입니다", "hyerimlandlandland"]
    let RateArray = ["5", "4"]
    let CountArray = ["1", "2"]
    let FoodArray = ["단팥빵", "감자 고로케"]
    let CommentArray = ["빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵빵", "진짜 너무 부드럽고 너무 맛있어요 짱짱!!!"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        StoreReviewTableView.delegate = self
        StoreReviewTableView.dataSource = self
        StoreReviewTableView.rowHeight = UITableView.automaticDimension
        StoreReviewTableView.estimatedRowHeight = UITableView.automaticDimension
        StoreReviewTableView.contentInset = .zero
        StoreReviewTableView.contentInsetAdjustmentBehavior = .never
        
        StoreReviewTableView.layer.masksToBounds = true // any value you want
        StoreReviewTableView.layer.shadowOpacity = 0.1// any value you want
        StoreReviewTableView.layer.shadowRadius = 10 // any value you want
        StoreReviewTableView.layer.shadowOffset = .init(width: 5, height: 10)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
