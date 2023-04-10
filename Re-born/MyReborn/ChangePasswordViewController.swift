//
//  ChangePasswordViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/02/02.
//

import UIKit

class ChangePasswordViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var oldPwdTextField: UITextField!
    @IBOutlet weak var newPwdTextField: UITextField!
    @IBOutlet weak var confirmNewPwdTextField: UITextField!
    
    let userIdx = UserDefaults.standard.integer(forKey: "userIndex")
    
    let userJWT = UserDefaults.standard.string(forKey: "userJwt")!
    
    var rebornData: PwChangeresultModel!
    
    @IBAction func conFirmPwdButton(_ sender: Any) {
        // ================ < 비밀번호 유효성 검사 > ================
        // 기존 비밀번호
        if let oldPassword = oldPwdTextField.text {
            // 공백 입력 시
            if oldPassword == "" {
                UtilityFunctions().simpleAlert(vc: self, title: "입력 오류", message: "비밀번호를 확인해주세요")
            } else {
                // 비밀번호 유효성 틀릴 시
                if !oldPassword.isValidPassword(password: oldPassword) {
                    UtilityFunctions().simpleAlert(vc: self, title: "입력 오류", message: "8자 이상의 영문 대소문자, 숫자, 특수문자를 사용하세요.")
                }
            }
        }
        // 새 비밀번호
        if let newPassword = confirmNewPwdTextField.text {
            // 공백 입력 시
            if newPassword == "" {
                UtilityFunctions().simpleAlert(vc: self, title: "입력 오류", message: "비밀번호를 확인해주세요")
            } else {
                // 비밀번호 유효성 틀릴 시
                if !newPassword.isValidPassword(password: newPassword) {
                    UtilityFunctions().simpleAlert(vc: self, title: "입력 오류", message: "8자 이상의 영문 대소문자, 숫자, 특수문자를 사용하세요.")
                }
            }
        }
        // 비밀번호 확인
        if let confirmPassword = newPwdTextField.text {
            // 공백 입력 시
            if confirmPassword != confirmNewPwdTextField.text {
                UtilityFunctions().simpleAlert(vc: self, title: "입력 오류", message: "새로운 비밀번호가 일치하지 않습니다")
            }
        }
        
        // TODO : - 로그인 뷰로 넘기기
        // =======================================================
        
        let parameterDatas = PwChangeModel(userIdx: self.userIdx, userPwd: oldPwdTextField.text ?? "", userNewPwd: newPwdTextField.text ?? "", userNewPwd2: confirmNewPwdTextField.text ?? "")
        APIHandlerPwPost.instance.SendingPostReborn(token: userJWT , parameters: parameterDatas) { result in self.rebornData = result }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
            if (self.rebornData.code == 2111) {
                    UtilityFunctions().simpleAlert(vc: self, title: "입력 오류", message: "새로운 비밀번호가 일치하지 않습니다")
                
            } else {
                let goLogin = UIStoryboard.init(name: "JoinLogin", bundle: nil)
                guard let rvc = goLogin.instantiateViewController(withIdentifier: "FirstLoginViewController") as? FirstLoginViewController else {return}
                rvc.modalPresentationStyle = .fullScreen
                self.present(rvc, animated: false, completion: nil)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "비밀번호 변경"
        
        oldPwdTextField.delegate = self
        newPwdTextField.delegate = self
        confirmNewPwdTextField.delegate = self
        
        
        oldPwdTextField.addLeftPadding()
        newPwdTextField.addLeftPadding()
        confirmNewPwdTextField.addLeftPadding()
        
        newPwdTextField.layer.borderWidth = 1.0
        newPwdTextField.layer.cornerRadius = 4
        newPwdTextField.layer.borderColor = UIColor.darkGray.cgColor
        
        oldPwdTextField.layer.borderWidth = 1.0
        oldPwdTextField.layer.cornerRadius = 4
        oldPwdTextField.layer.borderColor = UIColor.darkGray.cgColor
        
        confirmNewPwdTextField.layer.borderWidth = 1.0
        confirmNewPwdTextField.layer.cornerRadius = 4
        confirmNewPwdTextField.layer.borderColor = UIColor.darkGray.cgColor
        
        // 텍스트 필드 컬러
        textFieldDidBeginEditing(newPwdTextField)
        textFieldDidBeginEditing(oldPwdTextField)
        textFieldDidBeginEditing(confirmNewPwdTextField)
        
        textFieldDidEndEditing(newPwdTextField)
        textFieldDidEndEditing(oldPwdTextField)
        textFieldDidEndEditing(confirmNewPwdTextField)
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


extension UITextField {
    // textField 왼쪽에 padding값 설정
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}

// 비밀번호 유효성 검사
extension String {
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"
        
                let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
                return predicate.evaluate(with: self)
    }
}
