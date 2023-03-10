//
//  PwOkViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/28.
//

import UIKit

class PwOkViewController: UIViewController {

    @IBOutlet weak var pwchangeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pwchangeView.layer.cornerRadius = 10
        pwchangeView.clipsToBounds = true
    }
    
    
    @IBAction func okButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
