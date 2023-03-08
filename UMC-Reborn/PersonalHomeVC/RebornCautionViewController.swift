//
//  RebornCautionViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/15.
//

import UIKit

class RebornCautionViewController: UIViewController {
    
    @IBOutlet var cautionView: UIView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var yesButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        cautionView.layer.cornerRadius = 10
        cautionView.clipsToBounds = true
        cancelButton.layer.cornerRadius = 0
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1).cgColor
        yesButton.layer.cornerRadius = 0
        yesButton.layer.borderWidth = 1
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func yesTapped(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
