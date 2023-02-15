//
//  ModalFirstViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/15.
//

import UIKit

class ModalFirstViewController: UIViewController {
    
    var rebornDatas: [RebornListModel] = []
    
    var storeIdm2: Int = 0
    
    
    @IBOutlet var mftableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mftableView.delegate = self
        mftableView.dataSource = self
        mftableView.rowHeight = UITableView.automaticDimension
        mftableView.estimatedRowHeight = UITableView.automaticDimension
        
        mftableView.layer.masksToBounds = true // any value you want
        mftableView.layer.shadowOpacity = 0.1// any value you want
        mftableView.layer.shadowRadius = 10 // any value you want
        mftableView.layer.shadowOffset = .init(width: 5, height: 10)
        
        rebornResult()
    }
    
    func rebornResult() {
        
//        let text = keyword
        
        let url = APIConstants.baseURL + "/reborns/store/\(String(storeIdm2))/status?status="
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
                        self.mftableView.reloadData()
                        print("count: \(self.rebornDatas.count)")
                    }
                } catch {
                    print("Error")
                }
            }
        }.resume()
    }
    
    
}

extension ModalFirstViewController: UITableViewDelegate, UITableViewDataSource {
    
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
            
        let cell: ModalFirstTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ModalFirst_TableViewCell", for: indexPath) as! ModalFirstTableViewCell
            
        let rebornData = rebornDatas[indexPath.section]
        let url = URL(string: rebornData.productImg ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/6f9043df-c35f-4f57-9212-cccaa0091315.png")
        cell.mfImageView.load(url: url!)
        cell.foodName.text = rebornData.productName
        cell.countLabel.text = "남은 수량: \(String(rebornData.productCnt))"
        cell.descriptionLabel.text = rebornData.productComment
        cell.cautionLabel.text = rebornData.productGuide
        
        if (rebornData.status == "ACTIVE") {
            cell.timeImage.isHidden = false
            cell.timeLabel.isHidden = false
            cell.rebornButton.isHidden = false
        } else {
            cell.timeImage.isHidden = true
//            cell.timeImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
            cell.timeLabel.isHidden = true
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
