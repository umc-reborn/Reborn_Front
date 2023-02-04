//
//  ResetPwViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/01.
//

import UIKit

class ResetPwViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    
    @IBOutlet weak var ResetIdTextfield: UITextField!
    
    @IBOutlet weak var ResetPwTextfield: UITextField!
    
    @IBOutlet weak var ResetButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let mybrown = UIColor(named: "mybrown")
        let myorange = UIColor(named: "myorange")
        let mygray = UIColor(named: "mygray")
        
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
        ResetButton.layer.borderWidth = 1.0
        ResetButton.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        ResetButton.layer.cornerRadius = 4.0
        ResetButton.setTitle("아이디 전체보기", for: .normal)  // 버튼 텍스트 설정
        ResetButton.setTitleColor(UIColor.mybrown, for: .normal)//버튼 텍스트 색상 설정
        ResetButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 18) //폰트 및 사이즈 설정
        
        ResetIdTextfield.addLeftPadding1()
        ResetIdTextfield.placeholder = "아이디를 입력해 주세요"
        ResetIdTextfield.backgroundColor = .white
        ResetIdTextfield.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        ResetIdTextfield.keyboardType = .asciiCapable // only english
        ResetIdTextfield.textColor = .black
        ResetIdTextfield.layer.borderWidth = 1.0 // 두께
        ResetIdTextfield.layer.borderColor = mygray?.cgColor // 테두리 컬러
        ResetIdTextfield.layer.cornerRadius = 4.0
        ResetIdTextfield.clearButtonMode = .always // 한번에 지우기
        
        ResetPwTextfield.addLeftPadding1()
        ResetPwTextfield.placeholder = "이메일을 입력해주세요"
        ResetPwTextfield.backgroundColor = .white
        ResetPwTextfield.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        ResetPwTextfield.keyboardType = .asciiCapable // only english
        ResetPwTextfield.textColor = .black
        ResetPwTextfield.layer.borderWidth = 1.0 // 두께
        ResetPwTextfield.layer.borderColor = mygray?.cgColor // 테두리 컬러
        ResetPwTextfield.layer.cornerRadius = 4.0
        ResetPwTextfield.clearButtonMode = .always // 한번에 지우기
        
        ResetIdTextfield.delegate = self
        ResetPwTextfield.delegate = self
        
        textFieldDidBeginEditing(ResetIdTextfield)
        textFieldDidEndEditing(ResetIdTextfield)
        textFieldDidBeginEditing(ResetPwTextfield)
        textFieldDidEndEditing(ResetPwTextfield)
    }
    
    //작성 중 주황색
   func textFieldDidBeginEditing(_ textField: UITextField) {
          // textField.borderStyle = .line
       textField.layer.borderColor = UIColor(red: 255/255, green: 77/255, blue: 21/255, alpha: 1).cgColor//your color
           textField.layer.borderWidth = 1.0
   }

   func textFieldDidEndEditing(_ textField: UITextField) {
           textField.layer.borderColor = UIColor.gray.cgColor
           textField.layer.borderWidth = 1.0
   }


}
