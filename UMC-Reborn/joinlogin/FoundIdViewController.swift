//
//  FoundIdViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/01.
//

import UIKit

class FoundIdViewController: UIViewController {

    @IBOutlet weak var IdFullButton: UIButton!
    
    @IBOutlet weak var FoundIdLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
