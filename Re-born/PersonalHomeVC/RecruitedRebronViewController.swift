//
//  recruitedRebronViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/18.
//

import UIKit

class RecruitedRebronViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var likeshopDatas: [LikeShopsponse] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .clear
        // Do any additional setup after loading the view.
        WillLikeShopService.shared.getLikeShop{ result in
                    switch result {
                    case .success(let response):
                        
//                        dump(response)
                        guard let response = response as? WillLikeShopModel else {
                            break
                        }
                        self.likeshopDatas = response.result
                    
                    default:
                        
                        break
                    }
                    self.collectionView.reloadData()
                }
    }
    
//    func patchCaddieData() {
//
//        let PATCH_URL = APIConstants.willLikeshopURL
//
//        let parameters : [String:Any] = [
//            "first_name"   : editFirstNameField?.text ?? "",
//            "last_name"    : editLastNameField?.text ?? "",
//            "email"        : editEmailField?.text ?? "",
//            "phone_number" : editPhoneNumberField?.text ?? "",
//            "address"      : editAddressField?.text ?? "",
//            "state"        : editStateField?.text ?? "",
//            "zipcode"      : editZipcodeField?.text ?? "",
//            "city"         : editCityField?.text ?? ""
//        ]
//
//        let headers = authHeaders()
//
//        Alamofire.request(PATCH_URL, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200...299).responseData { (patchData) in
//            switch patchData.result {
//            case .success(let value):
//                let json = JSON(value)
//
//                self.caddie.firstName = json["first_name"].string!
//                self.caddie.lastName = json["last_name"].string!
//                self.caddie.email = json["email"].string!
//                self.caddie.phoneNumber = json["phone_number"].string!
//                self.caddie.address = json["address"].string!
//                self.caddie.state = json["state"].string!
//                self.caddie.zipcode = json["zipcode"].string!
//                self.caddie.city = json["city"].string!
//
//
//                self.performSegue(withIdentifier: "unwindtoprofilesegue", sender: self)
//
//            case .failure(let error):
//                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
//                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
//                alert.addAction(action)
//
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
//    }
    

}

extension RecruitedRebronViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likeshopDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecruitedShopCell", for: indexPath) as! RecruitedShopCollectionViewCell
        
        cell.shopImage.layer.cornerRadius = 10
        cell.shopImage.clipsToBounds = true
        cell.layer.borderWidth = 0
        
        let likeshopData = likeshopDatas[indexPath.row]
        cell.shopName.text = likeshopData.storeName
//        cell.Location.text =
        cell.shopLocation.text = likeshopData.category
        cell.score.text = String(likeshopData.storeScore)//        cell.shopImage.image = UIImage(named: imageList[indexPath.row]) ?? UIImage()
        let url = URL(string: likeshopData.userImage!)
        cell.shopImage.load(url: url!)
//        cell.shopImage.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let svc1 = self.storyboard?.instantiateViewController(identifier: "ModalPersonalViewController") as? ModalPersonalViewController else { return }
        svc1.storeIdm1 = likeshopDatas[indexPath.row].storeIdx
        UserDefaults.standard.set(likeshopDatas[indexPath.row].storeIdx, forKey: "storeid")
        self.present(svc1, animated: true)
    }
}
extension RecruitedRebronViewController: UICollectionViewDelegateFlowLayout {
    
    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
        
    }

    // cell 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = 131
        let height = 164

        let size = CGSize(width: width, height: height)
        return size
    }
    
    
}
