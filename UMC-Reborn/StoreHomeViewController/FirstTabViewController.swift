//
//  FirstTabViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/25.
//

import UIKit

class FirstTabViewController: UIViewController {
    
    let firstTab = UserDefaults.standard.integer(forKey: "userIdx")
    
    var keyword : String = ""
    
    var rebornDatas: [RebornListModel] = []
    
    @IBOutlet weak var FTtableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FTtableView.delegate = self
        FTtableView.dataSource = self
        FTtableView.rowHeight = UITableView.automaticDimension
        FTtableView.estimatedRowHeight = UITableView.automaticDimension
        
        FTtableView.layer.masksToBounds = true // any value you want
        FTtableView.layer.shadowOpacity = 0.1// any value you want
        FTtableView.layer.shadowRadius = 10 // any value you want
        FTtableView.layer.shadowOffset = .init(width: 5, height: 10)
        
        rebornResult()
    }
    
    func rebornResult() {
        
        let text = keyword
        
        let url = APIConstants.baseURL + "/reborns/store/\(String(firstTab))/status?status="
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
                        self.FTtableView.reloadData()
                        print("count: \(self.rebornDatas.count)")
                    }
                } catch {
                    print("Error")
                }
            }
        }.resume()
    }
}
    

extension FirstTabViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return rebornDatas.count
    }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell: FirstTabTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FirstTab_TableViewCell", for: indexPath) as! FirstTabTableViewCell
            
        let rebornData = rebornDatas[indexPath.section]
        let url = URL(string: rebornData.productImg ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/6f9043df-c35f-4f57-9212-cccaa0091315.png")
        cell.FTimageView.load(url: url!)
        cell.foodName.text = rebornData.productName
        cell.countLabel.text = "남은 수량: \(String(rebornData.productCnt))"
        cell.DescriptionLabel.text = rebornData.productComment
        cell.LimitLabel.text = rebornData.productGuide
        
        if (rebornData.status == "ACTIVE") {
            cell.timeImage.isHidden = false
            cell.limitTimeLabel.isHidden = false
            cell.rebornButton.isHidden = false
        } else {
            cell.timeImage.isHidden = true
//            cell.timeImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
            cell.limitTimeLabel.isHidden = true
            cell.rebornButton.isHidden = true
//            cell.limitTimeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        }
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rebornData = rebornDatas[indexPath.section]
        if (rebornData.status == "ACTIVE") {
            return 176
        } else {
            return 111
        }
    }
}

