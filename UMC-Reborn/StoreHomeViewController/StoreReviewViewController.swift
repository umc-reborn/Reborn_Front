//
//  StoreReviewViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/21.
//

import UIKit

var Rdata = [
    ReviewStoreListModel(reviewImgList:  ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA+2023-02-09+%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE+7.15.10.png"]),
    ReviewStoreListModel(reviewImgList: ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA+2023-02-09+%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE+7.15.10.png"]),
    ReviewStoreListModel(reviewImgList: ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA+2023-02-09+%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE+7.15.10.png", "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA+2023-02-09+%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE+7.15.10.png"])
]

class StoreReviewViewController: UIViewController {
    
    let storeReview = UserDefaults.standard.integer(forKey: "userIdx")
    
    var reviewDatas: [ReviewListModel] = []

    @IBOutlet weak var StoreReviewTableView: UITableView!
    @IBOutlet weak var ReviewCountLabel: UILabel!
    
    
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
        
        reviewResult()
        reviewCountResult()
    }
    
    func reviewResult() {
        
        let url = APIConstants.baseURL + "/review/store/\(String(storeReview))/buz"
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
                    let decodedData = try JSONDecoder().decode(ReviewList.self, from: safeData)
                    self.reviewDatas = decodedData.result
                    print(reviewDatas)
                    DispatchQueue.main.async {
                        self.StoreReviewTableView.reloadData()
                        print("count: \(self.reviewDatas.count)")
                        
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
    
    
    func reviewCountResult() {
        
        let url = APIConstants.baseURL + "/review/cnt?storeIdx=1"
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
                    let decodedData = try decoder.decode(ReviewCountList.self, from: safeData)
                    let storeDatas = decodedData.result
                    print(storeDatas)
                    DispatchQueue.main.async {
                        self.ReviewCountLabel.text = "우리 가게 리뷰 \(storeDatas)건"
                    }
                } catch {
                    print("error")
                }
            }
        }.resume()
    }

}
