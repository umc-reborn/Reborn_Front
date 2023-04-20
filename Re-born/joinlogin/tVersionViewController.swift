//
//  tVersionViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/03/13.
//

import UIKit

class tVersionViewController: UIViewController {

    
    @IBOutlet var iseeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mybrown = UIColor(named: "mybrown")
        
        iseeButton.setTitleColor(.white, for: .normal)
        iseeButton.layer.cornerRadius = 4.0
        iseeButton.layer.borderWidth = 1.0
        iseeButton.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        
        // back button custom
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    @IBAction func iseeButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "JoinLogin", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(identifier: "FirstLoginViewController") as? FirstLoginViewController else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
