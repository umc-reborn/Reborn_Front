//
//  StoreManageViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/13.
//

import UIKit

class StoreManageViewController: UIViewController {
    
    var storeManage = UserDefaults.standard.integer(forKey: "userIdx")
    var shopToken = UserDefaults.standard.string(forKey: "shopJwt")
    
    var rebornData: LogoutresultModel!
    var rebornDatas: UserDeleteresultModel!
    
    @IBOutlet weak var storeView: UIView!
    @IBOutlet weak var ManageImageView: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeCategory: UILabel!
    @IBOutlet weak var storeIntroduce: UILabel!
    @IBOutlet weak var storeAddress: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var rebornLabel: UILabel!
    @IBOutlet weak var jjimLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ManageImageView.layer.cornerRadius = 10
        ManageImageView.clipsToBounds = true
        
        self.navigationController?.navigationBar.topItem?.title = "가게 관리"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)]

        storeView.clipsToBounds = true
        storeView.layer.cornerRadius = 20
        storeView.layer.masksToBounds = false
        storeView.layer.shadowOffset = CGSize(width: 3, height: 8)
        storeView.layer.shadowRadius = 20
        storeView.layer.shadowOpacity = 0.1
        
        let attributedString = NSMutableAttributedString(string: reviewLabel.text!, attributes: [
            .font: UIFont(name: "AppleSDGothicNeo-Bold", size: 13) ?? UIFont.systemFont(ofSize: 13),
            .foregroundColor: UIColor(white: 0.0, alpha: 1.0),
            .kern: -0.01
        ])
        attributedString.addAttribute(.font, value: UIFont(name: "AppleSDGothicNeo-Bold", size: 13) ?? UIFont.systemFont(ofSize: 13), range: (reviewLabel.text! as NSString).range(of: "41"))
        self.reviewLabel.attributedText = attributedString
        
        let attributedString1 = NSMutableAttributedString(string: rebornLabel.text!, attributes: [
            .font: UIFont(name: "AppleSDGothicNeo-Bold", size: 13) ?? UIFont.systemFont(ofSize: 13),
            .foregroundColor: UIColor(white: 0.0, alpha: 1.0),
            .kern: -0.01
        ])
        attributedString1.addAttribute(.font, value: UIFont(name: "AppleSDGothicNeo-Bold", size: 13) ?? UIFont.systemFont(ofSize: 13), range: (rebornLabel.text! as NSString).range(of: "64"))
        self.rebornLabel.attributedText = attributedString1
        
        let attributedString2 = NSMutableAttributedString(string: jjimLabel.text!, attributes: [
            .font: UIFont(name: "AppleSDGothicNeo-Bold", size: 13) ?? UIFont.systemFont(ofSize: 13),
            .foregroundColor: UIColor(white: 0.0, alpha: 1.0),
            .kern: -0.01
        ])
        attributedString2.addAttribute(.font, value: UIFont(name: "AppleSDGothicNeo-Bold", size: 13) ?? UIFont.systemFont(ofSize: 13), range: (jjimLabel.text! as NSString).range(of: "64"))
        self.jjimLabel.attributedText = attributedString2
        
        NotificationCenter.default.addObserver(
                  self,
                  selector: #selector(self.didDismissDetailNotification(_:)),
                  name: NSNotification.Name("DismissDetailView8"),
                  object: nil
        )
        
        storeResult()
    }
    
    @objc func didDismissDetailNotification(_ notification: Notification) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.storeResult()
        }
    }
    
    func storeResult() {
        
        let url = APIConstants.baseURL + "/store/\(String(storeManage))"
        let encodedStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let url = URL(string: encodedStr) else { print("err"); return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
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
                    let decodedData = try decoder.decode(StoreList.self, from: safeData)
                    let storeDatas = decodedData.result
                    print(storeDatas)
                    DispatchQueue.main.async {
                        self.storeName.text = "\(storeDatas.storeName)"
                        let url = URL(string: storeDatas.userImage ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/6f9043df-c35f-4f57-9212-cccaa0091315.png")
                        self.ManageImageView.load(url: url!)
                        self.storeAddress.text = "\(storeDatas.storeAddress)"
                        self.storeIntroduce.text = "\(storeDatas.storeDescription)"
                        if (storeDatas.category == "CAFE") {
                            self.storeCategory.text = "카페·디저트"
                        } else if (storeDatas.category == "FASHION") {
                            self.storeCategory.text = "패션"
                        } else if (storeDatas.category == "SIDEDISH") {
                            self.storeCategory.text = "반찬"
                        } else if (storeDatas.category == "LIFE") {
                            self.storeCategory.text = "편의·생활"
                        } else {
                            self.storeCategory.text = "기타"
                        }
                        self.scoreLabel.text = "\(String(storeDatas.storeScore))"
                        self.reviewLabel.text = "\(String(storeDatas.numOfReview))개"
                        self.jjimLabel.text = "\(String(storeDatas.numOfJjim))개"
                        self.rebornLabel.text = "\(String(storeDatas.numOfReborn))회"
                    }
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }
        }.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title="가게 관리"
    }
    
    @IBAction func editButton(_ sender: Any) {
        guard let svc2 = self.storyboard?.instantiateViewController(identifier: "EditStoreViewController") as? EditStoreViewController else {
            return
        }
        
        self.navigationController?.pushViewController(svc2, animated: true)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        guard let svc1 = self.storyboard?.instantiateViewController(identifier: "ModalStoreViewController") as? ModalStoreViewController else {
            return
        }
        
        self.present(svc1, animated: true)
    }
    
    @IBAction func pwchangeButton(_ sender: Any) {
        guard let svc2 = self.storyboard?.instantiateViewController(identifier: "PWChangeViewController") as? PWChangeViewController else {
            return
        }
        
        self.navigationController?.pushViewController(svc2, animated: true)
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        let parameterDatas = LogoutModel(jwt: shopToken ?? "")
        APIHandlerLogoutPost.instance.SendingPostReborn(token: shopToken ?? "", parameters: parameterDatas) { result in self.rebornData = result }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            let goLogin = UIStoryboard.init(name: "JoinLogin", bundle: nil)
            guard let rvc = goLogin.instantiateViewController(withIdentifier: "FirstLoginViewController") as? FirstLoginViewController else {return}
            self.present(rvc, animated: true)
        }
    }
    
    @IBAction func deleteuserButton(_ sender: Any) {
        let parameterDatas = UserDeleteModel(userIdx: storeManage, status: "DELETE")
        APIHandlerUserDeletePost.instance.SendingPostReborn(token: shopToken ?? "", parameters: parameterDatas) { result in self.rebornDatas = result }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            let goLogin = UIStoryboard.init(name: "JoinLogin", bundle: nil)
            guard let rvc = goLogin.instantiateViewController(withIdentifier: "FirstLoginViewController") as? FirstLoginViewController else {return}
            self.present(rvc, animated: true, completion: nil)
        }
    }
}
