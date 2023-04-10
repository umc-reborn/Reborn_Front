//
//  ServiceViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/01/26.
//

import UIKit


extension UIColor { // 컬러를 이렇게 익스텐션으로 설정해서 쓰면 편하다 - asset input method를 8비트로 바꿔주었더니 된다!
    class var myorange: UIColor? { return UIColor(named: "myorange") }

    class var mygray: UIColor? { return UIColor(named: "mygray") }

    class var mybrown: UIColor? { return UIColor(named: "mybrown") }
    
    class var BACKGROUND: UIColor? {return UIColor(named: "BACKGROUND")}
}


class ServiceViewController: UIViewController {
    
    // 데이터 넘길 때 쓸 변수
    var smallStatus4 : String = "X"
    
    
    
    @IBOutlet weak var NnextButton: UIButton!
    
    @IBOutlet weak var ProgressView: UIProgressView!
    
 
    // 연결
    @IBOutlet weak var BigButton: UIButton!
    
    @IBOutlet weak var SmallButton1: UIButton!
    
    @IBOutlet weak var SmallButton2: UIButton!
    
    @IBOutlet weak var SmallButton3: UIButton!
    
    @IBOutlet weak var SmallButton4: UIButton!
    
    
    // 액션
    @IBAction func BigButtonTapped(_ sender: Any) {
        if BigButton.tintColor == .mygray {
            BigButton.tintColor = .myorange
            SmallButton1.tintColor = .myorange
            SmallButton2.tintColor = .myorange
            SmallButton3.tintColor = .myorange
            SmallButton4.tintColor = .myorange
            smallStatus4 = "O"
            print("bigbutton orange")
        }
        else {
            BigButton.tintColor = .mygray
            SmallButton1.tintColor = .mygray
            SmallButton2.tintColor = .mygray
            SmallButton3.tintColor = .mygray
            SmallButton4.tintColor = .mygray
            smallStatus4 = "X"
        }
    }
    
    @IBAction func SmallButton1Tapped(_ sender: Any) {
        if SmallButton1.tintColor == .mygray {
            SmallButton1.tintColor = .myorange
            print("SmallButton1 orange")
        }
        else {
            SmallButton1.tintColor = .mygray
        }
    }
    
    @IBAction func SmallButton2Tapped(_ sender: Any) {
        if SmallButton2.tintColor == .mygray {
            SmallButton2.tintColor = .myorange
            print("SmallButton2 orange")
        }
        else {
            SmallButton2.tintColor = .mygray
        }
    }
    
    
    @IBAction func SmallButton3Tapped(_ sender: Any) {
        if SmallButton3.tintColor == .mygray {
            SmallButton3.tintColor = .myorange
            print("SmallButton3 orange")
        }
        else {
            SmallButton3.tintColor = .mygray
        }
    }
    
    @IBAction func SmallButton4Tapped(_ sender: Any) {
        if SmallButton4.tintColor == .mygray {
            SmallButton4.tintColor = .myorange
            smallStatus4 = "O"
            print("SmallButton4 orange")
            
        }
        else {
            SmallButton4.tintColor = .mygray
            smallStatus4 = "X"
        }
    }
   

    @IBAction func NnextButton(_ sender: Any) {

        //화면 넘기기 + 데이터 넘기기
        let servSomething4 = smallStatus4

        let storyB = UIStoryboard.init(name: "JoinLogin", bundle: nil)
        guard let rvcc = storyB.instantiateViewController(withIdentifier: "WhoViewController") as? WhoViewController else {return}

        rvcc.smallStatus44 = servSomething4

        //화면이동
        navigationController?.pushViewController(rvcc, animated: true)


    }
    
    @objc func ButtondidChanged(_ sender: UIButton) {
           
        if ((SmallButton1.tintColor == .myorange) && (SmallButton2.tintColor == .myorange) && (SmallButton3.tintColor == .myorange)){
            NnextButton.backgroundColor = .mybrown
            NnextButton.setTitleColor(.white, for: .normal) // 평상시
            NnextButton.setTitleColor(.white, for: .selected)
            NnextButton.isEnabled = true
           }
        else if ((SmallButton1.tintColor == .myorange) && (SmallButton2.tintColor == .myorange) && (SmallButton3.tintColor == .myorange) && (SmallButton4.tintColor == .myorange) && (BigButton.tintColor == .myorange)){
            NnextButton.backgroundColor = .mybrown
            NnextButton.setTitleColor(.white, for: .normal) // 평상시
            NnextButton.setTitleColor(.white, for: .selected)
            NnextButton.isEnabled = true
        }
        else {
            NnextButton.backgroundColor = .white
            NnextButton.setTitleColor(.mybrown, for: .normal) // 평상시
            NnextButton.setTitleColor(.mybrown, for: .selected)
            NnextButton.isEnabled = false
           }
           
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BigButton.tintColor = UIColor(named:"mygray")
        SmallButton1.tintColor = UIColor(named:"mygray")
        SmallButton2.tintColor = UIColor(named:"mygray")
        SmallButton3.tintColor = UIColor(named:"mygray")
        SmallButton4.tintColor = UIColor(named:"mygray")
        
        
        let mybrown = UIColor(named: "mybrown")
        let myorange = UIColor(named: "myorange")
        
        // back button custom
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
        
        //NnextButton.backgroundColor = .mybrown
        NnextButton.layer.borderWidth = 1.0
        NnextButton.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        NnextButton.layer.cornerRadius = 4.0
        NnextButton.setTitle("다음", for: .normal)  // 버튼 텍스트 설정

        NnextButton.setTitleColor(UIColor.mybrown, for: .normal)//버튼 텍스트 색상 설정

        NnextButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_bold", size: 16) //폰트 및 사이즈 설정
        
        //버튼 비활성화
        NnextButton.isEnabled = false
        
        //progressview
        ProgressView.progressViewStyle = .default
        ProgressView.progressTintColor = .myorange
        ProgressView.progress = 0.16
        
        BigButton.addTarget(self, action: #selector(ButtondidChanged), for:.touchUpInside)
        
        SmallButton1.addTarget(self, action: #selector(ButtondidChanged), for:.touchUpInside)
        
        SmallButton2.addTarget(self, action: #selector(ButtondidChanged), for:.touchUpInside)
        
        SmallButton3.addTarget(self, action: #selector(ButtondidChanged), for:.touchUpInside)
        
        SmallButton4.addTarget(self, action: #selector(ButtondidChanged), for:.touchUpInside)
        
        }
    }
    



