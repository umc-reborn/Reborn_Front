//
//  ShopLoginViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/01/23.
//

import UIKit


extension UITextField {
//  func addLeftPadding() {
//    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
//    self.leftView = paddingView
//    self.leftViewMode = ViewMode.always
//  }
}



class ShopLoginViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var IdSecond: UITextField!
    
    
    @IBOutlet weak var PassWordSecond: UITextField!
    
    @IBOutlet weak var errorLabel2: UILabel!
    
    
    @IBOutlet weak var LoginButtonSecond: UIButton!
    
    
    //API
    var trainDataa : ShopModel!
    var storeText : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel2.isHidden = true
        
        
        let mygray = UIColor(named: "mygray") // 만들어둔 컬러 쓰려면 선언 먼저
        let mybrown = UIColor(named: "mybrown")
        
        
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
        
        IdSecond.addLeftPadding()
        IdSecond.placeholder = "아이디를 입력해 주세요"
        IdSecond.backgroundColor = .white
        IdSecond.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        IdSecond.keyboardType = .asciiCapable // only english
        IdSecond.textColor = .black
        IdSecond.layer.borderWidth = 1.0 // 두께
        IdSecond.layer.borderColor = mygray?.cgColor // 테두리 컬러
        IdSecond.layer.cornerRadius = 4.0
        IdSecond.clearButtonMode = .always // 한번에 지우기
        
        
        PassWordSecond.addLeftPadding()
        PassWordSecond.placeholder = "비밀번호를 입력해 주세요"
        PassWordSecond.backgroundColor = .white
        PassWordSecond.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        PassWordSecond.keyboardType = .asciiCapable // only english
        PassWordSecond.textColor = .black
        PassWordSecond.isSecureTextEntry = true // 비밀번호 안보이게
        PassWordSecond.layer.borderWidth = 1.0 // 두께
        PassWordSecond.layer.borderColor = mygray?.cgColor // 테두리 컬러
        PassWordSecond.layer.cornerRadius = 4.0
        PassWordSecond.clearButtonMode = .always // 한번에 지우기
        
        self.LoginButtonSecond.setTitle("로그인", for: .normal)
        LoginButtonSecond.setTitleColor(.white, for: .normal)
        LoginButtonSecond.backgroundColor = .mybrown
        LoginButtonSecond.layer.borderWidth = 1.0
        LoginButtonSecond.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        LoginButtonSecond.layer.cornerRadius = 4.0
        // 폰트는 코드로 안함

        
        IdSecond.delegate = self
        PassWordSecond.delegate = self
        textFieldDidBeginEditing(IdSecond)
        textFieldDidEndEditing(IdSecond)
        textFieldDidBeginEditing(PassWordSecond)
        textFieldDidEndEditing(PassWordSecond)
        
        LoginButtonSecond.addTarget(self, action: #selector(textFieldEdited), for: .touchUpInside)
        
    }
    
    @objc func textFieldEdited(textField: UITextField) {
        
        if (IdSecond.text!.isEmpty) || (PassWordSecond.text!.isEmpty){
            errorLabel2.isHidden = false
            errorLabel2.text = "아이디 또는 비밀번호를 잘못 입력하셨습니다."
            //LoginButton.isEnabled = false
            
        }
//        else if (Id.text!.isEmpty) && (PassWord.text!.isEmpty){
//            errorMessage.isHidden = true
//            errorMessage.text = ""
//        }
        else {
            errorLabel2.isHidden = true
            errorLabel2.text = ""
            //LoginButton.isEnabled = true
        }
        
        UIView.animate(withDuration: 0.1) { // 효과 주기
            self.view.layoutIfNeeded()
        }
        
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
    
     //로그인 버튼 누르면 api 넘기는 것
    @IBAction func LoginButtonSecond(_ sender: Any) {
        let pparmeterData = Model2(userId: IdSecond.text ?? "", userPwd: PassWordSecond.text ?? "")
        print(pparmeterData)
        APIShopLoginPost.instance.SendingPostShopLogin(parameters1: pparmeterData) { result1 in self.trainDataa =  result1 }
        
        let something5 = trainDataa?.result
        guard let text33 = something5?.storeIdx else {return}
        let something4 = UIStoryboard.init(name: "StoreTab", bundle: nil)
        guard let rvc1 = something4.instantiateViewController(withIdentifier: "StoreTabBarController") as? StoreTabBarController else {return}
        
        rvc1.storeText = text33
        
        // 화면이동
        self.present(rvc1, animated: true)
    }
    
}
