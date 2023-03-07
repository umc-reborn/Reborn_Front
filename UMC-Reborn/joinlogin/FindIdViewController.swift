//
//  FindIdViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/01.
//

import UIKit

class FindIdViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    
    @IBOutlet weak var FindIdTextField: UITextField! // 이메일 텍스트필드
    
    @IBOutlet weak var FindIdNextButton: UIButton! // 버튼
    
    
    //api 선언
    var Hago : FindPartModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //다음 버튼 비활성화
//        FindIdNextButton.isEnabled = false
        
        let mybrown = UIColor(named: "mybrown")
        let myorange = UIColor(named: "myorange")
        let mygray = UIColor(named: "mygray")
        
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
        
        // back button custom
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        
        
        FindIdNextButton.layer.borderWidth = 1.0
        FindIdNextButton.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        FindIdNextButton.layer.cornerRadius = 4.0
        FindIdNextButton.setTitle("다음", for: .normal)  // 버튼 텍스트 설정

        FindIdNextButton.setTitleColor(UIColor.mybrown, for: .normal)//버튼 텍스트 색상 설정

        FindIdNextButton.titleLabel?.font = UIFont(name: "AppleSDGothic_bold", size: 16) //폰트 및 사이즈 설정
        
        
        FindIdTextField.addLeftPadding1()
        FindIdTextField.placeholder = "아이디를 입력해 주세요"
        FindIdTextField.backgroundColor = .white
        FindIdTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        FindIdTextField.keyboardType = .asciiCapable // only english
        FindIdTextField.textColor = .black
        FindIdTextField.layer.borderWidth = 1.0 // 두께
        FindIdTextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
        FindIdTextField.layer.cornerRadius = 4.0
        FindIdTextField.clearButtonMode = .always // 한번에 지우기
        
        FindIdTextField.delegate = self
        textFieldDidBeginEditing(FindIdTextField)
        textFieldDidEndEditing(FindIdTextField)
        
//        FindIdNextButton.addTarget(self, action: #selector(textFieldDidChanged), for:.touchUpInside)
        
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
    
    //email 정규표현식
    func isValidEmail(testStr:String) -> Bool {
          let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
          let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
          return emailTest.evaluate(with: testStr)
           }
    
    
    // 아이디 찾기 - 확인 버튼 눌렀을 때 api / 화면 넘기기도 하기
//    @IBAction func FindIdNextButtonTapped() {
//        userE = FindIdTextField.text ?? ""
//        let kimnana =
//        FindIdGet.instance.FindIdGetData(userEmail: FindIdTextField.text ?? ""){result in self.Hago = result}
//    }
    
    // 입력한 거랑 불러온 거랑 일치하면 오류화면 안뜨는 화면으로
    // 일치하지 않으면 alert화면으로 넘어가기.
    // 다음 버튼 누르면 화면 바뀌고 +
    
    
    
    @IBAction func FindIdNextButtonTapped(_ sender: Any) {
            
            //api get
            FindIdGet.instance.FindIdGetData(userEmail: FindIdTextField.text ?? ""){result in self.Hago = result
                
               // print("result : \(result)")
            }
            
            // 이메일이 서버에 있는 것과 일치하면 화면전환 + 데이터값 넘겨주기
                //print("Hago : \(self.Hago)")
               
//        if (self.Hago.result.userId != "") {
//                    let object1 = self.Hago?.result
//                    guard let idUser = object1?.userId else {return}
//                    guard let datee = object1?.createdAt else {return}
//                    //guard let iimage = object1?.민몰리변수 else {return}
//                    let some1 = UIStoryboard(name: "JoinLogin", bundle: nil)
//                    guard let rvc = some1.instantiateViewController(withIdentifier: "FoundIdViewController") as? FoundIdViewController else {return}
//
//                    rvc.userId1 = idUser
//                    rvc.createdAt1 = datee
//                    //rvc.image1 = iimage
//                    self.navigationController?.pushViewController(rvc, animated: true)
//                }
//                // 회원이 아닌 이메일이면 alert창으로 화면전환
//                else {
//                    let some2 = UIStoryboard(name: "JoinLogin", bundle: nil)
//                    guard let rvcc = some2.instantiateViewController(withIdentifier: "noEmailViewController") as? noEmailViewController else {return}
//
//                    self.navigationController?.pushViewController(rvcc, animated: true)
//                }
//            }
//
//    }


//    func aaaa() {
//        // 이메일 잘 채워졌으면
//        if () {
//            FindIdNextButton.backgroundColor = .mybrown
//            FindIdNextButton.setTitleColor(.white, for: .normal) // 평상시
//            FindIdNextButton.setTitleColor(.white, for: .selected)
//            FindIdNextButton.isEnabled = true
//        }
//        else {
//            // 버튼 비활성화
//        }
//    }
    
//    @objc func textFieldDidChanged(_ sender: Any?) {
//        if (){
//            FindIdNextButton.backgroundColor = .mybrown
//            FindIdNextButton.setTitleColor(.white, for: .normal)
//            FindIdNextButton.setTitleColor(.white, for: .selected)
//            FindIdNextButton.isEnabled = true // 활성화
        }
        }




