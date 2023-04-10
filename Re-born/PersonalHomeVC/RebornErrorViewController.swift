//
//  RebornErrorViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/04/05.
//

import UIKit

class RebornErrorViewController: UIViewController {
    
    @IBOutlet var errorView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        errorView.layer.cornerRadius = 10
        errorView.clipsToBounds = true
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: false, completion: nil)
    }
}
