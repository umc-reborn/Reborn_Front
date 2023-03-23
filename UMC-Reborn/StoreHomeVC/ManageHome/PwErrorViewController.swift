//
//  PwErrorViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/28.
//

import UIKit

class PwErrorViewController: UIViewController {

    @IBOutlet weak var pwerrorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pwerrorView.layer.cornerRadius = 10
        pwerrorView.clipsToBounds = true
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: false, completion: nil)
    }
}
