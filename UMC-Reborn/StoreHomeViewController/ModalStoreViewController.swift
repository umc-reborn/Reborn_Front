//
//  ModalStoreViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/27.
//

import UIKit

class ModalStoreViewController: UIViewController {
    
    let modalStore = UserDefaults.standard.integer(forKey: "userIdx")
    
    var rebornData:JjimresultModel!
    
    @IBOutlet weak var modalButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var bellButton: UIButton!
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        modalButton.layer.cornerRadius = 5
        modalButton.layer.borderWidth = 1
        modalButton.layer.borderColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1).cgColor
        
        modalView.clipsToBounds = true
        modalView.layer.cornerRadius = 10
        modalView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        
        storeResult()
    }
    

    @IBAction func tappedlike(_ sender: Any) {
        if (likeButton.image(for: .selected) == UIImage(named: "ic_like")) {
            likeButton.isSelected = false
            likeButton.setImage(UIImage(named: "ic_like_gray"), for: .normal)
            likeButton.setImage(UIImage(named: "ic_like_gray"), for: .selected)
            likeButton.tintColor = .clear
        } else {
            let parmeterData = JjimModel(storeIdx: 1, userIdx: 2)
            APIHandlerJjimPost.instance.SendingPostJjim(parameters: parmeterData) { result in self.rebornData = result
            }
            likeButton.isSelected = true
            likeButton.setImage(UIImage(named: "ic_like"), for: .selected)
            likeButton.tintColor = .clear
        }
    }
    
    @IBAction func tappedbell(_ sender: Any) {
        if (bellButton.image(for: .selected) == UIImage(named: "ic_bell")) {
            bellButton.isSelected = false
            bellButton.setImage(UIImage(named: "ic_bell_gray"), for: .normal)
            bellButton.setImage(UIImage(named: "ic_bell_gray"), for: .selected)
            bellButton.tintColor = .clear
        } else {
            bellButton.isSelected = true
            bellButton.setImage(UIImage(named: "ic_bell"), for: .selected)
            bellButton.tintColor = .clear
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startModal(_ sender: Any) {
        if (modalButton.title(for: .selected) == "리본이 진행중 입니다!") {
            modalButton.isSelected = false
            modalButton.setTitle("진행중인 리본이 없습니다.", for: .normal)
            modalButton.setTitle("진행중인 리본이 없습니다.", for: .selected)
            modalButton.setTitleColor(UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1), for: .selected)
            modalButton.setTitleColor(UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1), for: .normal)
        } else {
            modalButton.isSelected = true
            modalButton.setTitle("리본이 진행중 입니다!", for: .selected)
            modalButton.setTitleColor(UIColor(red: 255/255, green: 77/255, blue: 21/255, alpha: 1), for: .selected)
        }
    }
    
    func storeResult() {
        
        let url = APIConstants.baseURL + "/store/\(String(modalStore))"
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
                        self.storeNameLabel.text = "\(storeDatas.storeName)"
//                        let url = URL(string: storeDatas.storeImage ?? "")
//                        self.ManageImageView.load(url: url!)
                        self.addressLabel.text = "\(storeDatas.storeAddress)"
                        self.DescriptionLabel.text = "\(storeDatas.storeDescription)"
                        if (storeDatas.category == "CAFE") {
                            self.categoryLabel.text = "카페·디저트"
                        } else if (storeDatas.category == "FASHION") {
                            self.categoryLabel.text = "패션"
                        } else if (storeDatas.category == "SIDEDISH") {
                            self.categoryLabel.text = "반찬"
                        } else if (storeDatas.category == "LIFE") {
                            self.categoryLabel.text = "편의·생활"
                        } else {
                            self.categoryLabel.text = "기타"
                        }
                        self.scoreLabel.text = "\(String(storeDatas.storeScore))"
                    }
                } catch {
                    print("error")
                }
            }
        }.resume()
    }
}
