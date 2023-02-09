//
//  RebornHistoryDetailViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/02/08.
//

import UIKit

class RebornHistoryDetailViewController: UIViewController {
    
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
    
    var apiData: RebornHistoryDetailResponse!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        RebornHistoryDetailService.shared.getRebornHistoryDetail { result in
            switch result {
            case .success(let response):
                print("성공일까?")
                //
//                if let name1 = response as? [String: Any] {
//                    if let storeName1 = name1["storeName"] {
//                        self.storeName.text = storeName1 as! String
//                    }
//                }
                // 값 불러오기
                print("response is \(response)")
                guard let response = response as? RebornHistoryDetailModel else {
                    break
                }
                self.apiData = response.result
                print("response.result is \(response.result)")
                print("self.apiData is \(self.apiData)")
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
                
                
                
//                self.storeName.text = self.apiData.storeName
//                if let data = response as? RebornHistoryDetailResponse {
//                    let url = URL(string: data.storeImage)
//                    print("데이터 있니?\(data.storeName)")
//                    self.storeName.text = data.storeName
//                    self.status.text = data.status
//                    self.changeCode.text = "\(data.productExchangeCode)"
//                    self.productName.text = data.productName
//                    self.productAlert.text = data.productGuide
//                    self.productDetail.text = data.productComment
//                    self.productImg.load(url: url!)
//                    self.storeAddr.text = data.storeAddress
//                    self.storeCategory.text = data.category
//                    self.date.text = data.createdAt
//                } else { print ("data is nil")}
//
//                guard let response = response as? RebornHistoryDetailModel else {
//                    print("실패")
//                    break
//                }

            default:
                break
            }
        }
    }
    //
    func getData() {
        print("getData() 함수 실행")
    
//        let url = URL(string: apiData.storeImage)
//
//        date.text = apiData.createdAt
//        storeName.text = apiData.storeName
//        storeCategory.text = apiData.category
//        productImg.load(url: url!)
//        print("\(productImg.load(url: url!))")
//        productName.text = apiData.productName
//        productDetail.text = apiData.productComment
//        changeCode.text = String(apiData.productExchangeCode)
//        productAlert.text = apiData.productGuide
//        storeAddr.text = apiData.storeAddress
//        status.text = apiData.status
    }

}
