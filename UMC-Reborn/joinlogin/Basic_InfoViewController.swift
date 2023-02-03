//
//  Basic_InfoViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/01.
//

import UIKit

class Basic_InfoViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var ProgressView5: UIProgressView!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var townTextField: UITextField!
    @IBOutlet weak var BDTextField: UITextField!
    @IBOutlet weak var BasicNextButton: UIButton!
    
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
        
        //progressView5
        ProgressView5.progressViewStyle = .default
        ProgressView5.progressTintColor = .myorange
        ProgressView5.progress = 0.83
        
        
        // 다음버튼
        BasicNextButton.layer.borderWidth = 1.0
        BasicNextButton.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        BasicNextButton.layer.cornerRadius = 4.0
        BasicNextButton.setTitle("다음", for: .normal)  // 버튼 텍스트 설정
        BasicNextButton.setTitleColor(UIColor.mybrown, for: .normal)//버튼 텍스트 색상 설정
        BasicNextButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 18) //폰트 및 사이즈 설정
        
        // 닉네임
        nickNameTextField.delegate = self
        textFieldDidBeginEditing(nickNameTextField)
        textFieldDidEndEditing(nickNameTextField)
        
        
        // 동네설정
        townTextField.delegate = self
        textFieldDidBeginEditing(townTextField)
        textFieldDidEndEditing(townTextField)
        
        // 생년월일
        BDTextField.delegate = self
        textFieldDidBeginEditing(BDTextField)
        textFieldDidEndEditing(BDTextField)
        
        //닉네임
        nickNameTextField.addLeftPadding()
        nickNameTextField.placeholder = "띄어쓰기 없이 2~12자 이내로 입력해 주세요"
        nickNameTextField.backgroundColor = .white
        nickNameTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)

        nickNameTextField.textColor = .black
        nickNameTextField.layer.borderWidth = 1.0 // 두께
        nickNameTextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
        nickNameTextField.layer.cornerRadius = 4.0
        nickNameTextField.clearButtonMode = .always // 한번에 지우기
        
    
        //동네설정
        townTextField.addLeftPadding()
        townTextField.placeholder = "비밀번호를 한 번 더 입력해 주세요"
        townTextField.backgroundColor = .white
        townTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        townTextField.textColor = .black
        townTextField.layer.borderWidth = 1.0 // 두께
        townTextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
       townTextField.layer.cornerRadius = 4.0
//        townTextField.clearButtonMode = .always // 한번에 지우기
        
        //생년월일
        BDTextField.addLeftPadding()
        BDTextField.placeholder = "YYYY/MM/DD"
        BDTextField.backgroundColor = .white
        BDTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        BDTextField.textColor = .black
        BDTextField.layer.borderWidth = 1.0 // 두께
        BDTextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
        BDTextField.layer.cornerRadius = 4.0
        
        
        
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
