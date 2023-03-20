//
//  noEmailViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/03/04.
//

import UIKit

class noEmailViewController: UIViewController {

    @IBOutlet var wwhiteView: UIView!
    @IBOutlet var yesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("회원 아님!!!! ")
        
        wwhiteView.layer.cornerRadius = 10
        
    }
    

    @IBAction func yessButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
