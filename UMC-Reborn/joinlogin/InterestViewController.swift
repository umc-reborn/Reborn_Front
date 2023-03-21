//
//  InterestViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/01/28.
//

import UIKit

class InterestViewController: UIViewController {
    
    var apple3 : String = "" // ad
    var thisisemail2 : String = "" //email
    
    var yourId3 : String = "" // Id
    var yourPw3 : String = "" // Pw
    
    
    var yourNickName1 : String = "" // Nickname
    var yourGround1 : String = "" // address
    var HBD1 : String = "" //Birthday 데이트피커

    var yourInterest : String = ""
    
    var FinalMData : realFinModel!
    
    var number1 = true
    var number2 = true
    var number3 = true
    var number4 = true
    var number5 = true
    
    var gray_cafe: UIImage?
    var gray_banchan: UIImage?
    var gray_fashion: UIImage?
    var gray_life: UIImage?
    var gray_etc: UIImage?
    
    var orange_cafe: UIImage?
    var orange_banchan: UIImage?
    var orange_fashion: UIImage?
    var orange_life: UIImage?
    var orange_etc: UIImage?
    
    @IBOutlet weak var cafeButton: UIButton!
    @IBOutlet weak var banchanButton: UIButton!
    @IBOutlet weak var fashionButton: UIButton!
    @IBOutlet weak var lifeButton: UIButton!
    @IBOutlet weak var etcButton: UIButton!
    @IBOutlet weak var nextButton11: UIButton!
    @IBOutlet weak var progressView6: UIProgressView!
    
    //var selectedOrangeButtonIndex = -1
    
    @IBAction func cafeButtonTapped(_ sender:Any){
        yourInterest = "CAFE"
        if (number1 == true){
            cafeButton.setImage(orange_cafe, for: .normal)
            number1 = false
        }
        else {
            cafeButton.setImage(gray_cafe, for: .normal)
            number1 = true
            nextButton11.isEnabled = false
        }
    }
    
    @IBAction func banchanButtonTapped(_ sender:Any){
        yourInterest = "SIDEDISH"
        if (number2 == true){
            banchanButton.setImage(orange_banchan, for: .normal)
            number2 = false
        }
        else {
            banchanButton.setImage(gray_banchan, for: .normal)
            number2 = true
            nextButton11.isEnabled = false
        }
    }
    
    @IBAction func fashionButtonTapped(_ sender:Any){
        yourInterest = "FASHION"
        if (number3 == true){
            fashionButton.setImage(orange_fashion, for: .normal)
            number3 = false
        }
        else {
            fashionButton.setImage(gray_fashion, for: .normal)
            number3 = true
            nextButton11.isEnabled = false
        }
    }
    
    @IBAction func lifeButtonTapped(_ sender:Any){
        yourInterest = "LIFE"
        if (number4 == true){
            lifeButton.setImage(orange_life, for: .normal)
            number4 = false
        }
        else {
            lifeButton.setImage(gray_life, for: .normal)
            number4 = true
            nextButton11.isEnabled = false
        }
    }
    
    @IBAction func etcButtonTapped(_ sender:Any){
        yourInterest = "ETC"
        if (number5 == true){
            etcButton.setImage(orange_etc, for: .normal)
            number5 = false
        }
        else {
            etcButton.setImage(gray_etc, for: .normal)
            number5 = true
            nextButton11.isEnabled = false
        }
    }
    
    
    @IBAction func finalNextButtonTapped(_ sender: Any) {
        //회원가입 api 보내기 (최종 모은 곳 여기)
        let parmeterData = BigModel(userId: yourId3, userEmail: thisisemail2, userPwd: yourPw3, userNickname: yourNickName1, userAdAgreement: apple3, userBirthDate: HBD1, userAddress: yourGround1, userLikes: yourInterest)
        print(parmeterData)
        JoinNeiPost.instance.SendingPostNeiJoin(parameterspp: parmeterData) { result in self.FinalMData = result }
        print("이웃 회원가입 api 보내졌다!!!!!")
        //let jjang = self.FinalMData?.result
//        guard let uUser = jjang?.userIdx else {return} // 보내야하나?
//        guard let nNick = jjang?.userNickName else {return} // 보내야하나?
//        guard let www = jjang?.jwt else {return} // 보내야하나?
        
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "HelloViewController") as? HelloViewController else {return}
        // 화면이동
        self.navigationController?.pushViewController(rvc, animated: true)
    }
    
    
    //gpt
    //    @IBAction func orangeButtonClicked(_ sender: Any) {
    //        if let buttonIndex = [cafeButton, banchanButton, fashionButton, lifeButton,etcButton ].firstIndex(of: sender as! UIButton) {
    //            selectedOrangeButtonIndex = buttonIndex
    //            let numberOfSelectedButtons = [cafeButton, banchanButton, fashionButton, lifeButton,etcButton].filter { $0.backgroundColor == UIColor.orange }.count
    //            if numberOfSelectedButtons == 1 {
    //                nextButton11.backgroundColor = .mybrown
    //                nextButton11.setTitleColor(.white, for: .normal) // 평상시
    //                nextButton11.setTitleColor(.white, for: .selected) // 선택됐을때
    //                nextButton11.isEnabled = true
    //            } else {
    //                nextButton11.backgroundColor = .white
    //                nextButton11.setTitleColor(.white, for: .normal) // 평상시
    //                nextButton11.setTitleColor(.white, for: .selected)
    //                nextButton11.isEnabled = false
    //            }
    //        }
    //    }
    
    @objc func nextButton11didChanged(_ sender: UIButton) {
        if ((number1 == true) || (number2 == true) || (number3 == true) || (number4 == true) || (number5 == true)){
            nextButton11.backgroundColor = .mybrown
            nextButton11.setTitleColor(.white, for: .normal) // 평상시
            nextButton11.setTitleColor(.white, for: .selected) // 선택됐을때
            nextButton11.isEnabled = true
            
        }
        else {
            nextButton11.backgroundColor = .white
            nextButton11.setTitleColor(.mybrown, for: .normal) // 평상시
            nextButton11.setTitleColor(.mybrown, for: .selected)
            nextButton11.isEnabled = false
        }
    }
        override func viewDidLoad() {
            super.viewDidLoad()
            
            nextButton11.isEnabled = false
            
            gray_cafe = UIImage(named:"gray_cafe")
            gray_banchan = UIImage(named:"gray_banchan")
            gray_fashion = UIImage(named:"gray_fashion")
            gray_life = UIImage(named:"gray_life")
            gray_etc = UIImage(named:"gray_etc")
            
            
            orange_cafe = UIImage(named:"orange_cafe")
            orange_banchan = UIImage(named:"orange_banchan")
            orange_fashion = UIImage(named:"orange_fashion")
            orange_life = UIImage(named:"orange_life")
            orange_etc = UIImage(named:"orange_etc")
            
            
            let mybrown = UIColor(named: "mybrown")
            let myorange = UIColor(named: "myorange")
            
            // back button custom
            self.navigationController?.navigationBar.tintColor = .black
            self.navigationController?.navigationBar.topItem?.title = ""
            
            // viewcontroller 배경 색상 변경 #FFFBF9
            let BACKGROUND = UIColor(named: "BACKGROUND")
            self.view.backgroundColor = BACKGROUND
            
            //progressView6
            progressView6.progressViewStyle = .default
            progressView6.progressTintColor = .myorange
            progressView6.progress = 0.9
            
            // 다음 버튼
            nextButton11.layer.borderWidth = 1.0
            nextButton11.layer.borderColor = mybrown?.cgColor // 테두리 컬러
            nextButton11.layer.cornerRadius = 4.0
            nextButton11.setTitle("다음", for: .normal)  // 버튼 텍스트 설정
            nextButton11.setTitleColor(UIColor.mybrown, for: .normal)//버튼 텍스트 색상 설정
            nextButton11.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_bold", size: 16) //폰트 및 사이즈 설정
            
            cafeButton.addTarget(self, action: #selector(nextButton11didChanged), for:.touchUpInside)
            banchanButton.addTarget(self, action: #selector(nextButton11didChanged), for:.touchUpInside)
            fashionButton.addTarget(self, action: #selector(nextButton11didChanged), for:.touchUpInside)
            lifeButton.addTarget(self, action: #selector(nextButton11didChanged), for:.touchUpInside)
            etcButton.addTarget(self, action: #selector(nextButton11didChanged), for:.touchUpInside)
            
        }
        
        
    }
    

