//
//  ReviewManageViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/01/18.
//

import UIKit

class ReviewManageViewController: UIViewController {
    
    let userReview = UserDefaults.standard.integer(forKey: "userIndex")
    
    var reviewDatas: [ReviewManageModelResponse] = []
    
    var storeTitle: String = ""
    var storeCategory: String = ""
    var reviewDate: String = ""
    
    @IBOutlet var myReviewTableView: UITableView!
    @IBOutlet var myReviewCount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myReviewTableView.delegate = self
        myReviewTableView.dataSource = self
        myReviewTableView.rowHeight = UITableView.automaticDimension
        myReviewTableView.estimatedRowHeight = UITableView.automaticDimension
        myReviewTableView.contentInset = .zero
        myReviewTableView.contentInsetAdjustmentBehavior = .never
        
        myReviewTableView.layer.masksToBounds = true // any value you want
        myReviewTableView.layer.shadowOpacity = 0.1// any value you want
        myReviewTableView.layer.shadowRadius = 10 // any value you want
        myReviewTableView.layer.shadowOffset = .init(width: 5, height: 10)
        
        reviewResult()
        print("reviewResult값 확인 \(reviewResult())")
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
                    print("리뷰 조회에서 불러온 데이터 값은 \(reviewDatas)")
                    DispatchQueue.main.async {
                        self.myReviewTableView.reloadData()
                        print("count: \(self.reviewDatas.count)")
                        print("완벽함")
                        self.myReviewCount.text = String(self.reviewDatas.count)
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
