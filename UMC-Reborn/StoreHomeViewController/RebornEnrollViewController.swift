//
//  RebornEnrollViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/13.
//

import UIKit

class RebornEnrollViewController: UIViewController {
    
    var rebornEnroll = UserDefaults.standard.integer(forKey: "userIdx")
    
    var storeText2: Int = 0
    
    var rebornDatas: [RebornListModel] = []
    var rebornData: RebornDeleteresultModel!
    var rebornActiveData: RebornActiveresultModel!
    
    @IBOutlet weak var EnrollTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        EnrollTableView.rowHeight = UITableView.automaticDimension
        EnrollTableView.estimatedRowHeight = UITableView.automaticDimension
        
        EnrollTableView.delegate = self
        EnrollTableView.dataSource = self
        EnrollTableView.layer.masksToBounds = true// any value you want
        EnrollTableView.layer.shadowOpacity = 0.1// any value you want
        EnrollTableView.layer.shadowRadius = 10 // any value you want
        EnrollTableView.layer.shadowOffset = .init(width: 5, height: 10)
        
        rebornResult()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didDismissDetailNotification(_:)),
            name: NSNotification.Name("DismissDetailView"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didDismissDetailNotification2(_:)),
            name: NSNotification.Name("DismissDetailView2"),
            object: nil
        )
        
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(self.startTimerNotification(_:)),
//            name: NSNotification.Name("StartTimer"),
//            object: nil
//        )
    }
    
//    @objc func startTimerNotification(_ notification: Notification) {
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
//
//
//          }
//      }
    
    @objc func didDismissDetailNotification(_ notification: Notification) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
              
              self.rebornResult()
          }
      }
    
    @objc func didDismissDetailNotification2(_ notification: Notification) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
              
              self.rebornResult()
          }
      }
    
    func rebornResult() {
        
        let url = APIConstants.baseURL + "/reborns/store/\(String(rebornEnroll))/status?status="
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
                    DispatchQueue.main.async {
                        self.EnrollTableView.reloadData()
                        print("count: \(self.rebornDatas.count)")
                        
                    }
                } catch {
                    print("Error")
                }
            }
        }.resume()
    }
    

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
