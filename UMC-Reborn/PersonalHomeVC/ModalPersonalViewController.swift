//
//  ModalPersonalViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/14.
//

import UIKit

class ModalPersonalViewController: UIViewController {
    
    var storeIdm1: Int = 0
    
    let modalperson = UserDefaults.standard.integer(forKey: "userIndex")
    
    var rebornDatas: [RebornListModel] = []
    var jjimDatas: [JjimListModel] = []
    
    var rebornData:JjimresultModel!
    
    @IBOutlet var storeImage: UIImageView!
    @IBOutlet var modalButton: UIButton!
    @IBOutlet var modalView: UIView!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var reviewLabel: UILabel!
    @IBOutlet var rebornLabel: UILabel!
    @IBOutlet var jjimLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

//        let fullText = modalButton.titleLabel?.text
//        let attributedString = NSMutableAttributedString(string: fullText ?? "")
//
//        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 255/255, green: 77/255, blue: 21/255, alpha: 1), range: (fullText! as NSString).range(of: "진행중"))
//        self.modalButton.setAttributedTitle(attributedString, for: .normal)

        modalButton.layer.cornerRadius = 5
        modalButton.layer.borderWidth = 1
        modalButton.layer.borderColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1).cgColor
        
        modalView.clipsToBounds = true
        modalView.layer.cornerRadius = 10
        modalView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        
        storeResult()
        rebornResult()
        JjimResult()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("DismissDetailView12"), object: nil, userInfo: nil)
    }
    
    @IBAction func jjimTapped(_ sender: Any) {
        if (likeButton.image(for: .selected) == UIImage(named: "ic_like")) {
            likeButton.isSelected = false
            likeButton.setImage(UIImage(named: "ic_like_gray"), for: .normal)
            likeButton.setImage(UIImage(named: "ic_like_gray"), for: .selected)
            likeButton.tintColor = .clear
        } else {
            let parmeterData = JjimModel(storeIdx: storeIdm1, userIdx: modalperson)
            APIHandlerJjimPost.instance.SendingPostJjim(parameters: parmeterData) { result in self.rebornData = result
            }
            likeButton.isSelected = true
            likeButton.setImage(UIImage(named: "ic_like"), for: .selected)
            likeButton.tintColor = .clear
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func JjimResult() {

        let url = APIConstants.baseURL + "/jjim/\(String(modalperson))"
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
                    let decodedData = try JSONDecoder().decode(JjimList.self, from: safeData)
                    self.jjimDatas = decodedData.result
                    print(jjimDatas)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                        print("정렬순: \(self.jjimDatas.count)")
                        for i in 0...self.jjimDatas.count-1 {
                            if (self.jjimDatas[i].storeIdx == self.storeIdm1) {
                                self.likeButton.setImage(UIImage(named: "ic_like"), for: .normal)
                                break
                            } else {
                                self.likeButton.setImage(UIImage(named: "ic_like_gray"), for: .normal)
                            }
                        }
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
    
    func storeResult() {
        
        let url = APIConstants.baseURL + "/store/\(storeIdm1)"
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
                        self.nameLabel.text = "\(storeDatas.storeName)"
                        let url = URL(string: storeDatas.storeImage ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/6f9043df-c35f-4f57-9212-cccaa0091315.png")
                        self.storeImage.load(url: url!)
                        self.addressLabel.text = "\(storeDatas.storeAddress)"
                        self.descriptionLabel.text = "\(storeDatas.storeDescription)"
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
        
        let url = APIConstants.baseURL + "/reborns/store/\(String(storeIdm1))/status?status="
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
