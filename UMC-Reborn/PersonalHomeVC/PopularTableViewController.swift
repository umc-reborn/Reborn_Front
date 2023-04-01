//
//  PopularSideDishViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/18.
//

import UIKit

class PopularTableViewController: UIViewController {
    
    var tabName : String = ""
    var popularshopDatas: [PopularShopResponse] = []
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var categoryListTableView: UITableView!

    @IBOutlet weak var backgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadow()
        
        categoryListTableView.delegate = self
        categoryListTableView.dataSource = self
        
        categoryListTableView.separatorStyle = .singleLine
        categoryListTableView.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 20)
        categoryListTableView.separatorInsetReference = .fromAutomaticInsets
        categoryListTableView.separatorColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        popularstoreAPI()
    }
    // MARK: - API
    func popularstoreAPI(){
       let category = tabName
        var url = APIConstants.baseURL + "/store/popular?category=\(category)"
        let encodedStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let url = URL(string: encodedStr) else { print("err"); return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { [self] data, response, error in
            // error 발생 시 리턴
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
                // Data 타입을 String 타입으로 변환
//                print(String(decoding: safeData, as: UTF8.self))
                        
                do {
                    let decoder = JSONDecoder()

                    var decodedData = try decoder.decode(PopularShopModel.self, from: safeData)
                    decodedData.result.sort { $0.storeName.count < $1.storeName.count }
//
                    self.popularshopDatas = decodedData.result
                    DispatchQueue.main.async {
                        self.categoryListTableView.reloadData()
                    }

                } catch {
                    print("Error")
                }
            }
        }.resume()  // 일시정지 상태로 작업이 부여된 URLSession에 작업 부여(작업 시작)
    }
    
    private func addShadow(){
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.shadowOffset = CGSize(width: 2, height: 0)
        backgroundView.layer.shadowOpacity = 0.15
        backgroundView.layer.shadowRadius = 8
//        backgroundView.layer.masksToBounds = true
        backgroundView.clipsToBounds = true
        backgroundView.layer.masksToBounds = false
    }


}

// MARK: - Extensions
extension PopularTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularshopDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PopularListCell", for: indexPath) as! CategoryTableViewCell
        
        let popularshopData = popularshopDatas[indexPath.row]
        cell.shopnameLabel.text = popularshopData.storeName
        cell.locationLabel.text = popularshopData.storeAddress
        cell.shopScore.text = String(popularshopData.storeScore)
        let url = URL(string: popularshopData.storeImage)
        cell.shopImg.load(url: url!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            switch indexPath.row {
            case 0:
                guard let svc1 = self.storyboard?.instantiateViewController(identifier: "ModalPersonalViewController") as? ModalPersonalViewController else { return }
                svc1.storeIdm1 = popularshopDatas[0].storeIdx
//                svc2.storeIdm2 = popularshopDatas[0].storeIdx
//                svc3.storeIdm3 = popularshopDatas[0].storeIdx
                UserDefaults.standard.set(popularshopDatas[0].storeIdx, forKey: "storeid")
                self.present(svc1, animated: true)
            case 1:
                guard let svc1 = self.storyboard?.instantiateViewController(identifier: "ModalPersonalViewController") as? ModalPersonalViewController else { return }
                svc1.storeIdm1 = popularshopDatas[1].storeIdx
//                svc2.storeIdm2 = popularshopDatas[0].storeIdx
//                svc3.storeIdm3 = popularshopDatas[0].storeIdx
                UserDefaults.standard.set(popularshopDatas[1].storeIdx, forKey: "storeid")
                self.present(svc1, animated: true)
            case 2:
                guard let svc1 = self.storyboard?.instantiateViewController(identifier: "ModalPersonalViewController") as? ModalPersonalViewController else { return }
                svc1.storeIdm1 = popularshopDatas[2].storeIdx
//                svc2.storeIdm2 = popularshopDatas[0].storeIdx
//                svc3.storeIdm3 = popularshopDatas[0].storeIdx
                UserDefaults.standard.set(popularshopDatas[2].storeIdx, forKey: "storeid")
                self.present(svc1, animated: true)
            default:
                return
            }
    }

}

