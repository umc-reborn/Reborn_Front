//
//  PWChangeViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/27.
//

import UIKit

class PWChangeViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var pwChange = UserDefaults.standard.integer(forKey: "userIdx")
    var pwToken = UserDefaults.standard.string(forKey: "shopJwt")
    
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var newpwTextField: UITextField!
    @IBOutlet weak var newokTextField: UITextField!
    @IBOutlet weak var pwErrorLabel: UILabel!
    @IBOutlet weak var pwokErrorLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    var rebornData: PwChangeresultModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 5
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1).cgColor
        pwTextField.layer.cornerRadius = 5
        pwTextField.layer.borderWidth = 1
        pwTextField.layer.borderColor = UIColor.gray.cgColor
        newpwTextField.layer.cornerRadius = 5
        newpwTextField.layer.borderWidth = 1
        newpwTextField.layer.borderColor = UIColor.gray.cgColor
        newokTextField.layer.cornerRadius = 5
        newokTextField.layer.borderWidth = 1
        newokTextField.layer.borderColor = UIColor.gray.cgColor

        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
        
        pwTextField.delegate = self
        newpwTextField.delegate = self
        newokTextField.delegate = self
        textFieldDidBeginEditing(pwTextField)
        textFieldDidEndEditing(pwTextField)
        textFieldDidBeginEditing(newpwTextField)
        textFieldDidEndEditing(newpwTextField)
        textFieldDidBeginEditing(newokTextField)
        textFieldDidEndEditing(newokTextField)
        
        newpwTextField.addTarget(self, action: #selector(textFieldEdited), for: .editingChanged)
        newokTextField.addTarget(self, action: #selector(textFieldEdited), for: .editingChanged)
    }
    
    @objc func textFieldEdited(textField: UITextField) {
            
        if (textField == newpwTextField) {
            if isValidPw(testStr: textField.text) {
                pwErrorLabel.text = ""
            }
            else {
                pwErrorLabel.text = "8~16자 영문 대소문자, 숫자, 특수문자를 사용하세요."
                nextButton.backgroundColor = .white
            }
        }
        else if (newpwTextField.text == newokTextField.text) {
            pwokErrorLabel.text = ""
            nextButton.setTitleColor(.white, for: .normal)
            nextButton.setTitleColor(.white, for: .selected)
            nextButton.backgroundColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1)
        }
        else {
            pwokErrorLabel.text = "비밀번호가 일치하지 않습니다."
            nextButton.backgroundColor = .white
        }
        
        UIView.animate(withDuration: 0.1) { // 효과 주기
                self.view.layoutIfNeeded()
        }
    }
    
    func isValidPw(testStr: String?) -> Bool{
        let regex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[\\d])(?=.*[~!@#\\$%\\^&\\*])[\\w~!@#\\$%\\^&\\*]{8,16}$"
        
        let pwTest = NSPredicate(format:"SELF MATCHES %@", regex)
        return pwTest.evaluate(with: testStr)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 255/255, green: 77/255, blue: 21/255, alpha: 1).cgColor//your color
        textField.layer.borderWidth = 1.0
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1.0
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pwnextButton(_ sender: Any) {
        let parameterDatas = PwChangeModel(userIdx: pwChange, userPwd: pwTextField.text ?? "", userNewPwd: newpwTextField.text ?? "", userNewPwd2: newokTextField.text ?? "")
        APIHandlerPwPost.instance.SendingPostReborn(token: pwToken ?? "", parameters: parameterDatas) { result in self.rebornData = result }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
            if (self.rebornData.code == 2111) {
                guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "PwErrorViewController") as? PwErrorViewController else { return }
                nextVC.modalPresentationStyle = .overFullScreen
                self.present(nextVC, animated: false, completion: nil)
            } else {
                guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "PwOkViewController") as? PwOkViewController else { return }
                nextVC.modalPresentationStyle = .overFullScreen
                self.present(nextVC, animated: false, completion: nil)
            }
        }
    }
}
