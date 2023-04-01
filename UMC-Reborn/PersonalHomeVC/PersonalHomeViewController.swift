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
    @IBOutlet var helloLabel: UILabel!
    @IBOutlet var nimLabel: UILabel!
    
    let button = UIButton(type: .system)
    
    var rebornDatas: [InprogressResponse] = []
   
//    let userNickName = UserDefaults.standard.integer(forKey: "userNickName")
    // var userid : String = "1"
//    let userIdx = UserDefaults.standard.integer(forKey: "userIndex")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.InprogressResult()
        }
        
        contentView.addSubview(floatingButton)
        
        NSLayoutConstraint.activate([
                   
        // 화면에 계속 보여지도록 frameLayout에 맞춰 floatingButton 추가
        floatingButton.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor, constant: -20),
        floatingButton.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -10)
        ])
        
        NotificationCenter.default.addObserver(
                  self,
                  selector: #selector(self.didDismissDetailNotification(_:)),
                  name: NSNotification.Name("DismissDetailView10"),
                  object: nil
                  )
    }
    
    @objc func didDismissDetailNotification(_ notification: Notification) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.InprogressResult()
        }
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
    
    func InprogressResult() {
        InprogressService.shared.getInprogress { result in
            switch result {
            case .success(let response):
                //                        dump(response)
                guard let response = response as? InprogressModel else {
                    break
                }
                self.rebornDatas = response.result
//                self.defaultView.backgroundColor = .clear
                print("에러")
                
                if (self.rebornDatas.count > 0) {
                    self.nickNameLabel.text = "\(self.username ?? "")"
                    self.nimLabel.text = "님의"
                    self.helloLabel.text = "진행 중인 리본 입니다."
                } else {
                    self.nickNameLabel.text = "\(self.username ?? "")"
                    self.nimLabel.text = "님"
                    self.helloLabel.text = "안녕하세요!"
                }
            default:
                break
            }
            print("뭐야")
        }
    }
}
