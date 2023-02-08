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
    
    var apiData: [RebornHistoryDetailResponse] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        RebornHistoryDetailService.shared.getRebornHistoryDetail { result in
            switch result {
            case .success(let response):
                print("성공")
                //
//                if let name1 = response as? [String: Any] {
//                    if let storeName1 = name1["storeName"] {
//                        self.storeName.text = storeName1 as! String
//                    }
//                }
                // 값 불러오기
                if let data = response as? RebornHistoryDetailResponse {
                    self.storeName.text = data.storeName
                }
                //
                guard let response = response as? RebornHistoryDetailModel else {
                    print("실패")
                    break
                }
                self.apiData = response.result
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
