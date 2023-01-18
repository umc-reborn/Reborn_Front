//
//  RecentStoreViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/01/18.
//

import UIKit

class RecentStoreViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션 back button 텍스트 설정
        self.navigationController?.navigationBar.topItem?.title = ""
        // 네비게이션 타이틀 설정
        self.title = "최근 본 리본 가게"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
}
