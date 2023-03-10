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
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet var contentView: UIView!
    
    var apiData: RebornHistoryDetailResponse!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentView.layer.cornerRadius = 10
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
    //
    func getData() {
        print("getData() 함수 실행")
    
    }

    @IBAction func FinishRebornTapped(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AlertViewController") as? AlertViewController else { return }
        nextVC.modalPresentationStyle = .overCurrentContext
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
}
