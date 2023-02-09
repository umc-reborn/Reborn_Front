//
//  ThirdMainViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/26.
//

import UIKit

class ThirdMainViewController: UIViewController {
    
//    let StoreArray = [["가나다라마바사아"], ["챱챱챱챱챱스테이크"]]
//    let FoodArray = [["맛있는우유식빵"], ["쫀득쫀득쫀득도넛"]]
//    let CountArray = [["1"], ["2"]]
    
    var rebornCompleteDatas: [RebornStatusListModel] = []
    
    @IBOutlet weak var StoreThirdtableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        StoreThirdtableView.delegate = self
        StoreThirdtableView.dataSource = self
        StoreThirdtableView.rowHeight = UITableView.automaticDimension
        StoreThirdtableView.estimatedRowHeight = UITableView.automaticDimension
        StoreThirdtableView.contentInset = .zero
        StoreThirdtableView.contentInsetAdjustmentBehavior = .never
        StoreThirdtableView.layer.masksToBounds = true // any value you want
        StoreThirdtableView.layer.shadowOpacity = 0.1// any value you want
        StoreThirdtableView.layer.shadowRadius = 10 // any value you want
        StoreThirdtableView.layer.shadowOffset = .init(width: 5, height: 10)
        
        rebornCompleteResult()
    }
    
    func rebornCompleteResult() {
        
        let url = APIConstants.baseURL + "/reborns/store/page/1/status?status=COMPLETE"
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
                    let decodedData = try JSONDecoder().decode(RebornStatusList.self, from: safeData)
                    self.rebornCompleteDatas = decodedData.result
                    print(rebornCompleteDatas)
                    DispatchQueue.main.async {
                        self.StoreThirdtableView.reloadData()
                        print("count: \(self.rebornCompleteDatas.count)")
                        
                    }
                } catch {
                    print("Error")
                }
            }
        }.resume()
    }
}
