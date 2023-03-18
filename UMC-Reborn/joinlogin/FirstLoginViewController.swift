//
//  FirstLoginViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/01/22.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser


class FirstLoginViewController: ViewController {
    
    
    @IBOutlet weak var FirstView: UIView!
    
    @IBOutlet var kakaoButton: UIButton! // 카카오버튼
    
    
    @IBOutlet var googleButton: UIButton! // 구글 버튼
    
    //    private var viewControllers: [UIViewController] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
    }
    
    
    @IBAction func kakaoLoginButtonTouchUpInside(_ sender: UIButton) {
        //카카오
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")

                    //do something
                    let _ = oauthToken
                    //카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
                    //self.setUserInfo()
                }
            }
        }
    
//    func setUserInfo() {
//        UserApi.shared.me() {(user, error) in
//            if let error = error {
//                print(error)
//            }
//            else {
//                print("me() success.")
//                //do something
//                _ = user
//                let userKakaoNickName = user?.kakaoAccount?.profile?.nickname
//
//                if let url = user?.kakaoAccount?.profile?.profileImageUrl,
//                    let data = try? Data(contentsOf: url) {
//                    let userKakaoImage = UIImage(data: data) // 프로필 이미지 같은데
//
//                    let something3 = UIStoryboard(name: "PersonalTab", bundle: nil)
//                    guard let rvc = something3.instantiateViewController(withIdentifier: "PersonalTabVC") as? PersonalTabViewController else {return}
//
//                    // 풀 받고 건드리기 -> 퍼스널텝뷰컨트롤러에 ukn, uki 선언하기
////                    rvc.uKN = userKakaoNickName
////                    rvc.uKI = userKakaoImage
//
//                    self.navigationController?.pushViewController(rvc, animated: true)
//                }
//            }
//        }
//    }
}
    
    
    
    
            
    
        
    
    

    
   


