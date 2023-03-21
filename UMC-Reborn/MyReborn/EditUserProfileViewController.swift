//
//  EditUserProfileViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/01/18.
//

import UIKit

class EditUserProfileViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var nickname = UserDefaults.standard.string(forKey: "userNickName")
    

    let button1 = UIButton(frame: CGRect(x: 0, y: 0, width: 84, height: 30))
    let button2 = UIButton(frame: CGRect(x: 0, y: 0, width: 84, height: 30))
    let button3 = UIButton(frame: CGRect(x: 0, y: 0, width: 84, height: 30))
    let button4 = UIButton(frame: CGRect(x: 0, y: 0, width: 84, height: 30))
    let button5 = UIButton(frame: CGRect(x: 0, y: 0, width: 84, height: 30))

    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var EditNicknameTextField: UITextField!
    @IBOutlet var EditAddressTextField: UITextField!
    @IBOutlet var EditBirthTextField: UITextField!
    
    
    @objc func FinishEditMode() {
        // TODO : (일단 닉네임이라도) 변경한 값으로 만들기
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton1()
        createButton2()
        createButton3()
        createButton4()
        createButton5()
        
        if button1.isSelected {
            // 1. 저장을 위한 변수 선언(맨 위에)
            // 2. 버튼을 클릭했을 때 1번 변수에 저장(sender.label.text)
            // 3. 클릭했을 때 UI
            // 4. 다른 거를 선택했을 땐 for문을 써서 나머지 버튼 색깔들을 뺌
        }
        
        print("유저 닉네임은 \(nickname)")
        
        guard let name = nickname else {return}
        self.EditNicknameTextField.text = "\(name)"

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
    
    // 카테고리 버튼1
    func createButton1() {
        button1.configuration = createConfig()
        view.addSubview(button1)
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 24).isActive = true
        button1.leadingAnchor.constraint(equalTo: self.categoryLabel.leadingAnchor, constant: 0).isActive = true
        
        button1.changesSelectionAsPrimaryAction = true

        button1.configurationUpdateHandler =  { button in
          var config = button.configuration
          config?.title = "카페·디저트"
            config?.baseBackgroundColor = button.isSelected ? .init(named: "lightred") : .white
          config?.image = button.isSelected
          ? UIImage(named: "checkedicon")
            : .none
          button.configuration = config
        }
        
        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button1.layer.cornerRadius = 16
    }
    
    func createConfig() -> UIButton.Configuration {
        var config: UIButton.Configuration = .filled()
        config.titleAlignment = .center
        config.cornerStyle = .capsule
        config.baseForegroundColor = .darkGray
        var titleAttr = AttributedString.init("button1")
        titleAttr.font = .systemFont(ofSize: 13.0, weight: .regular)
            config.attributedTitle = titleAttr
        return config
    }
    
    // 카테고리 버튼2
    func createButton2() {
        button2.configuration = createConfig2()
        view.addSubview(button2)
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 24).isActive = true
        button2.leadingAnchor.constraint(equalTo: self.button1.trailingAnchor, constant: 8).isActive = true
        
        button2.changesSelectionAsPrimaryAction = true

        button2.configurationUpdateHandler =  { button in
          var config = button.configuration
          config?.title = "편의·생활"
            config?.baseBackgroundColor = button.isSelected ? .init(named: "lightred") : .white
          config?.image = button.isSelected
          ? UIImage(named: "checkedicon")
            : .none
          button.configuration = config
        }
        
        button2.layer.borderWidth = 1
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.cornerRadius = 16
    }
    
    func createConfig2() -> UIButton.Configuration {
        var config: UIButton.Configuration = .filled()
        config.titleAlignment = .center
        config.cornerStyle = .capsule
        config.baseForegroundColor = .darkGray
        var titleAttr = AttributedString.init("button2")
        titleAttr.font = .systemFont(ofSize: 13.0, weight: .regular)
            config.attributedTitle = titleAttr
        return config
    }
    
    // 카테고리 버튼3
    func createButton3() {
        button3.configuration = createConfig3()
        view.addSubview(button3)
        button3.translatesAutoresizingMaskIntoConstraints = false
        button3.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 24).isActive = true
        button3.leadingAnchor.constraint(equalTo: self.button2.trailingAnchor, constant: 8).isActive = true
        
        button3.changesSelectionAsPrimaryAction = true

        button3.configurationUpdateHandler =  { button in
          var config = button.configuration
          config?.title = "반찬"
            config?.baseBackgroundColor = button.isSelected ? .init(named: "lightred") : .white
          config?.image = button.isSelected
          ? UIImage(named: "checkedicon")
            : .none
          button.configuration = config
        }
        
        button3.layer.borderWidth = 1
        button3.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.cornerRadius = 16
    }
    
    func createConfig3() -> UIButton.Configuration {
        var config: UIButton.Configuration = .filled()
        config.titleAlignment = .center
        config.cornerStyle = .capsule
        config.baseForegroundColor = .darkGray
        var titleAttr = AttributedString.init("button3")
        titleAttr.font = .systemFont(ofSize: 13.0, weight: .regular)
            config.attributedTitle = titleAttr
        return config
    }
    
    // 카테고리 버튼4
    func createButton4() {
        button4.configuration = createConfig4()
        view.addSubview(button4)
        button4.translatesAutoresizingMaskIntoConstraints = false
        button4.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 24).isActive = true
        button4.leadingAnchor.constraint(equalTo: self.button3.trailingAnchor, constant: 8).isActive = true
        
        button4.changesSelectionAsPrimaryAction = true

        button4.configurationUpdateHandler =  { button in
          var config = button.configuration
          config?.title = "패션"
            config?.baseBackgroundColor = button.isSelected ? .init(named: "lightred") : .white
          config?.image = button.isSelected
          ? UIImage(named: "checkedicon")
            : .none
          button.configuration = config
        }
        
        button4.layer.borderWidth = 1
        button4.layer.borderColor = UIColor.lightGray.cgColor
        button4.layer.cornerRadius = 16
    }
    
    func createConfig4() -> UIButton.Configuration {
        var config: UIButton.Configuration = .filled()
        config.titleAlignment = .center
        config.cornerStyle = .capsule
        config.baseForegroundColor = .darkGray
        var titleAttr = AttributedString.init("button4")
        titleAttr.font = .systemFont(ofSize: 13.0, weight: .regular)
            config.attributedTitle = titleAttr
        return config
    }
    
    // 카테고리 버튼5
    func createButton5() {
        button5.configuration = createConfig5()
        view.addSubview(button5)
        button5.translatesAutoresizingMaskIntoConstraints = false
        button5.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 24).isActive = true
        button5.leadingAnchor.constraint(equalTo: self.button4.trailingAnchor, constant: 8).isActive = true
        
        button5.changesSelectionAsPrimaryAction = true

        button5.configurationUpdateHandler =  { button in
          var config = button.configuration
          config?.title = "반찬"
            config?.baseBackgroundColor = button.isSelected ? .init(named: "lightred") : .white
          config?.image = button.isSelected
          ? UIImage(named: "checkedicon")
            : .none
          button.configuration = config
        }
        
        button5.layer.borderWidth = 1
        button5.layer.borderColor = UIColor.lightGray.cgColor
        button5.layer.cornerRadius = 16
    }
    
    func createConfig5() -> UIButton.Configuration {
        var config: UIButton.Configuration = .filled()
        config.titleAlignment = .center
        config.cornerStyle = .capsule
        config.baseForegroundColor = .darkGray
        var titleAttr = AttributedString.init("button5")
        titleAttr.font = .systemFont(ofSize: 13.0, weight: .regular)
            config.attributedTitle = titleAttr
        return config
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

