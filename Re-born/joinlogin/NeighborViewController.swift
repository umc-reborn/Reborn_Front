//
//  NeighborViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/01/30.
//
import Foundation
import UIKit

//바탕 터치하거나 리턴 누르면 키보드 내려감, 텍스트필드.delegate = self 필요
extension NeighborViewController: UITextFieldDelegate {

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // TextField 비활성화
        return true
    }
}

extension UITextField {
  func addLeftPadding1() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}

class NeighborViewController: UIViewController, UITextViewDelegate {
    
    
    
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBOutlet weak var Id: UITextField!
    
    @IBOutlet weak var PassWord: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    
    //        // 뷰의 초기 y 값을 저장해서 뷰가 올라갔는지 내려왔는지에 대한 분기처리시 사용.
    //        private var restoreFrameYValue = 0.0
    //        restoreFrameYValue = self.view.frame.origin.y
    //
    //
    //
    //        // ✅ 키보드 업
    //            @objc func showKeyboard(_ notification: Notification) {
    //        // 키보드가 내려왔을 때만 올린다.
    //                if self.view.frame.origin.y == restoreFrameYValue {
    //                    if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
    //                        let keyboardHeight = keyboardFrame.cgRectValue.height
    //                        self.view.frame.origin.y -= keyboardHeight
    //                        print("show keyboard")
    //                    }
    //                }
    //            }
    //
    //        // ✅ 키보드 다운
    //            @objc
    //            private func hideKeyboard(_ notification: Notification) {
    //        // 키보드가 올라갔을 때만 내린다.
    //                if self.view.frame.origin.y != restoreFrameYValue {
    //                    if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
    //                        let keyboardHeight = keyboardFrame.cgRectValue.height
    //                        self.view.frame.origin.y += keyboardHeight
    //                        print("hide keyboard")
    //                    }
    //                }
    //            }
    //
    //
    //
    //API
    var trainData:TrainModel!
    var userText: Int = 0
    var userNickNameText: String = ""
    var rightHi : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

//        errorMessage.isHidden = true
        errorMessage.text = ""
        
        let mygray = UIColor(named: "mygray") // 만들어둔 컬러 쓰려면 선언 먼저
        let mybrown = UIColor(named: "mybrown")
        
        
        //viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
         self.view.backgroundColor = BACKGROUND
        
        
        Id.addLeftPadding1()
        Id.frame = CGRect(x: 26, y: 82, width: 338, height: 54)
        Id.borderStyle = .none
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
        
        LoginButton.setTitle("로그인", for: .normal)
        LoginButton.setTitleColor(.white, for: .normal)
        LoginButton.backgroundColor = .mybrown
        LoginButton.layer.borderWidth = 1.0
        LoginButton.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        LoginButton.layer.cornerRadius = 4.0
        // 폰트는 코드로 안함
        //LoginButton.userPressedToEnter()
        
        
        Id.delegate = self
        PassWord.delegate = self
        textFieldDidBeginEditing(Id)
        textFieldDidEndEditing(Id)
        textFieldDidBeginEditing(PassWord)
        textFieldDidEndEditing(PassWord)
        
        
//        Id.addTarget(self, action: #selector(textFieldEdited), for: .editingDidEnd)
//        PassWord.addTarget(self, action: #selector(textFieldEdited), for: .editingDidEnd)
        LoginButton.addTarget(self, action: #selector(textFieldEdited), for: .touchUpInside)
        
    }
    
    @objc func textFieldEdited(textField: UITextField) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            if (self.Id.text!.isEmpty) || (self.PassWord.text!.isEmpty){
                self.errorMessage.isHidden = false
                self.errorMessage.text = "아이디 또는 비밀번호를 잘못 입력하셨습니다."
                print("아이디 또는 비밀번호를 잘못 입력하셨습니다.")
                self.LoginButton.isEnabled = true
                self.LoginButton.setTitle("로그인", for: .normal)
                self.LoginButton.setTitleColor(.white, for: .normal)
                
            }
            else if (self.rightHi == ""){
                self.errorMessage.isHidden = false
                self.errorMessage.text = "아이디 또는 비밀번호를 잘못 입력하셨습니다."
                print("아이디 또는 비밀번호를 잘못 입력하셨습니다.")
                    }
            else if (self.rightHi == "요청에 성공하였습니다."){
                self.Id.text = ""
                self.PassWord.text = ""
                print("아이디랑 비밀번호 초기화되길 바라며")
            }
            else {
                self.errorMessage.isHidden = true
                self.errorMessage.text = ""
                self.LoginButton.setTitle("로그인", for: .normal)
                self.LoginButton.setTitleColor(.white, for: .normal)
                //LoginButton.isEnabled = true
            }
            
            UIView.animate(withDuration: 0.1) { // 효과 주기
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
//    @objc func textFieldFailed(textField: UITextField) {
//
//        if(self.rightHi == 3014){
//        self.errorMessage.isHidden = false
//        self.errorMessage.text = "아이디 또는 비밀번호를 잘못 입력하셨습니다."
//        print("아이디 또는 비밀번호를 잘못 입력하셨습니다.")
//        }
//    }
        
        //Id 정규표현식
        //아이디는 2-10자의 영문과 숫자와 일부 특수문자(._-)만 입력 가능
        func isValidLogin(testStr: String?) -> Bool{
            let regex = "/^(?=.*[a-zA-Z])[-a-zA-Z0-9_.]{2,10}$/;"
            
            let pwTest = NSPredicate(format:"SELF MATCHES %@", regex)
            return pwTest.evaluate(with: testStr)
        }
        
        
        //pw 정규표현식
        func isValidPassWord(testStr: String?) -> Bool{
            let regex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,16}"
            
            let pwTest = NSPredicate(format:"SELF MATCHES %@", regex)
            return pwTest.evaluate(with: testStr)
        }
        
        
        
        //작성 중 주황색
        func textFieldDidBeginEditing(_ textField: UITextField) {
            // textField.borderStyle = .line
            textField.layer.borderColor = UIColor(red: 255/255, green: 77/255, blue: 21/255, alpha: 1).cgColor//your color
            textField.layer.borderWidth = 1.0
            errorMessage.isHidden = true
            
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            textField.layer.borderColor = UIColor.gray.cgColor
            textField.layer.borderWidth = 1.0
            errorMessage.isHidden = true
        }
        
        
        // 로그인 버튼 누르면 api 넘기는 것
    @IBAction func LoginButton(_ sender: Any) {
        let pparmeterData = Model1(userId: Id.text ?? "", userPwd: PassWord.text ?? "")
        print(pparmeterData)
        APINeiLoginPost.instance.SendingPostNLogin(parameters: pparmeterData) { result in self.trainData =  result }
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
            
            
            self.rightHi = self.trainData?.message ?? ""
            
            print(self.rightHi)
            
            // 화면 넘기기 + 데이터 넘겨주기.
            let something2 = self.trainData?.result
            guard let text = something2?.userIdx else {return}
            guard let text2 = something2?.userNickname else {return}
            guard let jwtResult = something2?.jwt else {return}
            let something3 = UIStoryboard(name: "PersonalTab", bundle: nil)
            guard let rvc = something3.instantiateViewController(withIdentifier: "PersonalTabVC") as? PersonalTabViewController else {return}
                
                
            rvc.userIdx = text
            rvc.userNickname = text2
            rvc.jwt = jwtResult
                
            // 화면이동
            self.present(rvc, animated: true)
                
            // userDefault - jwt 저장
            UserDefaults.standard.set(jwtResult, forKey: "userJwt")
            
        
            }
        }
    }

 
