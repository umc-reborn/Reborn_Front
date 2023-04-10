//
//  ModalSecondViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/15.
//

import UIKit

class ModalSecondViewController: UIViewController {
    
    var reviewDatas: [ReviewListModel] = []
    
    var modalsecond: Int = 0
    
    var storeIdm3: Int = 0
    
    @IBOutlet var mstableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mstableView.delegate = self
        mstableView.dataSource = self
        mstableView.rowHeight = UITableView.automaticDimension
        mstableView.estimatedRowHeight = UITableView.automaticDimension
        mstableView.contentInset = .zero
        mstableView.contentInsetAdjustmentBehavior = .never
        
        mstableView.layer.masksToBounds = true // any value you want
        mstableView.layer.shadowOpacity = 0.1// any value you want
        mstableView.layer.shadowRadius = 10 // any value you want
        mstableView.layer.shadowOffset = .init(width: 0, height: 10)
        
        modalsecond = UserDefaults.standard.integer(forKey: "storeid")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.reviewResult()
        }
    }

    func reviewResult() {
        
        let url = APIConstants.baseURL + "/review/store/\(String(modalsecond))/buz2"
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
                        self.mstableView.reloadData()
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

extension ModalSecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return reviewDatas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell: ModalSecondTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ModalSecond_TableViewCell", for: indexPath) as! ModalSecondTableViewCell
        
        let rebornData = reviewDatas[indexPath.section]
        
        let url = URL(string: rebornData.userImg ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/20959843-0000-46c8-aaff-38342f93dd47.jpg")
        let url2 = URL(string: rebornData.reviewImg ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/20959843-0000-46c8-aaff-38342f93dd47.jpg")
        let createTime = rebornData.reviewCreatedAt
        let yearTime = createTime.prefix(4)
        let monthTime1 = createTime[String.Index(encodedOffset: 5)]
        let monthTime2 = createTime[String.Index(encodedOffset: 6)]
        let dayTime1 = createTime[String.Index(encodedOffset: 8)]
        let dayTime2 = createTime[String.Index(encodedOffset: 9)]
        cell.dateLabel.text = "\(yearTime)/\(monthTime1)\(monthTime2)/\(dayTime1)\(dayTime2)"
        cell.nickName.text = rebornData.userNickname
        cell.userImage.load(url: url!)
        cell.foodName.text = rebornData.productName
        cell.reviewImage.load(url: url2!)
        if (rebornData.reviewScore == 5) {
            cell.reviewstar_a.image = UIImage(named: "review_star")
            cell.reviewstar_b.image = UIImage(named: "review_star")
            cell.reviewstar_c.image = UIImage(named: "review_star")
            cell.reviewstar_d.image = UIImage(named: "review_star")
            cell.reviewstar_e.image = UIImage(named: "review_star")
        } else if (rebornData.reviewScore == 4) {
            cell.reviewstar_a.image = UIImage(named: "review_star")
            cell.reviewstar_b.image = UIImage(named: "review_star")
            cell.reviewstar_c.image = UIImage(named: "review_star")
            cell.reviewstar_d.image = UIImage(named: "review_star")
            cell.reviewstar_e.image = UIImage(named: "review_star_gray")
        } else if (rebornData.reviewScore == 3) {
            cell.reviewstar_a.image = UIImage(named: "review_star")
            cell.reviewstar_b.image = UIImage(named: "review_star")
            cell.reviewstar_c.image = UIImage(named: "review_star")
            cell.reviewstar_d.image = UIImage(named: "review_star_gray")
            cell.reviewstar_e.image = UIImage(named: "review_star_gray")
        } else if (rebornData.reviewScore == 2) {
            cell.reviewstar_a.image = UIImage(named: "review_star")
            cell.reviewstar_b.image = UIImage(named: "review_star")
            cell.reviewstar_c.image = UIImage(named: "review_star_gray")
            cell.reviewstar_d.image = UIImage(named: "review_star_gray")
            cell.reviewstar_e.image = UIImage(named: "review_star_gray")
        } else {
            cell.reviewstar_a.image = UIImage(named: "review_star")
            cell.reviewstar_b.image = UIImage(named: "review_star_gray")
            cell.reviewstar_c.image = UIImage(named: "review_star_gray")
            cell.reviewstar_d.image = UIImage(named: "review_star_gray")
            cell.reviewstar_e.image = UIImage(named: "review_star_gray")
        }
        cell.commentLabel.text = rebornData.reviewComment
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 443
    }
}
