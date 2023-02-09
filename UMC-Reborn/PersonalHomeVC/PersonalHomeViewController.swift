//
//  PersonalHomeViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/11.
//

import UIKit



class PersonalHomeViewController: UIViewController {

    
    var userText : Int = 0
    var userNickNameText : String = ""

    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var defaultSubLabel: UILabel!
    @IBOutlet weak var defaultLabel: UILabel!
    @IBOutlet weak var umcimg: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addShadow()
        print(userText)
        print(userNickNameText)
        //nickNameLabel.text = userNickNameText
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
