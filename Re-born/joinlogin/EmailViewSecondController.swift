//
//  EmailViewSecondController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/03.
//

import UIKit

class EmailViewSecondController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var timer : Timer? = nil
    var isTimerOn = false
    var timeSecond = 10 {
        willSet(newValue) {
            var hours = String(newValue / 3600)
            var minutes = String(newValue / 60)
            var seconds = String(newValue % 60)
            if hours.count == 1 { hours = "0"+hours }
            if minutes.count == 1 { minutes = "0"+minutes }
            if seconds.count == 1 { seconds = "0"+seconds }
            timeLabel.text = "\(minutes):\(seconds)"
        }
    }

    @IBOutlet weak var Pgemail: UIProgressView!
    
    @IBOutlet var emtextfield: UITextField! // 이메일 텍스트필드
    
    @IBOutlet var numtextfield: UITextField! // 인증번호 텍스트필드
    
    @IBOutlet var emailbutton1: UIButton! // 인증 요청 버튼
    
    @IBOutlet var emailbutton2: UIButton! // 인증 확인 버튼
    
    @IBOutlet var daumbutton: UIButton! // 다음 버튼
    
    @IBOutlet var leftLabel: UILabel!
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var emailLabel: UILabel!
    
    @IBOutlet var CertifyLabel: UILabel!
    
    var emailData: emailModel!
    
    var Lego : NumCheckModel!
    
    var apple: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeSecond = 600
        
        leftLabel.isHidden = true
        timeLabel.isHidden = true
        
        let mybrown = UIColor(named: "mybrown")
        let myorange = UIColor(named: "myorange")
        let mygray = UIColor(named: "mygray")
        
        // 다음 버튼
        daumbutton.layer.borderWidth = 1.0
        daumbutton.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        daumbutton.layer.cornerRadius = 5.0
        daumbutton.setTitle("다음", for: .normal)  // 버튼 텍스트 설정
        daumbutton.setTitleColor(UIColor.mybrown, for: .normal)//버튼 텍스트 색상 설정
        daumbutton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_bold", size: 16) //폰트 및 사이즈 설정
        daumbutton.isEnabled = false
        
        // 이메일 텍스트필드
        emtextfield.addLeftPadding1()
        emtextfield.placeholder = "이메일을 입력해 주세요"
        emtextfield.backgroundColor = .white
        emtextfield.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        emtextfield.keyboardType = .asciiCapable // only english
        emtextfield.textColor = .black
        emtextfield.layer.borderWidth = 1.0 // 두께
        emtextfield.layer.borderColor = mygray?.cgColor // 테두리 컬러
        emtextfield.layer.cornerRadius = 5.0
        emtextfield.clearButtonMode = .always // 한번에 지우기
        
        // 인증번호 텍스트필드
        numtextfield.addLeftPadding1()
        numtextfield.placeholder = "인증번호를 입력해주세요"
        numtextfield.backgroundColor = .white
        numtextfield.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        numtextfield.keyboardType = .numberPad
        numtextfield.textColor = .black
        numtextfield.layer.borderWidth = 1.0 // 두께
        numtextfield.layer.borderColor = mygray?.cgColor // 테두리 컬러
        numtextfield.layer.cornerRadius = 5.0
        numtextfield.clearButtonMode = .always // 한번에 지우기
        
        
        // 인증요청버튼
        emailbutton1.layer.borderWidth = 1.0
        emailbutton1.layer.borderColor = myorange?.cgColor // 테두리 컬러
        emailbutton1.backgroundColor = .myorange
        emailbutton1.layer.cornerRadius = 5.0
        emailbutton1.setTitle("인증요청", for: .normal)  // 버튼 텍스트 설정
        emailbutton1.setTitleColor(UIColor.white, for: .normal)//버튼 텍스트 색상 설정
        emailbutton1.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 15) //폰트 및 사이즈 설정
        
        // 인증확인버튼
        emailbutton2.layer.borderWidth = 1.0
        emailbutton2.layer.borderColor = myorange?.cgColor // 테두리 컬러
        emailbutton2.backgroundColor = .myorange
        emailbutton2.layer.cornerRadius = 5.0
        emailbutton2.setTitle("인증확인", for: .normal)  // 버튼 텍스트 설정
        emailbutton2.setTitleColor(UIColor.white, for: .normal)//버튼 텍스트 색상 설정
        emailbutton2.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 15) //폰트 및 사이즈 설정
        
        
        emtextfield.delegate = self
        numtextfield.delegate = self
        textFieldDidBeginEditing(emtextfield)
        textFieldDidEndEditing(emtextfield)
        textFieldDidBeginEditing(numtextfield)
        textFieldDidEndEditing(numtextfield)
        
        emtextfield.addTarget(self, action: #selector(Idontknow), for:.editingChanged)
    }
    
    func timerStart() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.timeSecond -= 1
            if (self.timeSecond == 0) {
                timer.invalidate()
                self.emailbutton2.backgroundColor = .white
                self.emailbutton2.layer.borderColor = UIColor.mygray?.cgColor
                self.emailbutton2.setTitleColor(.mygray, for: .normal)
                self.emailbutton2.isEnabled = false
            }
        }
        RunLoop.current.add(self.timer!, forMode: .common)
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
    
    func isValidEmail(testStr:String?) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z].{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @objc func Idontknow(textField: UITextField){ // 여기에 문제가
        if (textField == emtextfield){
            if isValidEmail(testStr: textField.text) {
                emailLabel.text = ""
                emailLabel.textColor = .mybrown //의미가 있나
                emailbutton1.isEnabled = true
            }
            else {
                emailLabel.text = "올바른 이메일 형식을 입력해 주세요."
                emailLabel.textColor = .myorange
                emailbutton1.isEnabled = false
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Email_Request(_ sender: Any) {
        let paramettaData = Model3(userEmail: emtextfield.text ?? "")
        identificationPost.instance.SendingPostNemail(parameters2: paramettaData) { result in self.emailData = result }
        
        self.emailbutton1.backgroundColor = .white
        self.emailbutton1.layer.borderColor = UIColor.mygray?.cgColor
        self.emailbutton1.setTitleColor(.mygray, for: .normal)
        print("나 회색버튼이야")
        self.emailbutton1.isEnabled = false
        self.emtextfield.isEnabled = false
        self.leftLabel.isHidden = false
        self.timeLabel.isHidden = false
        self.timerStart()
    }
    
    @IBAction func Request_Identify(_ sender: Any) {
        NumCheckGet.instance.NumCheckGetData(veriCode: numtextfield.text ?? "") { result in self.Lego = result
            }
       
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            if(self.emailData.result == self.Lego.result) {
                self.daumbutton.isEnabled = true // 다음 버튼 활성화
                self.daumbutton.backgroundColor = .mybrown
                self.daumbutton.setTitleColor(.white, for: .normal) // 평상시
                self.daumbutton.setTitleColor(.white, for: .selected)
                self.CertifyLabel.text = "인증완료 되었습니다."
                self.CertifyLabel.textColor = .mybrown
                self.emailbutton2.backgroundColor = .white
                self.emailbutton2.layer.borderColor = UIColor.mygray?.cgColor
                self.emailbutton2.setTitleColor(.mygray, for: .normal)
                self.emailbutton2.isEnabled = false
                self.numtextfield.isEnabled = false
                self.timer?.invalidate()
            }
            else {
                self.daumbutton.backgroundColor = .white
                self.daumbutton.setTitleColor(.mybrown, for: .normal) // 평상시
                self.daumbutton.setTitleColor(.mybrown, for: .selected)
                self.daumbutton.isEnabled = false // 다음 버튼 비활성화
                self.CertifyLabel.text = "올바른 인증번호가 아닙니다."
                self.CertifyLabel.textColor = .myorange
                self.emailbutton2.backgroundColor = .myorange
                self.emailbutton2.layer.borderColor = UIColor.myorange?.cgColor
                self.emailbutton2.setTitleColor(.white, for: .normal)
                self.emailbutton2.isEnabled = true
            }
        }
    }
    
    @IBAction func NextButton(_ sender: Any) {
        guard let rvc2 = self.storyboard?.instantiateViewController(withIdentifier: "Id_PassWordSecondViewController") as? Id_PassWordSecondViewController else {return}
        
        self.navigationController?.pushViewController(rvc2, animated: true)
    }
}
