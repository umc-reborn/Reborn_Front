//
//  IdCheckViewController.swift
//  Re-born
//
//  Created by jaegu park on 2023/05/19.
//

import UIKit

class IdCheckViewController: UIViewController {

    @IBOutlet var idCheckView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        idCheckView.layer.cornerRadius = 10
        idCheckView.clipsToBounds = true
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: false, completion: nil)
    }
}
