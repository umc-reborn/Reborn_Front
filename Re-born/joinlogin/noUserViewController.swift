//
//  noUserViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/03/15.
//

import UIKit

class noUserViewController: UIViewController {

    
    @IBOutlet var whitebackView: UIView!
    
    
    @IBOutlet var hwakinButton1: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        whitebackView.layer.cornerRadius = 10
    }
    
    @IBAction func yyessButtonTapped(_ sender: Any){
        self.presentingViewController?.dismiss(animated: true)
    }
    

}
