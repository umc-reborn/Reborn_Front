//
//  StoreModalViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/14.
//

import UIKit

class StoreModalViewController: UIViewController {

    @IBOutlet weak var modalButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalButton.layer.cornerRadius = 5
        modalButton.layer.borderWidth = 1
        modalButton.layer.borderColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1).cgColor
    }

    @IBAction func tappedButton(_ sender: Any) {
        if (likeButton.image(for: .selected) == UIImage(named: "ic_like")) {
            likeButton.isSelected = false
            likeButton.setImage(UIImage(named: "ic_like_gray"), for: .normal)
            likeButton.setImage(UIImage(named: "ic_like_gray"), for: .selected)
            likeButton.tintColor = .clear
        } else {
            likeButton.isSelected = true
            likeButton.setImage(UIImage(named: "ic_like"), for: .selected)
            likeButton.tintColor = .clear
        }
    }
    
    
}
