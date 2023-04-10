//
//  Id_PassWordSecondViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/03.
//

import UIKit

class Id_PassWordSecondViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    
    @IBOutlet weak var PgIdPw: UIProgressView!
    
    
    @IBOutlet var idddtextField: UITextField! // id
    
    @IBOutlet var dddCheckButton: UIButton! // id 중복확인
    
    @IBOutlet var pppTextifield: UITextField! // 비밀번호
    
    @IBOutlet var dCheckPwTextField: UITextField! // 비밀번호 중복확인
    
    @IBOutlet var daum1Button: UIButton! // 다음 버튼
    
    override func viewDidLoad() {
        super.viewDidLoad()


        let mybrown = UIColor(named: "mybrown")
        let myorange = UIColor(named: "myorange")
        let mygray = UIColor(named: "mygray")
        
        //progressview PgIdPw
        PgIdPw.progressViewStyle = .default
        PgIdPw.progressTintColor = .myorange
        PgIdPw.progress = 0.66
        
        // back button custom
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        
        
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
        
        // 다음버튼
        daum1Button.layer.borderWidth = 1.0
        daum1Button.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        daum1Button.layer.cornerRadius = 4.0
        daum1Button.setTitle("다음", for: .normal)  // 버튼 텍스트 설정
        daum1Button.setTitleColor(UIColor.mybrown, for: .normal)//버튼 텍스트 색상 설정
        daum1Button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 18) //폰트 및 사이즈 설정
        
        // 중복확인버튼
        dddCheckButton.layer.borderWidth = 1.0
        dddCheckButton.layer.borderColor = myorange?.cgColor // 테두리 컬러
        dddCheckButton.backgroundColor = .myorange
        dddCheckButton.layer.cornerRadius = 4.0
        dddCheckButton.setTitle("중복확인", for: .normal)  // 버튼 텍스트 설정
        dddCheckButton.setTitleColor(UIColor.white, for: .normal)//버튼 텍스트 색상 설정
        dddCheckButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 15) //폰트 및 사이즈 설정
        
        
        // 아이디
        idddtextField.delegate = self
        textFieldDidBeginEditing(idddtextField)
        textFieldDidEndEditing(idddtextField)
        
        // 비밀번호
        pppTextifield.delegate = self
        textFieldDidBeginEditing(pppTextifield)
        textFieldDidEndEditing(pppTextifield)
        
        //비밀번호 확인
        dCheckPwTextField.delegate = self
        textFieldDidBeginEditing(dCheckPwTextField)
        textFieldDidEndEditing(dCheckPwTextField)
        
        
        //아이디
        idddtextField.addLeftPadding1()
        idddtextField.placeholder = "4~16자 영문, 숫자를 사용하세요"
        idddtextField.backgroundColor = .white
        idddtextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        idddtextField.keyboardType = .asciiCapable // only english
        idddtextField.textColor = .black
        idddtextField.layer.borderWidth = 1.0 // 두께
        idddtextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
        idddtextField.layer.cornerRadius = 4.0
        idddtextField.clearButtonMode = .always // 한번에 지우기
        
        //비밀번호
        pppTextifield.addLeftPadding1()
        pppTextifield.placeholder = "8~16자 영문 대소문자, 숫자, 특수문자를 사용하세요"
        pppTextifield.backgroundColor = .white
        pppTextifield.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        pppTextifield.keyboardType = .asciiCapable // only english
        pppTextifield.textColor = .black
        pppTextifield.layer.borderWidth = 1.0 // 두께
        pppTextifield.layer.borderColor = mygray?.cgColor // 테두리 컬러
        pppTextifield.layer.cornerRadius = 4.0
        pppTextifield.clearButtonMode = .always // 한번에 지우기
        
        //비밀번호확인
        dCheckPwTextField.addLeftPadding1()
        dCheckPwTextField.placeholder = "비밀번호를 한 번 더 입력해 주세요"
        dCheckPwTextField.backgroundColor = .white
        dCheckPwTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        dCheckPwTextField.keyboardType = .asciiCapable // only english
        dCheckPwTextField.textColor = .black
        dCheckPwTextField.layer.borderWidth = 1.0 // 두께
        dCheckPwTextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
        dCheckPwTextField.layer.cornerRadius = 4.0
        dCheckPwTextField.clearButtonMode = .always // 한번에 지우기
        
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
