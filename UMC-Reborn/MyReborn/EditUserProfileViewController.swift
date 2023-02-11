//
//  EditUserProfileViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/01/18.
//

import UIKit

class EditUserProfileViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet var EditNicknameTextField: UITextField!
    @IBOutlet var EditAddressTextField: UITextField!
    @IBOutlet var EditBirthTextField: UITextField!
    
    
    @objc func FinishEditMode() {
        // TODO : (일단 닉네임이라도) 변경한 값으로 만들기
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션 바
        self.navigationItem.title = "회원정보 수정"
        self.navigationItem.backButtonDisplayMode = .minimal
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(FinishEditMode))
        self.navigationItem.rightBarButtonItem?.tintColor = .init(named: "MainColor")
        
        // 텍스트 필드
        EditNicknameTextField.delegate = self
        EditAddressTextField.delegate = self
        EditBirthTextField.delegate = self
        
        EditNicknameTextField.addLeftPadding()
        EditAddressTextField.addLeftPadding()
        EditBirthTextField.addLeftPadding()
        
        EditNicknameTextField.layer.borderWidth = 1.0
        EditNicknameTextField.layer.cornerRadius = 4
        EditNicknameTextField.layer.borderColor = UIColor.darkGray.cgColor
        
        EditAddressTextField.layer.borderWidth = 1.0
        EditAddressTextField.layer.cornerRadius = 4
        EditAddressTextField.layer.borderColor = UIColor.darkGray.cgColor
        
        EditBirthTextField.layer.borderWidth = 1.0
        EditBirthTextField.layer.cornerRadius = 4
        EditBirthTextField.layer.borderColor = UIColor.darkGray.cgColor
        
        // 텍스트 필드 컬러
        textFieldDidBeginEditing(EditNicknameTextField)
        textFieldDidBeginEditing(EditAddressTextField)
        textFieldDidBeginEditing(EditBirthTextField)
        
        textFieldDidEndEditing(EditNicknameTextField)
        textFieldDidEndEditing(EditAddressTextField)
        textFieldDidEndEditing(EditBirthTextField)
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

