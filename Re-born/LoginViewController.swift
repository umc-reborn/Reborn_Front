//
//  LoginViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/01/16.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var Id: UITextField!
    @IBOutlet weak var PassWord: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    
    
    @IBOutlet weak var Neigherhood: UIButton!
    @IBOutlet weak var Market: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
        
        Id.layer.cornerRadius = 4
        Id.layer.borderWidth = 1
        Id.layer.borderColor = UIColor.gray.cgColor // textfield 테두리
        Id.layer.backgroundColor = UIColor.white.cgColor // textfield 채우기
        
        PassWord.layer.cornerRadius = 4
        PassWord.layer.borderWidth = 1
        PassWord.layer.borderColor = UIColor.gray.cgColor // textfield 테두리
        PassWord.layer.backgroundColor = UIColor.white.cgColor // textfield 채우기
        PassWord.isSecureTextEntry = true // 비밀번호 가리기
        
        LoginButton.layer.cornerRadius = 4
        
    }
}
