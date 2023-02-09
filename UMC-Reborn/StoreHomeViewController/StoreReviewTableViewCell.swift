//
//  StoreReviewTableViewCell.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/21.
//

import UIKit

class StoreReviewTableViewCell: UITableViewCell {

    let flowlayout = UICollectionViewFlowLayout()
    
    var reviewImageDatas : [ReviewStoreListModel] = []
    
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
        reviewImageResult()
        print("Rdata: \(Rdata)")
        
        personImage.layer.cornerRadius = self.personImage.frame.size.height / 2
        personImage.layer.masksToBounds = true
        personImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func reviewImageResult() {
        
        let url = APIConstants.baseURL + "/review/store/1/buz"
        let encodedStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let url = URL(string: encodedStr) else { print("err"); return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { [self] data, response, error in
            if error != nil {
                print("err")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~=
            response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            if let safeData = data {
                print(String(decoding: safeData, as: UTF8.self))
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(ReviewStoreList.self, from: safeData)
                    self.reviewImageDatas = decodedData.result
                    print("reviewImageDatas: \(reviewImageDatas)")
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }
        }.resume()
    }
}

extension StoreReviewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return reviewImageDatas[collectionView.tag].reviewImgList.count
//        return reviewImageDatas[collectionView.tag].reviewImgList.count
//        let ddd = reviewImageDatas[collectionView.tag].reviewImg
//        if (ddd.reviewImage1 != nil && ddd.reviewImage2 == nil && ddd.reviewImage3 == nil && ddd.reviewImage4 == nil && ddd.reviewImage5 == nil) {
//            return 1
//        } else if (ddd.reviewImage1 != nil && ddd.reviewImage2 != nil && ddd.reviewImage3 == nil && ddd.reviewImage4 == nil && ddd.reviewImage5 == nil) {
//            return 2
//        } else if (ddd.reviewImage1 != nil && ddd.reviewImage2 != nil && ddd.reviewImage3 != nil && ddd.reviewImage4 == nil && ddd.reviewImage5 == nil) {
//            return 3
//        } else if (ddd.reviewImage1 != nil && ddd.reviewImage2 != nil && ddd.reviewImage3 != nil && ddd.reviewImage4 != nil && ddd.reviewImage5 == nil) {
//            return 4
//        } else {
//            return 5
//        }
//        return reviewImageDatas[collectionView.tag].reviewImg.count
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoreReview_CollectionViewCell", for: indexPath) as! StoreReviewCollectionViewCell
//        let reviewDatas = reviewImageDatas[collectionView.tag].reviewImgList[indexPath.row]
//        let url = URL(string: reviewImageDatas[collectionView.tag].reviewImgList[indexPath.row])
//        cell.imageView.load(url: url!)
//        let reviewDatas = reviewImageDatas[collectionView.hash].reviewImg
//        print(reviewDatas)
        let ddd = reviewImageDatas[collectionView.tag].reviewImgList[indexPath.row]
        print("ddd: \(ddd)")
        let url = URL(string: Rdata[collectionView.tag].reviewImgList[indexPath.row])
        cell.imageView.load(url: url!)
        return cell
    }
}

extension StoreReviewViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreReview_TableViewCell", for: indexPath) as! StoreReviewTableViewCell
        
        let rebornData = reviewDatas[indexPath.section]
//        let ddd : [String] = [rebornData.reviewImage1 ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/6f9043df-c35f-4f57-9212-cccaa0091315.png", rebornData.reviewImage2 ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/6f9043df-c35f-4f57-9212-cccaa0091315.png", rebornData.reviewImage3 ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/6f9043df-c35f-4f57-9212-cccaa0091315.png", rebornData.reviewImage4 ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/6f9043df-c35f-4f57-9212-cccaa0091315.png", rebornData.reviewImage5 ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/6f9043df-c35f-4f57-9212-cccaa0091315.png"]
//        print(ddd)
        let url = URL(string: rebornData.userImg ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/20959843-0000-46c8-aaff-38342f93dd47.jpg")
        let createTime = rebornData.reviewCreatedAt
        let yearTime = createTime.prefix(4)
        let monthTime1 = createTime[String.Index(encodedOffset: 5)]
        let monthTime2 = createTime[String.Index(encodedOffset: 6)]
        let dayTime1 = createTime[String.Index(encodedOffset: 8)]
        let dayTime2 = createTime[String.Index(encodedOffset: 9)]
        cell.dateLabel.text = "\(yearTime)/\(monthTime1)\(monthTime2)/\(dayTime1)\(dayTime2)"
        cell.nicknameLabel.text = rebornData.userNickname
        cell.personImage.load(url: url!)
        cell.foodnameLabel.text = rebornData.productName
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
        cell.reviewComment.text = rebornData.reviewComment
        cell.collectionView.tag = indexPath.row
        return cell
    }
}
