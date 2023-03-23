//
//  RebornHistoryDetailViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/02/08.
//

import Foundation
import Alamofire 

class RebornHistoryDetailViewController: UIViewController {
    
    var rebornTaskIdx: Int = 0
    var timeLimit: String = ""
    var timeSecond = 10 {
        willSet(newValue) {
            var hours = String(newValue / 3600)
            var minutes = String(newValue / 60)
            var seconds = String(newValue % 60)
            if hours.count == 1 { hours = "0"+hours }
            if minutes.count == 1 { minutes = "0"+minutes }
            if seconds.count == 1 { seconds = "0"+seconds }
            timeLabel.text = "\(hours):\(minutes):\(seconds)"
        }
    }
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeCategory: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDetail: UILabel!
    @IBOutlet weak var changeCode: UILabel!
    @IBOutlet weak var productAlert: UILabel!
    @IBOutlet weak var storeAddr: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var timeLabel: UILabel!
    
    var apiData: RebornHistoryDetailResponse!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hourCLimit1 = timeLimit[String.Index(encodedOffset: 0)].wholeNumberValue ?? 0
        let hourCLimit2 = timeLimit[String.Index(encodedOffset: 1)].wholeNumberValue ?? 0
        let minuteCLimit1 = timeLimit[String.Index(encodedOffset: 3)].wholeNumberValue ?? 0
        let minuteCLimit2 = timeLimit[String.Index(encodedOffset: 4)].wholeNumberValue ?? 0
        let hourTimer = 3600 * (hourCLimit1 * 10 + hourCLimit2)
        let minuteTimer = 60 * (minuteCLimit1 * 10 + minuteCLimit2)
        
        let wholeSeconds = hourTimer + minuteTimer
        
        timeSecond = wholeSeconds
        
        self.contentView.layer.cornerRadius = 10
        self.productImg.layer.cornerRadius = 10
        
getRebornHistoryDetail { result in
            switch result {
            case .success(let response):
                print("성공일까?")

                // 값 불러오기
                print("response is \(response)")
                guard let response = response as? RebornHistoryDetailModel else {
                    break
                }
                
                self.apiData = response.result
            
                
                let url = URL(string: self.apiData.storeImage)
                self.storeName.text = self.apiData.storeName
                self.status.text = self.apiData.status
                self.changeCode.text = "\(self.apiData.productExchangeCode)"
                self.productName.text = self.apiData.productName
                self.productAlert.text = self.apiData.productGuide
                self.productDetail.text = self.apiData.productComment
                self.productImg.load(url: url!)
                self.storeAddr.text = self.apiData.storeAddress
                self.storeCategory.text = self.apiData.category
                self.date.text = self.apiData.createdAt

            default:
                break
            }
        }
    }
    //
    func getData() {
        print("getData() 함수 실행")
    
    }

    @IBAction func FinishRebornTapped(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AlertViewController") as? AlertViewController else { return }
        nextVC.modalPresentationStyle = .overCurrentContext
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
    func getRebornHistoryDetail(completion: @escaping (NetworkResult<Any>) -> Void) {
        var RebornHistoryDetailUrl = "http://www.rebornapp.shop/reborns/history/detail/\(rebornTaskIdx)"
        print("rebornHistoryDetail의 taskIdx는 \(rebornTaskIdx)")


        let url: String! = RebornHistoryDetailUrl
        let header: HTTPHeaders = [
            // 헤더 프린트 해서 post 형태로 데이터를 불러오는거라서 오키오키
            "Content-type": "application/json"
            //                "jwt"
        ]
        
        let dataRequest = AF.request(
            url, method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: header
        )
        
        dataRequest.responseData { response in
            dump(response)
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                //                     dump(statusCode)
                // 여기 부분 수정 value
                guard let value = response.value else { return }
                //                     dump(value)
                let networkResult = self.judgeStatus(by: statusCode, value, RebornHistoryDetailModel.self)
                completion(networkResult)
                print("여기까지")
                
            case .failure:
                completion(.networkFail)
                print("여기서")
            }
        }
    }
    
    private func judgeStatus<T:Codable> (by statusCode: Int, _ data: Data, _ type: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(type.self, from: data)
        else { print("decode fail")
            
            return .pathErr }

        switch statusCode {
        case 200 ..< 300: return .success(decodedData as Any)
        case 400 ..< 500: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
}

