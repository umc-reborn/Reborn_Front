//
//  ThirdMainViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/26.
//

import UIKit

class ThirdMainViewController: UIViewController {
    
    var thirdMain = UserDefaults.standard.integer(forKey: "userIdx")
    
    var storethirdText: Int = 0
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.rebornCompleteResult()
        }
    }
    
    func rebornCompleteResult() {
        
        let url = APIConstants.baseURL + "/reborns/store/page/\(String(thirdMain))/status?status=COMPLETE"
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
