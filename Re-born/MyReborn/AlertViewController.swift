//
//  AlertViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/03/08.
//

import UIKit
import Alamofire

class AlertViewController: UIViewController {
    
    @IBOutlet var alertView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertView.layer.cornerRadius = 10
        alertView.clipsToBounds = true
        
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
}
