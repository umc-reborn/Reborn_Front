//
//  ResetPwViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/01.
//

import UIKit

class ResetPwViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    //Api
    var ResetPwData: PwResetresultModel!
    //var Bana : PwResetresultModel!
    
    @IBOutlet weak var ResetIdTextfield: UITextField!
    
    @IBOutlet weak var ResetEmailTextfield: UITextField!
    
    @IBOutlet weak var ResetButton: UIButton!
    
    @IBOutlet var emErrorLabel: UILabel! // 이메일 경고문구
    
    // 전역변수
    let mybrown = UIColor(named: "mybrown")
    let myorange = UIColor(named: "myorange")
    let mygray = UIColor(named: "mygray")
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // back button custom
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
        ResetButton.layer.borderWidth = 1.0
        ResetButton.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        ResetButton.layer.cornerRadius = 4.0
        ResetButton.setTitle("아이디 전체보기", for: .normal)  // 버튼 텍스트 설정
        ResetButton.setTitleColor(UIColor.mybrown, for: .normal)//버튼 텍스트 색상 설정
        ResetButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 18) //폰트 및 사이즈 설정
        ResetButton.setTitle("확인", for: .normal)
        
        ResetIdTextfield.addLeftPadding1()
        ResetIdTextfield.placeholder = "아이디를 입력해 주세요"
        ResetIdTextfield.backgroundColor = .white
        ResetIdTextfield.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        ResetIdTextfield.keyboardType = .asciiCapable // only english
        ResetIdTextfield.textColor = .black
        ResetIdTextfield.layer.borderWidth = 1.0 // 두께
        ResetIdTextfield.layer.borderColor = mygray?.cgColor // 테두리 컬러
        ResetIdTextfield.layer.cornerRadius = 4.0
        ResetIdTextfield.clearButtonMode = .always // 한번에 지우기
        
        ResetEmailTextfield.addLeftPadding1()
        ResetEmailTextfield.placeholder = "이메일을 입력해주세요"
        ResetEmailTextfield.backgroundColor = .white
        ResetEmailTextfield.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        ResetEmailTextfield.keyboardType = .asciiCapable // only english
        ResetEmailTextfield.textColor = .black
        ResetEmailTextfield.layer.borderWidth = 1.0 // 두께
        ResetEmailTextfield.layer.borderColor = mygray?.cgColor // 테두리 컬러
        ResetEmailTextfield.layer.cornerRadius = 4.0
        ResetEmailTextfield.clearButtonMode = .always // 한번에 지우기
        
        ResetIdTextfield.delegate = self
        ResetEmailTextfield.delegate = self
        
        textFieldDidBeginEditing(ResetIdTextfield)
        textFieldDidEndEditing(ResetIdTextfield)
        textFieldDidBeginEditing(ResetEmailTextfield)
        textFieldDidEndEditing(ResetEmailTextfield)
        
        
        ResetEmailTextfield.addTarget(self, action: #selector(Idontknow3), for:.editingChanged)
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
    
    @objc func Idontknow3(textField: UITextField){ // 여기에 문제가
        if (textField == ResetEmailTextfield){
            if isValidEmail(testStr: textField.text) {
                emErrorLabel.text = ""
                emErrorLabel.textColor = .mybrown //의미가 있나
                ResetButton.isEnabled = true
                ResetButton.setTitleColor(.white, for: .normal)
                ResetButton.layer.borderWidth = 1.0
                ResetButton.layer.borderColor = mybrown?.cgColor // 테두리 컬러
                ResetButton.backgroundColor = .mybrown
            }
            else {
                emErrorLabel.text = "올바른 이메일 형식을 입력해 주세요."
                emErrorLabel.textColor = .myorange
                ResetButton.isEnabled = false
            }
        }
    }

    @IBAction func reSetButtonTapped(_ sender: Any) {
        // PwResetPost api 연결
        let parametaData = PwResetModel(userId: ResetIdTextfield.text ?? "", userEmail: ResetEmailTextfield.text ?? "",userPwd: "")
        print(parametaData)
        APIHandlerResetPost.instance.SendingPostReborn(parameters: parametaData) {result in self.ResetPwData = result}
        print("===아이디와 이메일이 서버에 전송됨===")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.8) {
            
            if (self.ResetPwData?.code == 1000) { // 메일 보냈다는 alert창으로 
                guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "sendPwViewController") as? sendPwViewController else {return}
                
                rvc.modalPresentationStyle = .overFullScreen
                self.present(rvc, animated: true)
                
            }
            else { // 회원 없다 alert
                guard let rvcc = self.storyboard?.instantiateViewController(withIdentifier: "noUserViewController") as? noUserViewController else {return}
                
                rvcc.modalPresentationStyle = .overFullScreen
                self.present(rvcc, animated: true)
            }
            
        }
    }
    
}
