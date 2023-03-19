//
//  ReviewManageViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/01/18.
//

import UIKit

class ReviewManageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let userReview = UserDefaults.standard.integer(forKey: "userIndex")
    
    var reviewDatas: [ReviewManageModelResponse] = []
    var img : [String] = []
    
    @IBOutlet var reviewCountLabel: UILabel!
    @IBOutlet var myReviewTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myReviewTableView = UITableView()
        myReviewTableView.dataSource = self
        myReviewTableView.delegate = self
        


//        myReviewTableView.delegate = self
//        myReviewTableView.dataSource = self
//        myReviewTableView.rowHeight = UITableView.automaticDimension
//        myReviewTableView.estimatedRowHeight = UITableView.automaticDimension
//        myReviewTableView.contentInset = .zero
//        myReviewTableView.contentInsetAdjustmentBehavior = .never
//
//        myReviewTableView.layer.masksToBounds = true // any value you want
//        myReviewTableView.layer.shadowOpacity = 0.1// any value you want
//        myReviewTableView.layer.shadowRadius = 10 // any value you want
//        myReviewTableView.layer.shadowOffset = .init(width: 5, height: 10)
        
        reviewResult()
        print("reviewResult값 확인 \(reviewResult())")
//        reviewCountResult()
    }
    
    func reviewResult() {
        
        let url = "http://www.rebornapp.shop/review"
        let encodedStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let url = URL(string: encodedStr) else { print("err"); return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let userJWT = UserDefaults.standard.string(forKey: "userJwt")!
        
        print("응답하라 \(userJWT)")
        
        // Header
        request.addValue("\(userJWT)", forHTTPHeaderField: "X-ACCESS-TOKEN")
        
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
                    let decodedData = try JSONDecoder().decode(ReviewManageModel.self, from: safeData)
                    self.reviewDatas = decodedData.result
                    
                    for i in stride(from: 0, through: reviewDatas.count-1, by: 1){
                        let ls = decodedData.result[i].reviewImg.reviewImage1
                        
                        img.append(ls)
//                        print (ls)
//                        print ("++++++++++")
                    }
                    
                    print("리뷰 조회에서 불러온 데이터 값은 \(reviewDatas)")
                    DispatchQueue.main.async {
                        self.myReviewTableView.reloadData()
                        print("count: \(self.reviewDatas.count)")
                        print("완벽함")
                        
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
    
    
//
//    // 이미지 사이즈 지정
//    let imageView: UIImageView = {
//        let aImageView = UIImageView()
//        aImageView.contentMode = .scaleAspectFill
//        aImageView.layer.cornerRadius = 16
//        aImageView.translatesAutoresizingMaskIntoConstraints = false
//        return aImageView
//    }()
//    //
//
//    var imageArray = [UIImage(named: "bread1"), UIImage(named: "bread2"),]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationItem.title = "리뷰 관리"
//
//
//
//        ReviewManageService.shared.getUserReview{ result in
//            switch result {
//            case .success(let response):
//                print("리뷰 이미지 불러오기 성공")
////                dump(response)
//                guard let response = response as? ReviewManageModel else {
//                    print("실패")
//                    break
//                }
//                self.reviewDatas = response.result
//
//            default:
//                break
//            }
//        }
//    }
//}
//
//extension ReviewManageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return imageArray.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewImageCollectionViewCell", for: indexPath) as! ReviewImageCollectionViewCell
//
//        cell.reviewImage.image = imageArray[indexPath.row]
//
//        cell.reviewImage.layer.cornerRadius  = 16
//        return cell
//    }
//
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myReviewTableViewCell", for: indexPath) as! ReviewManageTableViewCell
        
        let rebornData = reviewDatas[indexPath.section]
        let rebornImgData = img[indexPath.section]
        
        let url = URL(string: rebornImgData ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/20959843-0000-46c8-aaff-38342f93dd47.jpg")
        cell.dateLabel.text = rebornData.reviewCreatedAt
        cell.storeNameLabel.text = rebornData.storeName
        cell.categoryLabel.text = rebornData.storeCategory
        cell.productName.text = rebornData.productName
        cell.reviewImg.load(url: url!)
        cell.reviewCommentLabel.text = rebornData.reviewComment
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 506
    }
    
}
