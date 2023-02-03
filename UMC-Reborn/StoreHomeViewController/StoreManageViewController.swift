//
//  StoreManageViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/13.
//

import UIKit

class StoreManageViewController: UIViewController, SampleProtocol3 {
    
    var apiResult = [StoreListModel]()
    
    func categorySend(data: String) {
        storeCategory.text = data
        storeCategory.sizeToFit()
    }
    
    func introduceSend(data: String) {
        storeIntroduce.text = data
        storeIntroduce.sizeToFit()
    }
    
    func addressSend(data: String) {
        storeAddress.text = data
        storeAddress.sizeToFit()
    }
    
    func nameSend(data: String) {
        storeName.text = data
        storeName.sizeToFit()
    }
    
    @IBOutlet weak var storeView: UIView!
    @IBOutlet weak var ManageImageView: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeCategory: UILabel!
    @IBOutlet weak var storeIntroduce: UILabel!
    @IBOutlet weak var storeAddress: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var rebornLabel: UILabel!
    @IBOutlet weak var jjimLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIHandlerStoreGet.sharedInstance.SendingGetStore { apiData in
            self.apiResult = apiData
        }
        
        ManageImageView.layer.cornerRadius = 10
        ManageImageView.clipsToBounds = true
        
        self.navigationController?.navigationBar.topItem?.title = "가게 관리"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)]

        storeView.clipsToBounds = true
        storeView.layer.cornerRadius = 20
        storeView.layer.masksToBounds = false
        storeView.layer.shadowOffset = CGSize(width: 3, height: 8)
        storeView.layer.shadowRadius = 20
        storeView.layer.shadowOpacity = 0.1
        
        let attributedString = NSMutableAttributedString(string: reviewLabel.text!, attributes: [
            .font: UIFont(name: "AppleSDGothicNeo-Bold", size: 13) ?? UIFont.systemFont(ofSize: 13),
            .foregroundColor: UIColor(white: 0.0, alpha: 1.0),
            .kern: -0.01
        ])
        attributedString.addAttribute(.font, value: UIFont(name: "AppleSDGothicNeo-Bold", size: 13) ?? UIFont.systemFont(ofSize: 13), range: (reviewLabel.text! as NSString).range(of: "41"))
        self.reviewLabel.attributedText = attributedString
        
        let attributedString1 = NSMutableAttributedString(string: rebornLabel.text!, attributes: [
            .font: UIFont(name: "AppleSDGothicNeo-Bold", size: 13) ?? UIFont.systemFont(ofSize: 13),
            .foregroundColor: UIColor(white: 0.0, alpha: 1.0),
            .kern: -0.01
        ])
        attributedString1.addAttribute(.font, value: UIFont(name: "AppleSDGothicNeo-Bold", size: 13) ?? UIFont.systemFont(ofSize: 13), range: (rebornLabel.text! as NSString).range(of: "64"))
        self.rebornLabel.attributedText = attributedString1
        
        let attributedString2 = NSMutableAttributedString(string: jjimLabel.text!, attributes: [
            .font: UIFont(name: "AppleSDGothicNeo-Bold", size: 13) ?? UIFont.systemFont(ofSize: 13),
            .foregroundColor: UIColor(white: 0.0, alpha: 1.0),
            .kern: -0.01
        ])
        attributedString2.addAttribute(.font, value: UIFont(name: "AppleSDGothicNeo-Bold", size: 13) ?? UIFont.systemFont(ofSize: 13), range: (jjimLabel.text! as NSString).range(of: "64"))
        self.jjimLabel.attributedText = attributedString2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            self.navigationItem.title="가게 관리"
    }
}
