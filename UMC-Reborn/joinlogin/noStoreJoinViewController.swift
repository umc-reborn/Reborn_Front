//
//  noStoreJoinViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/03/18.
//

import UIKit

class noStoreJoinViewController: UIViewController {

    
    
    @IBOutlet var whibackView: UIView!
    
    @IBOutlet var ookkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        whibackView.layer.cornerRadius = 10
    }
    
    @IBAction func ookkButtonTapped(_ sender: Any){
        self.presentingViewController?.dismiss(animated: true)
    }
    

}
