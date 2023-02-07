//
//  NeighborViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/01/30.
//

import UIKit



extension UITextField {
  func addLeftPadding1() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}


class NeighborViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBOutlet weak var Id: UITextField!
    
    @IBOutlet weak var PassWord: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    
    //var trainData: [TrainModel]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        //MARK: - API
//        //Method Calling
//        let pparmeterData = Model(nId: "tester11@email.com", nPw: "Password1234!")
//
//        APIHandlerr.instance.SendingPostRequest(parameters: pparmeterData) {result in
//            self.trainData = result
//        }
        
        
        //MARK: - ...
        let mygray = UIColor(named: "mygray") // 만들어둔 컬러 쓰려면 선언 먼저
        let mybrown = UIColor(named: "mybrown")
        
        
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
        
        Id.addLeftPadding1()
        Id.placeholder = "아이디를 입력해 주세요"
        Id.backgroundColor = .white
        Id.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        Id.keyboardType = .asciiCapable // only english
        Id.textColor = .black
        Id.layer.borderWidth = 1.0 // 두께
        Id.layer.borderColor = mygray?.cgColor // 테두리 컬러
        Id.layer.cornerRadius = 4.0
        Id.clearButtonMode = .always // 한번에 지우기
      
        
        PassWord.addLeftPadding1()
        PassWord.placeholder = "비밀번호를 입력해 주세요"
        PassWord.backgroundColor = .white
        PassWord.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        PassWord.keyboardType = .asciiCapable // only english
        PassWord.textColor = .black
        PassWord.isSecureTextEntry = true // 비밀번호 안보이게
        PassWord.layer.borderWidth = 1.0 // 두께
        PassWord.layer.borderColor = mygray?.cgColor // 테두리 컬러
        PassWord.layer.cornerRadius = 4.0
        PassWord.clearButtonMode = .always // 한번에 지우기
        
        
        LoginButton.backgroundColor = .mybrown
        LoginButton.layer.borderWidth = 1.0
        LoginButton.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        LoginButton.layer.cornerRadius = 4.0
        // 폰트는 코드로 안함
        
        Id.delegate = self
        PassWord.delegate = self
        textFieldDidBeginEditing(Id)
        textFieldDidEndEditing(Id)
        textFieldDidBeginEditing(PassWord)
        textFieldDidEndEditing(PassWord)
              
//        Id.addTarget(self, action: #selector(textFieldEdited), for: .editingChanged)
//        PassWord.addTarget(self, action: #selector(textFieldEdited), for: .editingChanged)
   }
    
//    @objc func textFieldEdited(textField: UITextField) {
//
//            if (Id == myId) && (PassWord == myPassWord){
//                if isValidLogin(testStr: textField.text) {
//                    errorMessage.text = ""
//                }
//                else {
//                    errorMessage.text = "아이디 또는 비밀번호를 잘못 입력하셨습니다."
//                }
//            }
//        else{
//            errorMessage.text = ""
//        }
//            UIView.animate(withDuration: 0.1) {
//                    self.view.layoutIfNeeded()
//            }
//        }
// pw 정규표현식
    func isValidLogin(testStr: String?) -> Bool{
           let regex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,16}"
           
           let pwTest = NSPredicate(format:"SELF MATCHES %@", regex)
           return pwTest.evaluate(with: testStr)
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

