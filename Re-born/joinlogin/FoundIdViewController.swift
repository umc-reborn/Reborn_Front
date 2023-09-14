//
//  FoundIdViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/01.
//

import UIKit

class FoundIdViewController: UIViewController {
    
    var emailTexted : String = ""
    var userId1 : String = ""
    var createdAt1 : String = ""
    var image1 : String = ""
    
    var TTrainData : TTrainModel!
    
    
    
    @IBOutlet weak var IdFullButton: UIButton! // 아이디 전체보기 버튼
    
    @IBOutlet weak var FoundIdLoginButton: UIButton!
    
    @IBOutlet var imageRound: UIImageView! // 프로필 이미지 
    
    @IBOutlet var UrNameLabel: UILabel! // 아이디 뒤 3글자 지워진 label
    
    @IBOutlet var joinDateLabel: UILabel! // 가입일 label
    
    @IBOutlet var whiteView: UIView! // 뷰 배경
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 콘솔
        print("유저가 친 이메일 : " + emailTexted)
        print("유저 아이디 : " + userId1)
        print("가입일 : " + createdAt1)
        print("이미지 : " + image1)
        
        // 표현
        UrNameLabel.text = userId1
        joinDateLabel.text = createdAt1
        // + 이미지 까지 (api)
        //let url = URL(string: 받아온유저이미지스트링값)
        let url = URL(string: image1)
        imageRound.load(url: url!)
        
        let mybrown = UIColor(named: "mybrown")
        
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
    // 아이디 전체보기 api
    @IBAction func IdFullButtonTapped(_ sender: Any) {
        let pparmeterData = EModel(userEmail : self.emailTexted)
        print(pparmeterData)
        FullMailPost.instance.sendingPostFullEmail(parameters: pparmeterData) { result in self.TTrainData =  result }
        print("===이메일로 아이디가 전송되었음===")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.8) {
            // 이메일로 아이디 전송되었다는 alert
            guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "goEmailViewController") as? goEmailViewController else {return}
            
            rvc.modalPresentationStyle = .overFullScreen
            self.present(rvc, animated: true)
            
        }
        
    }
    
    
    @IBAction func LogInBButtonTapped(_ sender: Any) {
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "FirstLoginViewController") as? FirstLoginViewController else {return}
        
        self.navigationController?.pushViewController(rvc, animated: true)
        print("로그인 창으로 이동")
    }
    
}
