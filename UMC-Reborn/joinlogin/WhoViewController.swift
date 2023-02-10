//
//  WhoViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/01/26.
//

import UIKit

class WhoViewController: UIViewController {

    // 데이터 넘겨준 것 
    var smallStatus4 : String = ""
    
    var isChangeLeft = false
    var isChangeRight = false
    
    var leftgray: UIImage?
    var leftorange: UIImage?
    var rightgray: UIImage?
    var rightorange: UIImage?
    
    // 방향
    var route_Neighbor = 0
    var route_Shop = 0
    
    @IBOutlet weak var ProgressView2: UIProgressView!
    @IBOutlet weak var LeftBow: UIButton! //왼쪽리본
    @IBOutlet weak var RightBow: UIButton! //오른쪽리본
    @IBOutlet weak var BigWord1: UILabel! // 동네이웃
    @IBOutlet weak var SmallWord1: UILabel! // 나눔받고싶어요
    @IBOutlet weak var BigWord2: UILabel! // 동네 가게
    @IBOutlet weak var SmallWord2: UILabel! //나눔하고싶어요
    @IBOutlet weak var NextButtonn: UIButton!//다음
    
    
    @IBAction func LeftBowTapped(_ sender:Any){
        if (isChangeLeft == false){
            LeftBow.setImage(leftorange, for: .normal)
            BigWord1.textColor = .black
            SmallWord1.textColor = .black
            route_Neighbor = 1
            isChangeLeft = true
        }
        else {
            LeftBow.setImage(leftgray, for: .normal)
            BigWord1.textColor = .mygray
            SmallWord1.textColor = .mygray
            route_Neighbor = 0
            isChangeLeft = false
            NextButtonn.isEnabled = false
        }
    }
    
    @IBAction func RightBowTapped(_ sender:Any){
        if (isChangeRight == false){
            RightBow.setImage(rightorange, for: .normal)
            BigWord2.textColor = .black
            SmallWord2.textColor = .black
            route_Shop = 1
            isChangeRight = true
            
            
        }
        else {
            RightBow.setImage(rightgray, for: .normal)
            BigWord2.textColor = .mygray
            SmallWord2.textColor = .mygray
            route_Shop = 0
            isChangeRight = false
            NextButtonn.isEnabled = false
        }
    }
    
    
    @IBAction func NextButtonTouched(_ sender: Any) {
        if (route_Neighbor == 1){
            let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "EmailViewController")
            self.navigationController?.pushViewController(pushVC!, animated: true)
        }
        else if (route_Shop == 1){
            let pushVCc = self.storyboard?.instantiateViewController(withIdentifier: "EmailViewSecondController")
            self.navigationController?.pushViewController(pushVCc!, animated: true)
        }
        else {
            NextButtonn.isEnabled = false
        }
    }
    
    
    @objc func NextButtonndidChanged(_ sender: UIButton) {
        if ((isChangeLeft == true) && (isChangeRight == false)){
            NextButtonn.backgroundColor = .mybrown
            NextButtonn.setTitleColor(.white, for: .normal) // 평상시
            NextButtonn.setTitleColor(.white, for: .selected) // 선택됐을때
            NextButtonn.isEnabled = true
            // 이웃 로직 타기 (화면 넘어가기)
                
            
            
           }
        else if ((isChangeRight == true) && (isChangeLeft == false)){
            NextButtonn.backgroundColor = .mybrown
            NextButtonn.setTitleColor(.white, for: .normal) // 평상시
            NextButtonn.setTitleColor(.white, for: .selected) // 선택됐을때
            NextButtonn.isEnabled = true
            // 가게 로직 타기(화면 넘어가기)
        }
        else {
            NextButtonn.backgroundColor = .white
            NextButtonn.setTitleColor(.mybrown, for: .normal) // 평상시
            NextButtonn.setTitleColor(.mybrown, for: .selected)
            NextButtonn.isEnabled = false
           }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NextButtonn.isEnabled = false
        
        leftgray = UIImage(named: "leftgray")
        leftorange = UIImage(named: "leftorange")
        rightgray = UIImage(named: "rightgray")
        rightorange = UIImage(named: "rightorange")


        BigWord1.textColor = UIColor(named:"mygray")
        BigWord2.textColor = UIColor(named:"mygray")
        SmallWord1.textColor = UIColor(named:"mygray")
        SmallWord2.textColor = UIColor(named:"mygray")
        
        
        let mybrown = UIColor(named: "mybrown")
        let myorange = UIColor(named: "myorange")
        
        // navigation : back button custom
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
        //progressView2
        ProgressView2.progressViewStyle = .default
        ProgressView2.progressTintColor = .myorange
        ProgressView2.progress = 0.33
        
       
        // 다음 버튼
        NextButtonn.layer.borderWidth = 1.0
        NextButtonn.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        NextButtonn.layer.cornerRadius = 4.0
        NextButtonn.setTitle("다음", for: .normal)  // 버튼 텍스트 설정
        NextButtonn.setTitleColor(UIColor.mybrown, for: .normal)//버튼 텍스트 색상 설정
        NextButtonn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_bold", size: 16) //폰트 및 사이즈 설정

        
        LeftBow.addTarget(self, action: #selector(NextButtonndidChanged), for:.touchUpInside)
        RightBow.addTarget(self, action: #selector(NextButtonndidChanged), for:.touchUpInside)
        
    }
    

}


