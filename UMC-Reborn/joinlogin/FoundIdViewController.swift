//
//  FoundIdViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/01.
//

import UIKit

class FoundIdViewController: UIViewController {
    
    var userId1 : String = ""
    var createdAt1 : String = ""
  //var image1 : String = ""
    
    
    @IBOutlet weak var IdFullButton: UIButton!
    
    @IBOutlet weak var FoundIdLoginButton: UIButton!
    
    @IBOutlet var imageRound: UIImageView! // 프로필 이미지 
    
    @IBOutlet var UrNameLabel: UILabel! // 아이디 뒤 3글자 지워진 label
    
    @IBOutlet var joinDateLabel: UILabel! // 가입일 label
    
    @IBOutlet var whiteView: UIView! // 뷰 배경
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 표현됨
        print("유저 아이디 : " + userId1)
        print("가입일 : " + createdAt1)
        
        
        UrNameLabel.text = userId1
        joinDateLabel.text = createdAt1
        
        // + 이미지 까지
        //let url = URL(string: 받아온유저이미지스트링값)
        //imageRound.load(url: url!)
        
        let mybrown = UIColor(named: "mybrown")
        let myorange = UIColor(named: "myorange")
        let mygray = UIColor(named: "mygray")
        
        
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
        // back button custom
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        
        
        IdFullButton.layer.borderWidth = 1.0
        IdFullButton.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        IdFullButton.layer.cornerRadius = 4.0
        IdFullButton.setTitle("아이디 전체보기", for: .normal)  // 버튼 텍스트 설정
        IdFullButton.setTitleColor(UIColor.mybrown, for: .normal)//버튼 텍스트 색상 설정
        IdFullButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 18) //폰트 및 사이즈 설정
        
        FoundIdLoginButton.layer.borderWidth = 1.0
        FoundIdLoginButton.backgroundColor = .mybrown // 버튼 컬러
        FoundIdLoginButton.layer.cornerRadius = 4.0
        FoundIdLoginButton.setTitle("로그인", for: .normal)  // 버튼 텍스트 설정
        FoundIdLoginButton.setTitleColor(UIColor.white, for: .normal)//버튼 텍스트 색상 설정
        FoundIdLoginButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 18) //폰트 및 사이즈 설정
        
        // 그림자
        whiteView.clipsToBounds = true
        whiteView.layer.cornerRadius = 20
        whiteView.layer.masksToBounds = false
        whiteView.layer.shadowOffset = CGSize(width: 5, height: 10)
        whiteView.layer.shadowRadius = 10
        whiteView.layer.shadowOpacity = 0.1
        
        
    }
    


}
