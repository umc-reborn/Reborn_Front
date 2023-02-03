//
//  PersonalHomeViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/11.
//

import UIKit

class PersonalHomeViewController: UIViewController {

    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var defaultSubLabel: UILabel!
    @IBOutlet weak var defaultLabel: UILabel!
    @IBOutlet weak var umcimg: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addShadow()
    }
    
    private func addShadow(){
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.borderWidth = 0
        backgroundView.layer.borderColor = UIColor.black.cgColor
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 2, height: 0)
        backgroundView.layer.shadowOpacity = 0.15
        backgroundView.layer.shadowRadius = 8
        backgroundView.layer.masksToBounds = true
        backgroundView.layer.masksToBounds = false
    }


}
