//
//  StoreModalViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/14.
//

import UIKit

class StoreModalViewController: UIViewController {

    @IBOutlet weak var modalButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalButton.layer.cornerRadius = 5
        modalButton.layer.borderWidth = 1
        modalButton.layer.borderColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1).cgColor
    }
}
