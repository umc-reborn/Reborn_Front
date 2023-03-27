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
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBar.tintColor = UIColor(red: 255/255, green: 77/255, blue: 21/255, alpha: 1.0)
        tabBar.unselectedItemTintColor = UIColor.black
        tabBar.backgroundColor = .white
        tabBar.layer.cornerRadius = 30
        tabBar.layer.masksToBounds = false
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        UserDefaults.standard.set(userIdx, forKey: "userIndex")
        UserDefaults.standard.set(userNickname, forKey:"userNickName")
        setupStyle()
    }
    
    func setupStyle() {
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
    }
}
