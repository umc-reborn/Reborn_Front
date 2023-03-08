//
//  EmailViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/01/28.
//
import Foundation
import UIKit

 
class EmailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var apple: String = ""
    
    //API
    var emailData: emailModel!
    var UserEmailText: String = ""
    //var textt : String = ""
    var Something6 : String = ""
    
    //get api 선언
    var Lego : NumCheckModel!
    
    @IBOutlet weak var ProgressView3: UIProgressView!
    
    
    @IBOutlet weak var nextbuttonEmail: UIButton! // 다음 버튼
    
    @IBOutlet weak var EmailTextField: UITextField! // 이메일 텍스트필드
    
    @IBOutlet weak var codeTextField: UITextField! // 인증번호 텍스트필드
    
    @IBOutlet weak var requestButton: UIButton! // 인증 요청 버튼
    
    @IBOutlet weak var requestCheckButton: UIButton! // 인증 확인 버튼
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ad : who에서 email로 넘어왔음 " + apple) //된다
        
        //뒤로가기 한글 삭제
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        
        
        //progressView3
        ProgressView3.progressViewStyle = .default
        ProgressView3.progressTintColor = .myorange
        ProgressView3.progress = 0.5
        
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
        let mybrown = UIColor(named: "mybrown")
        let myorange = UIColor(named: "myorange")
        let mygray = UIColor(named: "mygray")
        
        // 다음 버튼
        nextbuttonEmail.layer.borderWidth = 1.0
        nextbuttonEmail.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        nextbuttonEmail.layer.cornerRadius = 4.0
        nextbuttonEmail.setTitle("다음", for: .normal)  // 버튼 텍스트 설정
        nextbuttonEmail.setTitleColor(UIColor.mybrown, for: .normal)//버튼 텍스트 색상 설정
        nextbuttonEmail.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_bold", size: 16) //폰트 및 사이즈 설정
        
        // 이메일 텍스트필드
        EmailTextField.addLeftPadding1()
        EmailTextField.placeholder = "이메일을 입력해 주세요"
        EmailTextField.backgroundColor = .white
        EmailTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        EmailTextField.keyboardType = .asciiCapable // only english
        EmailTextField.textColor = .black
        EmailTextField.layer.borderWidth = 1.0 // 두께
        EmailTextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
        EmailTextField.layer.cornerRadius = 4.0
        EmailTextField.clearButtonMode = .always // 한번에 지우기
        
        
        // 인증번호 텍스트필드
        codeTextField.addLeftPadding1()
        codeTextField.placeholder = "인증번호를 입력해주세요"
        codeTextField.backgroundColor = .white
        codeTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        codeTextField.keyboardType = .numberPad
        codeTextField.textColor = .black
        codeTextField.layer.borderWidth = 1.0 // 두께
        codeTextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
        codeTextField.layer.cornerRadius = 4.0
        codeTextField.clearButtonMode = .always // 한번에 지우기
        
        // 인증요청버튼
        requestButton.layer.borderWidth = 1.0
        requestButton.layer.borderColor = myorange?.cgColor // 테두리 컬러
        requestButton.backgroundColor = .myorange
        requestButton.layer.cornerRadius = 4.0
        requestButton.setTitle("인증요청", for: .normal)  // 버튼 텍스트 설정
        requestButton.setTitleColor(UIColor.white, for: .normal)//버튼 텍스트 색상 설정
        requestButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 15) //폰트 및 사이즈 설정
        
        // 인증확인버튼
        requestCheckButton.layer.borderWidth = 1.0
        requestCheckButton.layer.borderColor = myorange?.cgColor // 테두리 컬러
        requestCheckButton.backgroundColor = .myorange
        requestCheckButton.layer.cornerRadius = 4.0
        requestCheckButton.setTitle("인증확인", for: .normal)  // 버튼 텍스트 설정
        requestCheckButton.setTitleColor(UIColor.white, for: .normal)//버튼 텍스트 색상 설정
        requestCheckButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 15) //폰트 및 사이즈 설정
        
        EmailTextField.delegate = self
        codeTextField.delegate = self
        textFieldDidBeginEditing(EmailTextField)
        textFieldDidEndEditing(EmailTextField)
        textFieldDidBeginEditing(codeTextField)
        textFieldDidEndEditing(codeTextField)
        
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
    
    //다음 버튼 누르면 데이터 보내기 : 1. ad 2. 이메일
    // 인증 번호 같아야 넘어갈거임...인증번호 같은지 확인 후 활성화 되는 함수 만들기
    //    @IBAction func nextbuttonEmailTapped(_ sender: Any) {
    //        Something6 = EmailTextField.text ??  // 이메일을 변수에 넣었고
    //
    //        let storyBBB = UIStoryboard.init(name: "JoinLogin", bundle: nil)
    //        guard let rvc2 = storyBBB.instantiateViewController(withIdentifier: "Id_PassWordViewController") as? Id_PassWordViewController else {return}
    //
    //        rvc2.apple1 = apple // who에서 email로 온 거 담아서 보낼거임
    //        rvc2.thisisemail = Something6 // 이메일 담음 (보낼거야)
    //
    //
    //    }
    
    //인증요청 누르면 api 넘기기
    @IBAction func requestButtonTapped() {
        
        let paramettaData = Model3(userEmail: EmailTextField.text ?? "")
        print(paramettaData)
        identificationPost.instance.SendingPostNemail(parameters2: paramettaData) { result2 in self.emailData = result2 }
        
        //let something6 = emailData
        //guard let textt = emailData?.result else {return}
        
        //let decodedData = try JSONDecoder().decode(emailModel.self, from: <#T##Data#>)
        //self.emailData =
        
        UserEmailText = emailData?.result ?? ""
        print("암호화된 인증 코드 = "+UserEmailText) // 꺼내와야하는데 이게 문제. 알아보기.
    }
    
    //인증번호 확인 버튼, result 값이 암호화된 인증 코드. 위에 버튼의 암호화친구와 이 친구가 같아야 다음 버튼 활성화 가능.
//    @IBAction func requestCheckButtonTapped() {
//        
//        //api get
//        NumCheckGet.instance.NumCheckGetData(veriCode: codeTextField.text ?? ""){result in self.Lego = result}
//        
//    }
}
