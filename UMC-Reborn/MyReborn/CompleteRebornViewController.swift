//
//  CompleteRebornViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/02/14.
//

import UIKit

class CompleteRebornViewController:UIViewController {
    
    @IBOutlet var date: UILabel!
    @IBOutlet var storeName: UILabel!
    @IBOutlet var storeCategory: UILabel!
    @IBOutlet var productImg: UIImageView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productDetail: UILabel!
    @IBOutlet var productAlert: UILabel!
    @IBOutlet var storeAddr: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var statusImage: UILabel!
    @IBOutlet var changeCode: UILabel!
    
    
    var apiData: RebornHistoryDetailResponse!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.productImg.layer.cornerRadius = 10
        
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
    func getData() {
        print("getData() 함수 실행")
    }
}
