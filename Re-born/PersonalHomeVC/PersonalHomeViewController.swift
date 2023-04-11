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
    var username = UserDefaults.standard.string(forKey: "userNickName")
    var userJWT : String = ""

    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var helloLabel: UILabel!
    @IBOutlet var nimLabel: UILabel!
    
    let button = UIButton(type: .system)
    
    var rebornDatas: [InprogressResponse] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.InprogressResult()
            self.userJWT = UserDefaults.standard.string(forKey: "userJwt") ?? ""
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.userResult()
        }
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
    
    func userResult() {
        
        let url = APIConstants.baseURL + "/users/inform"
        let encodedStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let url = URL(string: encodedStr) else { print("err"); return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        

        print("응답하라 \(userJWT)")
        
        // Header
        request.addValue("\(userJWT)", forHTTPHeaderField: "X-ACCESS-TOKEN")
        
        URLSession.shared.dataTask(with: request) { [self] data, response, error in
            if error != nil {
                print("err")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~=
            response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            if let safeData = data {
                print(String(decoding: safeData, as: UTF8.self))
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(UserList.self, from: safeData)
                    let storeDatas = decodedData.result
                    print(storeDatas)
                    DispatchQueue.main.async {
                        self.nickNameLabel.text = "\(storeDatas.userNickname)"
                        self.username = storeDatas.userNickname
                    }
                } catch {
                    print("error: ", error)
                }
            }
        }.resume()
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
        }
    }
}
