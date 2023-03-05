//
//  StoreReviewTableViewCell.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/21.
//

import UIKit

class StoreReviewTableViewCell: UITableViewCell {

    let flowlayout = UICollectionViewFlowLayout()
    
    var reviewImageDatas : [ReviewListModel] = []
    
    @IBOutlet weak var dateLabel: UILabel!
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
    @IBOutlet var reviewImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        flowlayout.minimumLineSpacing = 0
        reviewComment.sizeToFit()
//        reviewImageResult()
        
        personImage.layer.cornerRadius = self.personImage.frame.size.height / 2
        personImage.layer.masksToBounds = true
        personImage.clipsToBounds = true
        reviewImg.layer.cornerRadius = 10
        reviewImg.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
//    func reviewImageResult() {
//
//        let url = APIConstants.baseURL + "/review/store/2/buz"
//        let encodedStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//
//        guard let url = URL(string: encodedStr) else { print("err"); return }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        URLSession.shared.dataTask(with: request) { [self] data, response, error in
//            if error != nil {
//                print("err")
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~=
//            response.statusCode else {
//                print("Error: HTTP request failed")
//                return
//            }
//
//            if let safeData = data {
//
//                do {
//                    let decoder = JSONDecoder()
//                    decoder.keyDecodingStrategy = .convertFromSnakeCase
//                    let decodedData = try decoder.decode(ReviewList.self, from: safeData)
//                    self.reviewImageDatas = decodedData.result
//                    print("reviewImageDatas: \(reviewImageDatas)")
//                    DispatchQueue.main.async {
//                        self.collectionView.reloadData()
//                    }
//
//                } catch let DecodingError.dataCorrupted(context) {
//                    print(context)
//                } catch let DecodingError.keyNotFound(key, context) {
//                    print("Key '\(key)' not found:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
//                } catch let DecodingError.valueNotFound(value, context) {
//                    print("Value '\(value)' not found:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
//                } catch let DecodingError.typeMismatch(type, context)  {
//                    print("Type '\(type)' mismatch:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
//                } catch {
//                    print("error: ", error)
//                }
//            }
//        }.resume()
//    }
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
        let url2 = URL(string: rebornData.reviewImg ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/20959843-0000-46c8-aaff-38342f93dd47.jpg")
        let createTime = rebornData.reviewCreatedAt
        let yearTime = createTime.prefix(4)
        let monthTime1 = createTime[String.Index(encodedOffset: 5)]
        let monthTime2 = createTime[String.Index(encodedOffset: 6)]
        let dayTime1 = createTime[String.Index(encodedOffset: 8)]
        let dayTime2 = createTime[String.Index(encodedOffset: 9)]
        cell.dateLabel.text = "\(yearTime)/\(monthTime1)\(monthTime2)/\(dayTime1)\(dayTime2)"
        cell.nicknameLabel.text = rebornData.userNickname
        cell.personImage.load(url: url!)
        cell.reviewImg.load(url: url2!)
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            let storeIdt = storeId
            guard let svc1 = self.storyboard?.instantiateViewController(identifier: "ModalStoreViewController") as? ModalStoreViewController else { return }
            svc1.storeIdm = storeIdt
            self.present(svc1, animated: true)
        default:
            return
        }
    }
}
