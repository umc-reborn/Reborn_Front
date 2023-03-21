//
//  StoreTabBarController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/13.
//

import UIKit

class StoreTabBarController: UITabBarController {
    
    var storeText: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor(red: 255/255, green: 77/255, blue: 21/255, alpha: 1.0)
        tabBar.unselectedItemTintColor = UIColor.black
        tabBar.backgroundColor = .white
        tabBar.layer.cornerRadius = 25
        tabBar.layer.masksToBounds = false
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .clear
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        UserDefaults.standard.set(storeText, forKey: "userIdx")
        setupStyle()
    }
    
    func setupStyle() {
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
    }
}
