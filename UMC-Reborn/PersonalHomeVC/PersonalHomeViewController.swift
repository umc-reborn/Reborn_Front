//
//  PersonalHomeViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/11.
//

import UIKit



class PersonalHomeViewController: UIViewController {

    
    var userText : Int = 0
    var userNickNameText : String = ""
    let username = UserDefaults.standard.string(forKey: "userNickName")

    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let button = UIButton(type: .system)
   
//    let userNickName = UserDefaults.standard.integer(forKey: "userNickName")
    // var userid : String = "1"
//    let userIdx = UserDefaults.standard.integer(forKey: "userIndex")
    override func viewDidLoad() {
        super.viewDidLoad()
        nickNameLabel.text = "\(username!)"
        contentView.addSubview(floatingButton)
        
        NSLayoutConstraint.activate([
                   
        // 화면에 계속 보여지도록 frameLayout에 맞춰 floatingButton 추가
        floatingButton.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor, constant: -20),
        floatingButton.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -10)
        ])
    }

    let floatingButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light)
        let image = UIImage(systemName: "map", withConfiguration: imageConfig)
        
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
        // 버튼 넓이 300
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "MainColor")
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
//        button.setImage(UIImage(systemName: "map"), for: .normal)
        return button
    }()
    
    @objc func addButtonAction(_ sender: UIButton){
//            self.selectedIndex = 700
        let MapVC = UIStoryboard.init(name: "StoreMap", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        
//        MapVC.modalTransitionStyle = .coverVertical
        MapVC.modalPresentationStyle = .automatic
        
        self.present(MapVC, animated: true, completion: nil)
    }
}
