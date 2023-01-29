//
//  StoreManageViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/13.
//

import UIKit

class StoreManageViewController: UIViewController {

    @IBOutlet weak var storeView: UIView!
    @IBOutlet weak var ManageImageView: UIImageView!
    
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

}
