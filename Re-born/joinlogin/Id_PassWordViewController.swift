//
//  Id_PassWordViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/01.
//

import UIKit

extension Id_PassWordViewController: UITextFieldDelegate {

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // TextField 비활성화
        return true
    }
}

class Id_PassWordViewController: UIViewController,UITextViewDelegate {
    
    //API
    var apple1 : String = "" // ad 광고
    var emailData : emailModel!
    var thisisemail : String = "" // 이메일 인증된 이메일
    
    
    var idCheck : Int = 0
    
    var yourId : String = "" // 아이디
    var yourPw : String = "" // 중복확인한 패스워드
    
    
    @IBOutlet weak var ProgressView4: UIProgressView!
    
    @IBOutlet weak var setIdTextField: UITextField!
    @IBOutlet weak var doubleCheckButton: UIButton!
    @IBOutlet weak var setPwTextField: UITextField! // 비밀번호
    @IBOutlet weak var doubleCheckTextField: UITextField! // 비밀번호 확인
    @IBOutlet weak var nextButton5: UIButton! // 다음 버튼
    
    
    
    @IBOutlet var iddLabel: UILabel! // 중복확인 결과 멘트 경고문구
    
    @IBOutlet var firstPwLabel: UILabel! // 첫 입력된 비밀번호 경고문구
    
    @IBOutlet var secondPwLabel: UILabel! // 두 번째 비밀번호 경고문구
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("Basic_InfoViewController에 광고 도착" + apple1)
        print("Basic_InfoViewController에 이메일 도착" + thisisemail)
        
        
        let mybrown = UIColor(named: "mybrown")
        let myorange = UIColor(named: "myorange")
        let mygray = UIColor(named: "mygray")
        
        // back button custom
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        
        
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
        //ProgressView4
        ProgressView4.progressViewStyle = .default
        ProgressView4.progressTintColor = .myorange
        ProgressView4.progress = 0.66
        
        // 다음버튼
        nextButton5.frame = CGRect(x: 26, y: 516, width: 338, height: 54)
        nextButton5.layer.borderWidth = 1.0
        nextButton5.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        nextButton5.layer.cornerRadius = 4.0
        nextButton5.setTitle("다음", for: .normal)  // 버튼 텍스트 설정
        nextButton5.setTitleColor(UIColor.mybrown, for: .normal)//버튼 텍스트 색상 설정
        nextButton5.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 18) //폰트 및 사이즈 설정
        nextButton5.isEnabled = false
        
        // 중복확인버튼
        doubleCheckButton.layer.borderWidth = 1.0
        doubleCheckButton.layer.borderColor = myorange?.cgColor // 테두리 컬러
        doubleCheckButton.backgroundColor = .myorange
        doubleCheckButton.layer.cornerRadius = 4.0
        doubleCheckButton.setTitle("중복확인", for: .normal)  // 버튼 텍스트 설정
        doubleCheckButton.setTitleColor(UIColor.white, for: .normal)//버튼 텍스트 색상 설정
        doubleCheckButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 15) //폰트 및 사이즈 설정
        
        // 아이디
        setIdTextField.delegate = self
        textFieldDidBeginEditing(setIdTextField)
        textFieldDidEndEditing(setIdTextField)
        
        // 비밀번호
        setPwTextField.delegate = self
        textFieldDidBeginEditing(setPwTextField)
        textFieldDidEndEditing(setPwTextField)
        
        
        //비밀번호 확인
        doubleCheckTextField.delegate = self
        textFieldDidBeginEditing(doubleCheckTextField)
        textFieldDidEndEditing(doubleCheckTextField)
    
        
        
        //아이디
        setIdTextField.addLeftPadding1()
        setIdTextField.placeholder = "4~16자 영문, 숫자를 사용하세요"
        setIdTextField.backgroundColor = .white
        setIdTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        setIdTextField.keyboardType = .asciiCapable // only english
        setIdTextField.textColor = .black
        setIdTextField.layer.borderWidth = 1.0 // 두께
        setIdTextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
        setIdTextField.layer.cornerRadius = 4.0
        setIdTextField.clearButtonMode = .always // 한번에 지우기
        
        //비밀번호
        setPwTextField.addLeftPadding1()
        setPwTextField.placeholder = "8~16자 영문 대소문자, 숫자, 특수문자를 사용하세요"
        setPwTextField.backgroundColor = .white
        setPwTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        setPwTextField.keyboardType = .asciiCapable // only english
        setPwTextField.textColor = .black
        setPwTextField.layer.borderWidth = 1.0 // 두께
        setPwTextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
        setPwTextField.layer.cornerRadius = 4.0
        setPwTextField.clearButtonMode = .always // 한번에 지우기
        setPwTextField.isSecureTextEntry = true // 비밀번호 안보이게
        
        //비밀번호확인
        doubleCheckTextField.addLeftPadding1()
        doubleCheckTextField.placeholder = "비밀번호를 한 번 더 입력해 주세요"
        doubleCheckTextField.backgroundColor = .white
        doubleCheckTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        doubleCheckTextField.keyboardType = .asciiCapable // only english
        doubleCheckTextField.textColor = .black
        doubleCheckTextField.layer.borderWidth = 1.0 // 두께
        doubleCheckTextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
        doubleCheckTextField.layer.cornerRadius = 4.0
        doubleCheckTextField.clearButtonMode = .always // 한번에 지우기
        doubleCheckTextField.isSecureTextEntry = true // 비밀번호 안보이게
        
        
        
        setIdTextField.delegate = self
        setPwTextField.delegate = self
        doubleCheckTextField.delegate = self
        
        textFieldDidBeginEditing(setIdTextField)
        textFieldDidEndEditing(setIdTextField)
        textFieldDidBeginEditing(setPwTextField)
        textFieldDidEndEditing(setPwTextField)
        textFieldDidBeginEditing(doubleCheckTextField)
        textFieldDidEndEditing(doubleCheckTextField)
        
        // add target
        setPwTextField.addTarget(self, action: #selector(passwordRegex(_:)), for: .editingChanged)
        doubleCheckTextField.addTarget(self, action: #selector(passwordRegex(_:)), for: .editingChanged)
        setIdTextField.addTarget(self, action: #selector(passwordRegex(_:)), for: .editingChanged)
        
//        setPwTextField.addTarget(self, action: #selector(equalPassWord), for: .editingChanged)
//        doubleCheckTextField.addTarget(self, action: #selector(equalPassWord), for: .editingChanged)

        // 키보드 내려가게
//        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//                self.view.endEditing(true)
        
        
        
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
    
    
    // 패스워드 정규식 확인 함수
    @objc func passwordRegex(_ textField: UITextField) {
            
        if (textField == setPwTextField) {
            if isValidPassWord(testStr: textField.text) {
                firstPwLabel.text = ""
            }
            else {
                firstPwLabel.text = "8~16자 영문 대소문자, 숫자, 특수문자를 사용하세요."
                firstPwLabel.textColor = .myorange
                nextButton5.backgroundColor = .white
            }
        }
        else if (setPwTextField.text == doubleCheckTextField.text) {
            secondPwLabel.text = ""
        }
        else if (setPwTextField.text != doubleCheckTextField.text){
            secondPwLabel.text = "비밀번호가 일치하지 않습니다."
            secondPwLabel.textColor = .myorange
            nextButton5.backgroundColor = .white
        }
        
        if ((setPwTextField.text == doubleCheckTextField.text) && (setIdTextField.isEnabled == false) && (isValidPassWord(testStr: setPwTextField.text))) {
            nextButton5.isEnabled = true
            nextButton5.setTitleColor(.white, for: .normal)
            nextButton5.backgroundColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1)
        } else {
            nextButton5.setTitleColor(UIColor.mybrown, for: .normal)
        }
        
        UIView.animate(withDuration: 0.1) { // 효과 주기
                self.view.layoutIfNeeded()
        }
    }
    
    
    //Id 정규표현식
    //아이디는 2-10자의 영문과 숫자와 일부 특수문자(._-)만 입력 가능
    func isValidLogin(testStr: String?) -> Bool{
        let regex = "/^(?=.*[a-zA-Z])[-a-zA-Z0-9_.]{2,10}$/;"
        
        let pwTest = NSPredicate(format:"SELF MATCHES %@", regex)
        return pwTest.evaluate(with: testStr)
    }
    
    
    //pw 정규표현식
    func isValidPassWord(testStr: String?) -> Bool{
        let regex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[\\d])(?=.*[~!@#\\$%\\^&\\*])[\\w~!@#\\$%\\^&\\*]{8,16}$"
        
        let pwTest = NSPredicate(format:"SELF MATCHES %@", regex)
        return pwTest.evaluate(with: testStr)
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
    
    @IBAction func idCheckButtonTapped(_ sender: Any) {
        
        IdCheckResult(userid: setIdTextField.text ?? "")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.8) {
            // 버튼 누르면 색깔 회색으로 바뀌도록 만들어야 함.
            if (self.idCheck == 1000){ // 성공. 이게문제네 이거 안됨 두번 눌러야 됨
                //버튼 색깔 = 글씨 회색 + 백그라운드 흰색 + 테두리 바꾸기 회색
                self.doubleCheckButton.backgroundColor = .white
                self.doubleCheckButton.layer.borderColor = UIColor.mygray?.cgColor
                self.doubleCheckButton.setTitleColor(.mygray, for: .normal)
                self.iddLabel.text = "사용가능한 아이디입니다."
                self.iddLabel.textColor = .mybrown
                self.setIdTextField.isEnabled = false
                self.doubleCheckButton.isEnabled = false
            }
            else {
                self.iddLabel.text = "이미 존재하는 아이디입니다."
                self.iddLabel.textColor = .myorange
                self.doubleCheckButton.isEnabled = true
            }
        }
    }
    
//    @objc func equalPassWord(_ sender: UITextField){
//        // 비밀번호 두 번 쳤을 때 같다면
//        if (setPwTextField.text == doubleCheckTextField.text){
//            nextButton5.layer.borderColor = UIColor.mybrown?.cgColor
//            //nextButton5.isEnabled = true
//            nextButton5.backgroundColor = .mybrown
//            nextButton5.setTitleColor(.white, for: .normal) // 평상시
//
//        }
//        else { // 다르다면
//            nextButton5.layer.borderColor = UIColor.mybrown?.cgColor
//            //nextButton5.isEnabled = false
//            nextButton5.backgroundColor = .white
//            nextButton5.setTitleColor(.mybrown, for: .normal) // 평상시
//            secondPwLabel.text = "비밀번호가 일치하지 않습니다."
//        }
//    }

    // 버튼 누르면 화면 전환 + 아이디, 비밀번호 넘기기
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        if (doubleCheckButton.isEnabled == false) {
            yourId = setIdTextField.text ?? "" // 인증 완료된 아이디
            yourPw = doubleCheckTextField.text ?? "" // 인증 완료된 비밀번호
            
            guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "Basic_InfoViewController") as? Basic_InfoViewController else {return}
            
            rvc.apple2 = apple1 // who에서 email로 온 거 담아서 보낼거임
            rvc.thisisemail1 = thisisemail // 이메일 담음 (보낼거야)
            rvc.yourId2 = yourId
            rvc.yourPw2 = yourPw
            
            print("나와라 ============")
            
            self.navigationController?.pushViewController(rvc, animated: true)
            
            print("나와라11111 ============")
        } else {
            guard let rvc2 = self.storyboard?.instantiateViewController(withIdentifier: "IdCheckViewController") as? IdCheckViewController else {return}
            rvc2.modalPresentationStyle = .overFullScreen
            self.present(rvc2, animated: false, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "회원가입"
    }
}
