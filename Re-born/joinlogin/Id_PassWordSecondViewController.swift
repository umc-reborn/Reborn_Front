//
//  Id_PassWordSecondViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/03.
//

import UIKit

class Id_PassWordSecondViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    
    @IBOutlet weak var PgIdPw: UIProgressView!
    
    @IBOutlet var idddtextField: UITextField! // id
    @IBOutlet var dddCheckButton: UIButton! // id 중복확인
    @IBOutlet var pppTextifield: UITextField! // 비밀번호
    @IBOutlet var dCheckPwTextField: UITextField! // 비밀번호 중복확인
    @IBOutlet var daum1Button: UIButton! // 다음 버튼
    
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var pwLabel: UILabel!
    @IBOutlet var pwcheckLabel: UILabel!
    
    var idCheck : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mybrown = UIColor(named: "mybrown")
        let myorange = UIColor(named: "myorange")
        let mygray = UIColor(named: "mygray")
        
        // 다음버튼
        daum1Button.layer.borderWidth = 1.0
        daum1Button.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        daum1Button.layer.cornerRadius = 4.0
        daum1Button.setTitle("다음", for: .normal)  // 버튼 텍스트 설정
        daum1Button.setTitleColor(UIColor.mybrown, for: .normal)//버튼 텍스트 색상 설정
        daum1Button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 18) //폰트 및 사이즈 설정
        
        // 중복확인버튼
        dddCheckButton.layer.borderWidth = 1.0
        dddCheckButton.layer.borderColor = myorange?.cgColor // 테두리 컬러
        dddCheckButton.backgroundColor = .myorange
        dddCheckButton.layer.cornerRadius = 4.0
        dddCheckButton.setTitle("중복확인", for: .normal)  // 버튼 텍스트 설정
        dddCheckButton.setTitleColor(UIColor.white, for: .normal)//버튼 텍스트 색상 설정
        dddCheckButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 15) //폰트 및 사이즈 설정
        
        
        // 아이디
        idddtextField.delegate = self
        textFieldDidBeginEditing(idddtextField)
        textFieldDidEndEditing(idddtextField)
        
        // 비밀번호
        pppTextifield.delegate = self
        textFieldDidBeginEditing(pppTextifield)
        textFieldDidEndEditing(pppTextifield)
        
        //비밀번호 확인
        dCheckPwTextField.delegate = self
        textFieldDidBeginEditing(dCheckPwTextField)
        textFieldDidEndEditing(dCheckPwTextField)
        
        
        //아이디
        idddtextField.addLeftPadding1()
        idddtextField.placeholder = "2~10자 영문, 숫자를 사용하세요"
        idddtextField.backgroundColor = .white
        idddtextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        idddtextField.keyboardType = .asciiCapable // only english
        idddtextField.textColor = .black
        idddtextField.layer.borderWidth = 1.0 // 두께
        idddtextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
        idddtextField.layer.cornerRadius = 4.0
        idddtextField.clearButtonMode = .always // 한번에 지우기
        
        //비밀번호
        pppTextifield.addLeftPadding1()
        pppTextifield.placeholder = "8~16자 영문 대소문자, 숫자, 특수문자를 사용하세요"
        pppTextifield.backgroundColor = .white
        pppTextifield.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        pppTextifield.keyboardType = .asciiCapable // only english
        pppTextifield.textColor = .black
        pppTextifield.layer.borderWidth = 1.0 // 두께
        pppTextifield.layer.borderColor = mygray?.cgColor // 테두리 컬러
        pppTextifield.layer.cornerRadius = 4.0
        pppTextifield.clearButtonMode = .always // 한번에 지우기
        
        //비밀번호확인
        dCheckPwTextField.addLeftPadding1()
        dCheckPwTextField.placeholder = "비밀번호를 한 번 더 입력해 주세요"
        dCheckPwTextField.backgroundColor = .white
        dCheckPwTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        dCheckPwTextField.keyboardType = .asciiCapable // only english
        dCheckPwTextField.textColor = .black
        dCheckPwTextField.layer.borderWidth = 1.0 // 두께
        dCheckPwTextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
        dCheckPwTextField.layer.cornerRadius = 4.0
        dCheckPwTextField.clearButtonMode = .always // 한번에 지우기
        
        pppTextifield.addTarget(self, action: #selector(passwordRegex(_:)), for: .editingChanged)
        dCheckPwTextField.addTarget(self, action: #selector(passwordRegex(_:)), for: .editingChanged)
        idddtextField.addTarget(self, action: #selector(passwordRegex(_:)), for: .editingChanged)
        idddtextField.addTarget(self, action: #selector(idRegex(_:)), for: .editingChanged)
        
        dddCheckButton.isEnabled = false
    }
    
    @objc func idRegex(_ textField: UITextField) {
        if (isValidLogin(testStr: textField.text)) {
            idLabel.text = ""
            dddCheckButton.isEnabled = true
            daum1Button.isEnabled = true
        } else {
            idLabel.text = "2~10자 영문, 숫자를 사용하세요"
            idLabel.textColor = .myorange
            dddCheckButton.isEnabled = false
            daum1Button.isEnabled = false
        }
    }
    
    @objc func passwordRegex(_ textField: UITextField) {
            
        if (textField == pppTextifield) {
            if isValidPassWord(testStr: textField.text) {
                pwLabel.text = ""
            }
            else {
                pwLabel.text = "8~16자 영문 대소문자, 숫자, 특수문자를 사용하세요."
                pwLabel.textColor = .myorange
                daum1Button.backgroundColor = .white
            }
        }
        else if (pppTextifield.text == dCheckPwTextField.text) {
            pwcheckLabel.text = ""
        }
        else if (pppTextifield.text != dCheckPwTextField.text){
            pwcheckLabel.text = "비밀번호가 일치하지 않습니다."
            pwcheckLabel.textColor = .myorange
            daum1Button.backgroundColor = .white
        }
        
        if ((pppTextifield.text == dCheckPwTextField.text) && (idddtextField.isEnabled == false) && (isValidPassWord(testStr: pppTextifield.text))) {
            daum1Button.isEnabled = true
            daum1Button.setTitleColor(.white, for: .normal)
            daum1Button.backgroundColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1)
        } else {
            daum1Button.setTitleColor(UIColor.mybrown, for: .normal)
        }
        
        UIView.animate(withDuration: 0.1) { // 효과 주기
                self.view.layoutIfNeeded()
        }
    }
    
    // get api 필요
    func IdCheckResult(userid: String) {
        
        let url = APIConstants.baseURL + "/users/checkDuplicate?userId=\(userid)"
        let encodedStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let url = URL(string: encodedStr) else { print("err"); return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { [self] data, response, error in
            if error != nil {
                print("err")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~=
                    response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            if let safeData = data {
                print(String(decoding: safeData, as: UTF8.self))
                
                do {
                    let decodedData = try JSONDecoder().decode(IdCheckList.self, from: safeData)
                    let rebornDatas = decodedData.code
                    print(rebornDatas)
                    DispatchQueue.main.async {
                        print("count: \(rebornDatas)")
                        self.idCheck = rebornDatas
                    }
                } catch {
                    print("Error")
                }
            }
        }.resume()
    }
    
    func isValidLogin(testStr: String?) -> Bool{
        let regex = "[A-Za-z0-9]{2,10}"
        
        let pwTest = NSPredicate(format:"SELF MATCHES %@", regex)
        return pwTest.evaluate(with: testStr)
    }
    
    
    //pw 정규표현식
    func isValidPassWord(testStr: String?) -> Bool{
        let regex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[\\d])(?=.*[~!@#\\$%\\^&\\*])[\\w~!@#\\$%\\^&\\*]{8,16}$"
        
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
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Duplicate_Check(_ sender: Any) {
        IdCheckResult(userid: idddtextField.text ?? "")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.8) {
            // 버튼 누르면 색깔 회색으로 바뀌도록 만들어야 함.
            if (self.idCheck == 1000){ // 성공. 이게문제네 이거 안됨 두번 눌러야 됨
                //버튼 색깔 = 글씨 회색 + 백그라운드 흰색 + 테두리 바꾸기 회색
                self.dddCheckButton.backgroundColor = .white
                self.dddCheckButton.layer.borderColor = UIColor.mygray?.cgColor
                self.dddCheckButton.setTitleColor(.mygray, for: .normal)
                self.idLabel.text = "사용가능한 아이디입니다."
                self.idLabel.textColor = .mybrown
                self.idddtextField.isEnabled = false
                self.dddCheckButton.isEnabled = false
            }
            else {
                self.idLabel.text = "이미 존재하는 아이디입니다."
                self.idLabel.textColor = .myorange
                self.dddCheckButton.isEnabled = true
            }
        }
    }
    
    @IBAction func NextButton(_ sender: Any) {
        guard let rvc2 = self.storyboard?.instantiateViewController(withIdentifier: "ShopBasic_InfoViewController") as? ShopBasic_InfoViewController else {return}
        
        self.navigationController?.pushViewController(rvc2, animated: true)
    }
}
