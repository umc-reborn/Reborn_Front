//
//  PopularSideDishViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/18.
//

import UIKit

class PopularSideDishViewController: UIViewController {
    
    var tabName : String = ""
    var shopList: [String] = ["베이커리","어쩌구","저쩌구"]
    var locationList: [String] = ["연남동","홍제동","연희동"]
    var popularshopDatas: [PopularShopResponse] = []
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var categoryListTableView: UITableView!

    @IBOutlet weak var backgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadow()
        
        categoryListTableView.delegate = self
        categoryListTableView.dataSource = self
        popularstoreAPI()
    }
    // MARK: - API
    func popularstoreAPI(){
       let category = tabName
        var url = APIConstants.baseURL + "/store/popular?category=\(category)"
        let encodedStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        // 문자열 타입의 URL을 구조체 타입의 URL로 변환
        guard let url = URL(string: encodedStr) else { print("err"); return }

        // URLRequest 구조체 사용 (GET 이외의 요청 가능)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // URL Session 생성 (서버랑 통신하는 객체 ~= 브라우저)
        // dataTask -> 비동기적으로 처리됨
        URLSession.shared.dataTask(with: request) { [self] data, response, error in
            // error 발생 시 리턴
            if error != nil {
                print("err")
                return
            }

            // 응답코드에 따른 처리
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~=
            response.statusCode else {
                print("Error: HTTP request failed")
                return
            }

            // 데이터가 존재하면 출력
            if let safeData = data {
                // Data 타입을 String 타입으로 변환
                print(String(decoding: safeData, as: UTF8.self))
                        
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

// MARK: - Extensions
extension PopularSideDishViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularshopDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PopularListCell", for: indexPath) as! CategoryTableViewCell
        
//        cell.shopnameLabel.text = shopList[indexPath.row]
//        cell.locationLabel.text = locationList[indexPath.row]
        
        let popularshopData = popularshopDatas[indexPath.row]
        cell.shopnameLabel.text = popularshopData.storeName
        cell.locationLabel.text = popularshopData.storeAddress
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    
}

