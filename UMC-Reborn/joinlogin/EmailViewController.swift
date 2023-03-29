//
//  EmailViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/01/28.
//
import Foundation
import UIKit

//바탕 터치하거나 리턴 누르면 키보드 내려감, 텍스트필드.delegate = self 필요
extension EmailViewController: UITextFieldDelegate {

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // TextField 비활성화
        return true
    }
}


class EmailViewController: UIViewController, UITextViewDelegate {

    
    
    // 타이머
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
    
    
    //API
    var emailData: emailModel!
    
    var apple: String = ""
    var UserEmailText: String = ""
    var Something6 : String = ""
    
    //get api 선언
    var Lego : NumCheckModel!
    
    
    var hihi : String = ""
    var rightHi : String = ""
    
    @IBOutlet weak var ProgressView3: UIProgressView!
    
    
    @IBOutlet weak var nextbuttonEmail: UIButton! // 다음 버튼
    
    @IBOutlet weak var EmailTextField: UITextField! // 이메일 텍스트필드
    
    @IBOutlet weak var codeTextField: UITextField! // 인증번호 텍스트필드
    
    @IBOutlet weak var requestButton: UIButton! // 인증 요청 버튼
    
    @IBOutlet weak var requestCheckButton: UIButton! // 인증 확인 버튼
    
    @IBOutlet var miniEmailLabel: UILabel!// 이메일 경고문구
    
    @IBOutlet var miniLabel: UILabel! // 인증번호 경고문구
    
    
    
    @IBOutlet var leftTimeLabel: UILabel!
    @IBOutlet var timeLabel: UILabel! // 타이머 라벨
    
    
    let mybrown = UIColor(named: "mybrown")
    let myorange = UIColor(named: "myorange")
    let mygray = UIColor(named: "mygray")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 600초
        timeSecond = 600
        
        print("ad : who에서 email로 넘어왔음 " + apple) //된다
        
        //뒤로가기 한글 삭제
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        //다음 버튼 비활성화
        nextbuttonEmail.isEnabled = false
    
        //progressView3
        ProgressView3.progressViewStyle = .default
        ProgressView3.progressTintColor = .myorange
        ProgressView3.progress = 0.5
        
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
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
        EmailTextField.keyboardType = .emailAddress // 이메일 치도록
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
        codeTextField.keyboardType = .default // 인증번호는 영어와 숫자로 이루어짐
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
        miniEmailLabel.text = " " // 성공했으니 비어있어야지
        miniEmailLabel.textColor = .mybrown
        
        // 인증확인버튼
        requestCheckButton.layer.borderWidth = 1.0
        requestCheckButton.layer.borderColor = myorange?.cgColor // 테두리 컬러
        requestCheckButton.backgroundColor = .myorange
        requestCheckButton.layer.cornerRadius = 4.0
        requestCheckButton.setTitle("인증확인", for: .normal)  // 버튼 텍스트 설정
        requestCheckButton.setTitleColor(UIColor.white, for: .normal)//버튼 텍스트 색상 설정
        requestCheckButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 15) //폰트 및 사이즈 설정
        
        
        leftTimeLabel.isHidden = true
        timeLabel.isHidden = true
        
        
        EmailTextField.delegate = self
        codeTextField.delegate = self
        textFieldDidBeginEditing(EmailTextField)
        textFieldDidEndEditing(EmailTextField)
        textFieldDidBeginEditing(codeTextField)
        textFieldDidEndEditing(codeTextField)
        
        EmailTextField.addTarget(self, action: #selector(Idontknow), for:.editingChanged)
        
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
    
    //이메일 정규표현식
    func isValidEmail(testStr:String?) -> Bool{
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z].{2,64}"
              let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
              return emailTest.evaluate(with: testStr)
        }
    
    @objc func Idontknow(textField: UITextField){ // 여기에 문제가
        if (textField == EmailTextField){
            if isValidEmail(testStr: textField.text) {
                miniEmailLabel.text = ""
                miniEmailLabel.textColor = .mybrown //의미가 있나
                requestButton.isEnabled = true
            }
            else {
                miniEmailLabel.text = "올바른 이메일 형식을 입력해 주세요."
                miniEmailLabel.textColor = .myorange
                requestButton.isEnabled = false
            }
        }
    }
    
    // 암호화 2개 비교
    @objc func compare2Things() {
        if(self.hihi == self.rightHi) {
            nextbuttonEmail.isEnabled = true // 다음 버튼 활성화
            nextbuttonEmail.backgroundColor = .mybrown
            nextbuttonEmail.setTitleColor(.white, for: .normal) // 평상시
            nextbuttonEmail.setTitleColor(.white, for: .selected)
            miniLabel.text = "인증완료 되었습니다."
            miniLabel.textColor = .mybrown
            requestCheckButton.backgroundColor = .white
            requestCheckButton.layer.borderColor = UIColor.mygray?.cgColor
            requestCheckButton.setTitleColor(.mygray, for: .normal)
            requestCheckButton.isEnabled = false
            
        }
        else {
            nextbuttonEmail.backgroundColor = .white
            nextbuttonEmail.setTitleColor(.mybrown, for: .normal) // 평상시
            nextbuttonEmail.setTitleColor(.mybrown, for: .selected)
            nextbuttonEmail.isEnabled = false // 다음 버튼 비활성화
            miniLabel.text = "올바른 인증번호가 아닙니다."
            miniLabel.textColor = .myorange
            requestCheckButton.backgroundColor = .myorange
            requestCheckButton.layer.borderColor = UIColor.myorange?.cgColor
            requestCheckButton.setTitleColor(.white, for: .normal)
            requestCheckButton.isEnabled = true
        }
    }
    
    @IBAction func nextbuttonEmailTapped(_ sender: Any) {
        Something6 = EmailTextField.text ?? "" // 이메일을 변수에 넣었고

        guard let rvc2 = self.storyboard?.instantiateViewController(withIdentifier: "Id_PassWordViewController") as? Id_PassWordViewController else {return}

        rvc2.apple1 = apple // who에서 email로 온 거 담아서 보낼거임
        rvc2.thisisemail = Something6 // 이메일 담음 (보낼거야)
        
        self.navigationController?.pushViewController(rvc2, animated: true)
    }
    
    
    //인증요청 누르면 api 넘기기 - identificationPost
    @IBAction func requestButtonTapped() {
        
        let paramettaData = Model3(userEmail: EmailTextField.text ?? "")
        print(paramettaData)
        identificationPost.instance.SendingPostNemail(parameters2: paramettaData) { result2 in self.emailData = result2 }
    
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.2) {
            
            //hihi에 암호화된 코드가 담겨있음.
            self.hihi = self.emailData?.result ?? ""
            print("암호화된 인증 코드 = "+self.hihi) // 이게 좀 늦게 뜸!!!!!!!
            self.requestButton.backgroundColor = .white
            self.requestButton.layer.borderColor = UIColor.mygray?.cgColor
            self.requestButton.setTitleColor(.mygray, for: .normal)
            print("나 회색버튼이야")
            self.requestButton.isEnabled = false
            self.leftTimeLabel.isHidden = false
            self.timeLabel.isHidden = false
            self.timerStart()
        }
    }
    
    //인증번호 확인 버튼, result 값이 암호화된 인증 코드. 위에 버튼의 암호화친구와 이 친구가 같아야 다음 버튼 활성화 가능.
    @IBAction func requestCheckButtonTapped() {
        
        //api get - NumCheckGet
        NumCheckGet.instance.NumCheckGetData(veriCode: codeTextField.text ?? ""){result in self.Lego = result
            }
       
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            
            self.rightHi = self.Lego?.result ?? ""
            print("사용자가 입력한 코드 암호화한 것 = " + self.rightHi)
            self.compare2Things() //해냈다...
            
            
            self.requestCheckButton.backgroundColor = .white
            self.requestCheckButton.layer.borderColor = UIColor.mygray?.cgColor
            self.requestCheckButton.setTitleColor(.mygray, for: .normal)
            self.requestCheckButton.isEnabled = false
            
            if(self.hihi != self.rightHi){
                self.requestCheckButton.isEnabled = true
                self.requestCheckButton.layer.borderWidth = 1.0
                self.requestCheckButton.layer.borderColor = self.myorange?.cgColor // 테두리 컬러
                self.requestCheckButton.backgroundColor = .myorange
                self.requestCheckButton.layer.cornerRadius = 4.0
                self.requestCheckButton.setTitle("인증확인", for: .normal)  // 버튼 텍스트 설정
                self.requestCheckButton.setTitleColor(UIColor.white, for: .normal)//버튼 텍스트 색상 설정
                self.requestCheckButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 15) //폰트 및 사이즈 설정
            }
           
        }
    }
    
    // 타이머
    func timerStart() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.timeSecond -= 1
            if (self.timeSecond == 0) {
                timer.invalidate()
                self.requestCheckButton.backgroundColor = .white
                self.requestCheckButton.layer.borderColor = UIColor.mygray?.cgColor
                self.requestCheckButton.setTitleColor(.mygray, for: .normal)
                self.requestCheckButton.isEnabled = false
            }
        }
        RunLoop.current.add(self.timer!, forMode: .common)
    }
}
