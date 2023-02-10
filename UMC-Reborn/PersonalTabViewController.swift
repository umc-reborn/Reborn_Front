//
//  PersonalTabViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/02/10.
//

import UIKit

class PersonalTabViewController: UITabBarController {

    var userIdx: Int = 0
    var userNickname: String = ""
    var jwt:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        UserDefaults.standard.set(userIdx, forKey: "userIndex")
        UserDefaults.standard.set(userNickname, forKey:"userNickName")
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
