//
//  sendPwViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/03/15.
//

import UIKit

class sendPwViewController: UIViewController {

    @IBOutlet var backWhView: UIView!
    
    @IBOutlet var yessButton33: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backWhView.layer.cornerRadius = 10
    }
    
 //햄언니한테 물어보기 - 다음 화면 어디로 가면 될까?
    @IBAction func yyess1ButtonTapped(_ sender: Any){
        self.presentingViewController?.dismiss(animated: true)
    }

}
