//
//  StoreReviewViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/21.
//

import UIKit

var Rdata = [
    ReviewStoreListModel(reviewImgList:  ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/28aed2c9-fc93-4792-bbd1-496be6e24084.jpg"]),
    ReviewStoreListModel(reviewImgList:  ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/a8e868cf-f1cb-4ac4-a83a-82f3710039d5.jpg"]),
    ReviewStoreListModel(reviewImgList:  ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/6e3b607a-a2c4-4512-b48e-205b660bc0e9.jpg"]),
    ReviewStoreListModel(reviewImgList:  ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/dd1d2acb-eb7f-402e-b653-8d18fa49bffb.jpg"]),
    ReviewStoreListModel(reviewImgList:  ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/742b71e4-504d-4301-ae6c-3cd8000ccbea.jpg"]),
    ReviewStoreListModel(reviewImgList:  ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/91b7ec1d-1f7e-47bb-8bc5-a8172849a859.jpg"]),
    ReviewStoreListModel(reviewImgList:  ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/51d9c131-7ebd-43e1-8ea0-5a3ab17eeb3c.jpg"]),
    ReviewStoreListModel(reviewImgList:  ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/3caae6ac-eaa9-4c8f-ba70-f57efb8d1c60.jpg"]),
    ReviewStoreListModel(reviewImgList:  ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/18bae8f0-82b0-406f-ac07-08b3baa4ca31.jpg"]),
    ReviewStoreListModel(reviewImgList:  ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/ee808a37-a23d-482f-95e0-b57c5d6cb1cb.jpg"]),
    ReviewStoreListModel(reviewImgList:  ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/80559139-8da4-47bd-8be5-cd51d038c6b7.jpeg"]),
    ReviewStoreListModel(reviewImgList:  ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/538ede0c-3eb5-4019-b09b-0c12c269e7b7.jpeg"]),
    ReviewStoreListModel(reviewImgList:  ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/88cc6d35-4618-4322-8567-720ec92abb8e.jpeg"]),
    ReviewStoreListModel(reviewImgList:  ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/cefb81ee-e334-42f9-a41b-f9f9c1e52e8e.jpeg"]),
    ReviewStoreListModel(reviewImgList:  ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/5c9bb2b2-1e9c-4929-bdd1-ce236100658d.jpeg"]),
    ReviewStoreListModel(reviewImgList:  ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/dd2d332c-6ef9-4d23-9cdb-83fec9c5c13e.jpeg"]),
    ReviewStoreListModel(reviewImgList:  ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/f8954eeb-59a2-4e35-8daf-b91adb5be2bb.jpeg"]),
    ReviewStoreListModel(reviewImgList:  ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/74cc9c7a-6f53-4095-af56-7a40f46a997e.jpeg"]),
    ReviewStoreListModel(reviewImgList:  ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/98a3bc42-d7e6-48a0-95ec-7062ad6e2288.jpeg"]),
    ReviewStoreListModel(reviewImgList:  ["https://rebornbucket.s3.ap-northeast-2.amazonaws.com/4adb6ce7-f8a2-44a4-b249-7b84c55efa0d.jpeg"]),
]

class StoreReviewViewController: UIViewController {
    
    let storeReview = UserDefaults.standard.integer(forKey: "userIdx")
    
    var storeId: Int = 4
    
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
        
        let url = APIConstants.baseURL + "/review/store/\(storeReview)/buz"
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
        
        let url = APIConstants.baseURL + "/review/cnt?storeIdx=\(storeReview)"
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
