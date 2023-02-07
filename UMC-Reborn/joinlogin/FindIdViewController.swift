//
//  FindIdViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/01.
//

import UIKit

class FindIdViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    
    @IBOutlet weak var FindIdTextField: UITextField!
    
    
    @IBOutlet weak var FindIdNextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mybrown = UIColor(named: "mybrown")
        let myorange = UIColor(named: "myorange")
        let mygray = UIColor(named: "mygray")
        
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
        
        // back button custom
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        
        
        FindIdNextButton.layer.borderWidth = 1.0
        FindIdNextButton.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        FindIdNextButton.layer.cornerRadius = 4.0
        FindIdNextButton.setTitle("다음", for: .normal)  // 버튼 텍스트 설정

        FindIdNextButton.setTitleColor(UIColor.mybrown, for: .normal)//버튼 텍스트 색상 설정

        FindIdNextButton.titleLabel?.font = UIFont(name: "AppleSDGothic_bold", size: 16) //폰트 및 사이즈 설정
        
        
        FindIdTextField.addLeftPadding1()
        FindIdTextField.placeholder = "아이디를 입력해 주세요"
        FindIdTextField.backgroundColor = .white
        FindIdTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        FindIdTextField.keyboardType = .asciiCapable // only english
        FindIdTextField.textColor = .black
        FindIdTextField.layer.borderWidth = 1.0 // 두께
        FindIdTextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
        FindIdTextField.layer.cornerRadius = 4.0
        FindIdTextField.clearButtonMode = .always // 한번에 지우기
        
        FindIdTextField.delegate = self
        textFieldDidBeginEditing(FindIdTextField)
        textFieldDidEndEditing(FindIdTextField)
        
        
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
