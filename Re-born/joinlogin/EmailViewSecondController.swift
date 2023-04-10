//
//  EmailViewSecondController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/03.
//

import UIKit

class EmailViewSecondController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var Pgemail: UIProgressView!
    
    @IBOutlet var emtextfield: UITextField! // 이메일 텍스트필드
    
    @IBOutlet var numtextfield: UITextField! // 인증번호 텍스트필드
    
    @IBOutlet var emailbutton1: UIButton! // 인증 요청 버튼
    
    @IBOutlet var emailbutton2: UIButton! // 인증 확인 버튼
    
    @IBOutlet var daumbutton: UIButton! // 다음 버튼
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Pgemail.progressViewStyle = .default
        Pgemail.progressTintColor = .myorange
        Pgemail.progress = 0.5
        
        //뒤로가기 한글 삭제
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
        let mybrown = UIColor(named: "mybrown")
        let myorange = UIColor(named: "myorange")
        let mygray = UIColor(named: "mygray")
        
        
        // 다음 버튼
        daumbutton.layer.borderWidth = 1.0
        daumbutton.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        daumbutton.layer.cornerRadius = 4.0
        daumbutton.setTitle("다음", for: .normal)  // 버튼 텍스트 설정
        daumbutton.setTitleColor(UIColor.mybrown, for: .normal)//버튼 텍스트 색상 설정
        daumbutton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_bold", size: 16) //폰트 및 사이즈 설정
        
        // 이메일 텍스트필드
        emtextfield.addLeftPadding1()
        emtextfield.placeholder = "이메일을 입력해 주세요"
        emtextfield.backgroundColor = .white
        emtextfield.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        emtextfield.keyboardType = .asciiCapable // only english
        emtextfield.textColor = .black
        emtextfield.layer.borderWidth = 1.0 // 두께
        emtextfield.layer.borderColor = mygray?.cgColor // 테두리 컬러
        emtextfield.layer.cornerRadius = 4.0
        emtextfield.clearButtonMode = .always // 한번에 지우기
        
        // 인증번호 텍스트필드
        numtextfield.addLeftPadding1()
        numtextfield.placeholder = "인증번호를 입력해주세요"
        numtextfield.backgroundColor = .white
        numtextfield.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        numtextfield.keyboardType = .numberPad
        numtextfield.textColor = .black
        numtextfield.layer.borderWidth = 1.0 // 두께
        numtextfield.layer.borderColor = mygray?.cgColor // 테두리 컬러
        numtextfield.layer.cornerRadius = 4.0
        numtextfield.clearButtonMode = .always // 한번에 지우기
        
        
        // 인증요청버튼
        emailbutton1.layer.borderWidth = 1.0
        emailbutton1.layer.borderColor = myorange?.cgColor // 테두리 컬러
        emailbutton1.backgroundColor = .myorange
        emailbutton1.layer.cornerRadius = 4.0
        emailbutton1.setTitle("인증요청", for: .normal)  // 버튼 텍스트 설정
        emailbutton1.setTitleColor(UIColor.white, for: .normal)//버튼 텍스트 색상 설정
        emailbutton1.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 15) //폰트 및 사이즈 설정
        
        // 인증확인버튼
        emailbutton2.layer.borderWidth = 1.0
        emailbutton2.layer.borderColor = myorange?.cgColor // 테두리 컬러
        emailbutton2.backgroundColor = .myorange
        emailbutton2.layer.cornerRadius = 4.0
        emailbutton2.setTitle("인증확인", for: .normal)  // 버튼 텍스트 설정
        emailbutton2.setTitleColor(UIColor.white, for: .normal)//버튼 텍스트 색상 설정
        emailbutton2.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 15) //폰트 및 사이즈 설정
        
        
        emtextfield.delegate = self
        numtextfield.delegate = self
        textFieldDidBeginEditing(emtextfield)
        textFieldDidEndEditing(emtextfield)
        textFieldDidBeginEditing(numtextfield)
        textFieldDidEndEditing(numtextfield)
        
        
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
