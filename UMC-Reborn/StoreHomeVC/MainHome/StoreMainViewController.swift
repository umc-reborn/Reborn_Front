//
//  StoreMainViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/13.
//

import UIKit

class StoreMainViewController: UIViewController {
    
    var storeMain = UserDefaults.standard.integer(forKey: "userIdx")
    
    @IBOutlet weak var storemainView: UIView!
    @IBOutlet weak var storemainLabel: UILabel!
    @IBOutlet var storeName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storemainView.clipsToBounds = true
        storemainView.layer.cornerRadius = 20
        storemainView.layer.masksToBounds = false
        storemainView.layer.shadowOffset = CGSize(width: 5, height: 10)
        storemainView.layer.shadowRadius = 10
        storemainView.layer.shadowOpacity = 0.1
        
        let attributedString = NSMutableAttributedString(string: storemainLabel.text!, attributes: [
            .font: UIFont.systemFont(ofSize: 15, weight: .regular),
            .foregroundColor: UIColor(white: 0.0, alpha: 1.0),
            .kern: -0.01
        ])
        
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 15, weight: .bold), range: (storemainLabel.text! as NSString).range(of: "다시 태어나게"))
        
        self.storemainLabel.attributedText = attributedString
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
              self.storeResult()
        }
    }
    
    func storeResult() {
        
        let url = APIConstants.baseURL + "/store/\(String(storeMain))"
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
    
    
    @IBAction func enrollButton(_ sender: Any) {
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "RebornEnrollViewController") as? RebornEnrollViewController else {return}
        
        self.navigationController?.pushViewController(rvc, animated: true)
    }
}
