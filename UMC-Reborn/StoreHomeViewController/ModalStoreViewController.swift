//
//  ModalStoreViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/27.
//

import UIKit

class ModalStoreViewController: UIViewController {
    
    @IBOutlet weak var modalButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var bellButton: UIButton!
    @IBOutlet weak var modalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        modalButton.layer.cornerRadius = 5
        modalButton.layer.borderWidth = 1
        modalButton.layer.borderColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1).cgColor
        
        modalView.clipsToBounds = true
        modalView.layer.cornerRadius = 10
        modalView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
    }
    

    @IBAction func tappedlike(_ sender: Any) {
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
    
    @IBAction func tappedbell(_ sender: Any) {
        if (bellButton.image(for: .selected) == UIImage(named: "ic_bell")) {
            bellButton.isSelected = false
            bellButton.setImage(UIImage(named: "ic_bell_gray"), for: .normal)
            bellButton.setImage(UIImage(named: "ic_bell_gray"), for: .selected)
            bellButton.tintColor = .clear
        } else {
            bellButton.isSelected = true
            bellButton.setImage(UIImage(named: "ic_bell"), for: .selected)
            bellButton.tintColor = .clear
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startModal(_ sender: Any) {
        if (modalButton.title(for: .selected) == "리본이 진행중 입니다!") {
            modalButton.isSelected = false
            modalButton.setTitle("진행중인 리본이 없습니다.", for: .normal)
            modalButton.setTitle("진행중인 리본이 없습니다.", for: .selected)
            modalButton.setTitleColor(UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1), for: .selected)
            modalButton.setTitleColor(UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1), for: .normal)
        } else {
            modalButton.isSelected = true
            modalButton.setTitle("리본이 진행중 입니다!", for: .selected)
            modalButton.setTitleColor(UIColor(red: 255/255, green: 77/255, blue: 21/255, alpha: 1), for: .selected)
        }
    }
}
