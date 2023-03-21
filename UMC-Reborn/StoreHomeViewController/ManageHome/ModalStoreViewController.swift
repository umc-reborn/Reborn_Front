//
//  ModalStoreViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/27.
//

import UIKit

class ModalStoreViewController: UIViewController {
    
    var modalStore = UserDefaults.standard.integer(forKey: "userIdx")
    
    var rebornDatas: [RebornListModel] = []
    
    var storeIdm: Int = 0
    
    @IBOutlet var storeBigImage: UIImageView!
    @IBOutlet weak var modalButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var bellButton: UIButton!
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet var reviewLabel: UILabel!
    @IBOutlet var rebornLabel: UILabel!
    @IBOutlet var jjimLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        modalButton.layer.cornerRadius = 5
        modalButton.layer.borderWidth = 1
        modalButton.layer.borderColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1).cgColor
        
        modalView.clipsToBounds = true
        modalView.layer.cornerRadius = 10
        modalView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        
        storeResult()
        rebornResult()
        print("리본 데이터의 수는? \(rebornDatas.count)")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            if (self.rebornDatas.count > 0) {
                let fullText = self.modalButton.titleLabel?.text
                let attributedString = NSMutableAttributedString(string: fullText ?? "")
                
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 255/255, green: 77/255, blue: 21/255, alpha: 1), range: (fullText! as NSString).range(of: "진행중"))
                self.modalButton.setAttributedTitle(attributedString, for: .normal)
            } else {
                self.modalButton.setTitle("진행중인 리본이 없습니다.", for: .normal)
            }
        }
    }
    

    @IBAction func tappedlike(_ sender: Any) {
        if (likeButton.image(for: .selected) == UIImage(named: "ic_like")) {
            likeButton.isSelected = false
            likeButton.setImage(UIImage(named: "ic_like_gray"), for: .normal)
            likeButton.setImage(UIImage(named: "ic_like_gray"), for: .selected)
            likeButton.tintColor = .clear
        } else {
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
        if (modalButton.title(for: .normal) == "리본이 진행중 입니다!") {
            modalButton.isSelected = true
            modalButton.setTitle("진행중인 리본이 없습니다.", for: .normal)
            modalButton.setTitle("진행중인 리본이 없습니다.", for: .selected)
            modalButton.setTitleColor(UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1), for: .normal)
            modalButton.setTitleColor(UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1), for: .selected)
        } else {
            modalButton.isSelected = false
            modalButton.setTitle("리본이 진행중 입니다!", for: .normal)
            modalButton.setTitleColor(UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1), for: .normal)
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
                        let url = URL(string: storeDatas.storeImage ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/6f9043df-c35f-4f57-9212-cccaa0091315.png")
                        self.storeBigImage.load(url: url!)
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
                        self.reviewLabel.text = "리뷰수 \(String(storeDatas.numOfReview))개"
                        self.jjimLabel.text = "찜 \(String(storeDatas.numOfJjim))개"
                        self.rebornLabel.text = "리본 \(String(storeDatas.numOfReborn))회"
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
    
    func rebornResult() {
        
        let url = APIConstants.baseURL + "/reborns/store/\(String(modalStore))/status?status="
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
                    let decodedData = try JSONDecoder().decode(RebornList.self, from: safeData)
                    self.rebornDatas = decodedData.result
                    print(rebornDatas)
                } catch {
                    print("Error")
                }
            }
        }.resume()
    }
}
