//
//  ServiceViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/01/26.
//

import UIKit






extension UIColor { // 컬러를 이렇게 익스텐션으로 설정해서 쓰면 편하다던데 - asset input method를 8비트로 바꿔주었더니 된다!
    class var myorange: UIColor? { return UIColor(named: "myorange") }

    class var mygray: UIColor? { return UIColor(named: "mygray") }

    class var mybrown: UIColor? { return UIColor(named: "mybrown") }
}

class ServiceViewController: UIViewController {
    
    @IBOutlet weak var NnextButton: UIButton!
    
    @IBOutlet weak var ProgressView: UIProgressView!
    
 
    // 연결
    @IBOutlet weak var BigButton: UIButton!
    
    @IBOutlet weak var SmallButton1: UIButton!
    
    @IBOutlet weak var SmallButton2: UIButton!
    
    @IBOutlet weak var SmallButton3: UIButton!
    
    @IBOutlet weak var SmallButton4: UIButton!
    
    
    @IBAction func BigButtonTapped(_ sender: Any) {
    }
    
    @IBAction func SmallButton1Tapped(_ sender: Any) {
    }
    
    @IBAction func SmallButton2Tapped(_ sender: Any) {
    }
    
    
    @IBAction func SmallButton3Tapped(_ sender: Any) {
    }
    
    @IBAction func SmallButton4Tapped(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        // 폰트는 코드로 안함
        
        
        //progressview
        ProgressView.progressViewStyle = .default
        ProgressView.progressTintColor = .myorange
        ProgressView.progress = 1/6
        
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
