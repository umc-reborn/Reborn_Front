//
//  ModalPersonalViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/14.
//

import UIKit

class ModalPersonalViewController: UIViewController {
    
    @IBOutlet var storeImage: UIImageView!
    @IBOutlet var modalButton: UIButton!
    
    @IBOutlet var modalView: UIView!
    
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var categoryLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var addressLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
