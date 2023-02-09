//
//  FirstMainViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/26.
//

import UIKit

class FirstMainViewController: UIViewController {
    
//    let StoreArray = ["가나다라마바사아", "챱챱챱챱챱스테이크"]
//    let FoodArray = ["맛있는우유식빵", "쫀득쫀득쫀득도넛"]
//    let CountArray = ["1", "2"]
//    let TimeArray = ["09:12", "10:13"]
    
    var rebornWholeDatas: [RebornStatusListModel] = []
    
    @IBOutlet weak var StoreFirsttableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        StoreFirsttableView.delegate = self
        StoreFirsttableView.dataSource = self
        StoreFirsttableView.rowHeight = UITableView.automaticDimension
        StoreFirsttableView.estimatedRowHeight = UITableView.automaticDimension
        StoreFirsttableView.contentInset = .zero
        StoreFirsttableView.contentInsetAdjustmentBehavior = .never
        StoreFirsttableView.layer.masksToBounds = true // any value you want
        StoreFirsttableView.layer.shadowOpacity = 0.1// any value you want
        StoreFirsttableView.layer.shadowRadius = 10 // any value you want
        StoreFirsttableView.layer.shadowOffset = .init(width: 5, height: 10)
        
        rebornWholeResult()
    }
    
    func rebornWholeResult() {
        
        let url = APIConstants.baseURL + "/reborns/store/page/1/status?status="
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
                    self.rebornWholeDatas = decodedData.result
                    print(rebornWholeDatas)
                    DispatchQueue.main.async {
                        self.StoreFirsttableView.reloadData()
                        print("count: \(self.rebornWholeDatas.count)")
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

    @objc func shareButtonTapped(sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CodeViewController") as? CodeViewController else { return }
        nextVC.modalPresentationStyle = .overCurrentContext
        self.present(nextVC, animated: true, completion: nil)
    }

}
