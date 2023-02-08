//
//  Id_PassWordViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/01.
//

import UIKit

class Id_PassWordViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var ProgressView4: UIProgressView!

    @IBOutlet weak var setIdTextField: UITextField!
    @IBOutlet weak var doubleCheckButton: UIButton!
    @IBOutlet weak var setPwTextField: UITextField!
    @IBOutlet weak var doubleCheckTextField: UITextField!
    @IBOutlet weak var nextButton5: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let mybrown = UIColor(named: "mybrown")
        let myorange = UIColor(named: "myorange")
        let mygray = UIColor(named: "mygray")
        
        // back button custom
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        
        
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
        //progressView4
        ProgressView4.progressViewStyle = .default
        ProgressView4.progressTintColor = .myorange
        ProgressView4.progress = 0.66
        
        // 다음버튼
        nextButton5.layer.borderWidth = 1.0
        nextButton5.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        nextButton5.layer.cornerRadius = 4.0
        nextButton5.setTitle("다음", for: .normal)  // 버튼 텍스트 설정
        nextButton5.setTitleColor(UIColor.mybrown, for: .normal)//버튼 텍스트 색상 설정
        nextButton5.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 18) //폰트 및 사이즈 설정
        
        // 중복확인버튼
        doubleCheckButton.layer.borderWidth = 1.0
        doubleCheckButton.layer.borderColor = myorange?.cgColor // 테두리 컬러
        doubleCheckButton.backgroundColor = .myorange
        doubleCheckButton.layer.cornerRadius = 4.0
        doubleCheckButton.setTitle("중복확인", for: .normal)  // 버튼 텍스트 설정
        doubleCheckButton.setTitleColor(UIColor.white, for: .normal)//버튼 텍스트 색상 설정
        doubleCheckButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 15) //폰트 및 사이즈 설정
        
        // 아이디
        setIdTextField.delegate = self
        textFieldDidBeginEditing(setIdTextField)
        textFieldDidEndEditing(setIdTextField)
        
        // 비밀번호
        setPwTextField.delegate = self
        textFieldDidBeginEditing(setPwTextField)
        textFieldDidEndEditing(setPwTextField)
        
        //비밀번호 확인
        doubleCheckTextField.delegate = self
        textFieldDidBeginEditing(doubleCheckTextField)
        textFieldDidEndEditing(doubleCheckTextField)
        
        
        //아이디
//        setIdTextField.addLeftPadding()
        setIdTextField.placeholder = "4~16자 영문, 숫자를 사용하세요"
        setIdTextField.backgroundColor = .white
        setIdTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        setIdTextField.keyboardType = .asciiCapable // only english
        setIdTextField.textColor = .black
        setIdTextField.layer.borderWidth = 1.0 // 두께
        setIdTextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
        setIdTextField.layer.cornerRadius = 4.0
        setIdTextField.clearButtonMode = .always // 한번에 지우기
        
        //비밀번호
//        setPwTextField.addLeftPadding()
        setPwTextField.placeholder = "8~16자 영문 대소문자, 숫자, 특수문자를 사용하세요"
        setPwTextField.backgroundColor = .white
        setPwTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        setPwTextField.keyboardType = .asciiCapable // only english
        setPwTextField.textColor = .black
        setPwTextField.layer.borderWidth = 1.0 // 두께
        setPwTextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
        setPwTextField.layer.cornerRadius = 4.0
        setPwTextField.clearButtonMode = .always // 한번에 지우기
        
        //비밀번호확인
//        doubleCheckTextField.addLeftPadding()
        doubleCheckTextField.placeholder = "비밀번호를 한 번 더 입력해 주세요"
        doubleCheckTextField.backgroundColor = .white
        doubleCheckTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        doubleCheckTextField.keyboardType = .asciiCapable // only english
        doubleCheckTextField.textColor = .black
        doubleCheckTextField.layer.borderWidth = 1.0 // 두께
        doubleCheckTextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
        doubleCheckTextField.layer.cornerRadius = 4.0
        doubleCheckTextField.clearButtonMode = .always // 한번에 지우기
        
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
