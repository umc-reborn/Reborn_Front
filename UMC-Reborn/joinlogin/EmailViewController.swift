//
//  EmailViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/01/28.
//

import UIKit

//extension FrontCardCreationCollectionViewCell: UITextFieldDelegate {
//    // ✅ textField 에서 편집을 시작한 후
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        // 키보드 업
//        textField.becomeFirstResponder()
//        // 입력 시 textField 를 강조하기 위한 테두리 설정
//        textField.borderWidth = 1
//        textField.borderColor = Colors.white.color
//    }
//
//}

class EmailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    
    @IBOutlet weak var ProgressView3: UIProgressView!
    
    
    @IBOutlet weak var nextbuttonEmail: UIButton!
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var codeTextField: UITextField!
    
    @IBOutlet weak var requestButton: UIButton!
    
    @IBOutlet weak var requestCheckButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //뒤로가기 한글 삭제
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        
        
        //progressView3
        ProgressView3.progressViewStyle = .default
        ProgressView3.progressTintColor = .myorange
        ProgressView3.progress = 0.5
        
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
        let mybrown = UIColor(named: "mybrown")
        let myorange = UIColor(named: "myorange")
        let mygray = UIColor(named: "mygray")
        
        // 다음 버튼
        nextbuttonEmail.layer.borderWidth = 1.0
        nextbuttonEmail.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        nextbuttonEmail.layer.cornerRadius = 4.0
        nextbuttonEmail.setTitle("다음", for: .normal)  // 버튼 텍스트 설정
        nextbuttonEmail.setTitleColor(UIColor.mybrown, for: .normal)//버튼 텍스트 색상 설정
        nextbuttonEmail.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_bold", size: 16) //폰트 및 사이즈 설정
        
//        EmailTextField.addLeftPadding()
        EmailTextField.placeholder = "이메일을 입력해 주세요"
        EmailTextField.backgroundColor = .white
        EmailTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        EmailTextField.keyboardType = .asciiCapable // only english
        EmailTextField.textColor = .black
        EmailTextField.layer.borderWidth = 1.0 // 두께
        EmailTextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
        EmailTextField.layer.cornerRadius = 4.0
        EmailTextField.clearButtonMode = .always // 한번에 지우기
        
//        codeTextField.addLeftPadding()
        codeTextField.placeholder = "인증번호를 입력해주세요"
        codeTextField.backgroundColor = .white
        codeTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        codeTextField.keyboardType = .numberPad
        codeTextField.textColor = .black
        codeTextField.layer.borderWidth = 1.0 // 두께
        codeTextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
        codeTextField.layer.cornerRadius = 4.0
        codeTextField.clearButtonMode = .always // 한번에 지우기
        
        EmailTextField.delegate = self
        codeTextField.delegate = self
        textFieldDidBeginEditing(EmailTextField)
        textFieldDidEndEditing(EmailTextField)
        textFieldDidBeginEditing(codeTextField)
        textFieldDidEndEditing(codeTextField)
        
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

