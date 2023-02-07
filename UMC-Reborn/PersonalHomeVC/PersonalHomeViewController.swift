//
//  PersonalHomeViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/11.
//

import UIKit

class PersonalHomeViewController: UIViewController {

    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var defaultSubLabel: UILabel!
    @IBOutlet weak var defaultLabel: UILabel!
    @IBOutlet weak var umcimg: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    let button = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addShadow()
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


    
    private func addShadow(){
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.borderWidth = 0
        backgroundView.layer.borderColor = UIColor.black.cgColor
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 2, height: 0)
        backgroundView.layer.shadowOpacity = 0.15
        backgroundView.layer.shadowRadius = 8
        backgroundView.layer.masksToBounds = true
        backgroundView.layer.masksToBounds = false
    }
    


}
