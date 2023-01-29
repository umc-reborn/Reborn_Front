//
//  ShopLoginViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/01/23.
//

import UIKit


extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}


class ShopLoginViewController: UIViewController {

    
    @IBOutlet weak var IdSecond: UITextField!
    
    @IBOutlet weak var PassWordSecond: UITextField!

    
    @IBOutlet weak var LoginButtonSecond: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mygray = UIColor(named: "mygray") // 만들어둔 컬러 쓰려면 선언 먼저
        let mybrown = UIColor(named: "mybrown")
        
        
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
        
        IdSecond.addLeftPadding()
        IdSecond.placeholder = "아이디를 입력해 주세요"
        IdSecond.backgroundColor = .white
        IdSecond.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        IdSecond.keyboardType = .asciiCapable // only english
        IdSecond.textColor = .black
        IdSecond.layer.borderWidth = 1.0 // 두께
        IdSecond.layer.borderColor = mygray?.cgColor // 테두리 컬러
        IdSecond.layer.cornerRadius = 4.0
        IdSecond.clearButtonMode = .always // 한번에 지우기
      
        
        PassWordSecond.addLeftPadding()
        PassWordSecond.placeholder = "비밀번호를 입력해 주세요"
        PassWordSecond.backgroundColor = .white
        PassWordSecond.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        PassWordSecond.keyboardType = .asciiCapable // only english
        PassWordSecond.textColor = .black
        PassWordSecond.isSecureTextEntry = true // 비밀번호 안보이게
        PassWordSecond.layer.borderWidth = 1.0 // 두께
        PassWordSecond.layer.borderColor = mygray?.cgColor // 테두리 컬러
        PassWordSecond.layer.cornerRadius = 4.0
        PassWordSecond.clearButtonMode = .always // 한번에 지우기
        
        
        LoginButtonSecond.backgroundColor = .black
        //LoginButton.backgroundColor = mybrown
        LoginButtonSecond.layer.borderWidth = 1.0
        LoginButtonSecond.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        LoginButtonSecond.layer.cornerRadius = 4.0
        // 폰트는 코드로 안함
        
        
        
        
        
        
        
        
        
    }
    

}
