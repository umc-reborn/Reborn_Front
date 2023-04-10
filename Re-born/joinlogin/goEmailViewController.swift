//
//  goEmailViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/03/11.
//

import UIKit

class goEmailViewController: UIViewController {

    @IBOutlet var okkButton: UIButton!
    
    @IBOutlet var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backView.layer.cornerRadius = 10
    }
    
    
    @IBAction func okkButtonTapped(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
