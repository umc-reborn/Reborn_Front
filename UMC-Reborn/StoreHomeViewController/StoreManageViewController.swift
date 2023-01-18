//
//  StoreManageViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/13.
//

import UIKit

class StoreManageViewController: UIViewController, SampleProtocol3 {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            self.navigationItem.title="가게 관리"
    }

    @IBAction func nextButton(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "EditStoreViewController") as? EditStoreViewController else { return }
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.delegate = self
        self.present(nextVC, animated: true, completion: nil)
    }
}
