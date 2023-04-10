//
//  ModalFirstViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/15.
//

import UIKit

protocol ComponentProductCellDelegate3 {
    func rebornButtonTapped(index: Int)
}

class ModalFirstViewController: UIViewController {
    
    var rebornDatas: [RebornListModel] = []
    
    var storeIdm2: Int = 0
    
    var modalfirst: Int = 0
    
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
        
        modalfirst = UserDefaults.standard.integer(forKey: "storeid")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.rebornResult()
        }
        
        NotificationCenter.default.addObserver(
                  self,
                  selector: #selector(self.didDismissDetailNotification(_:)),
                  name: NSNotification.Name("DismissDetailView10"),
                  object: nil
                  )
    }
    
    @objc func didDismissDetailNotification(_ notification: Notification) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            
            self.rebornResult()
        }
    }
    
    func rebornResult() {
        let url = APIConstants.baseURL + "/reborns/store/\(String(modalfirst))/status?status="
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
                    }
                } catch {
                    print("Error")
                }
            }
        }.resume()
    }
}

extension ModalFirstViewController: UITableViewDelegate, UITableViewDataSource, ComponentProductCellDelegate3 {
    func rebornButtonTapped(index: Int) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "RebornCautionViewController") as? RebornCautionViewController else { return }
        let rebornData = rebornDatas[index]
        nextVC.rebornId = rebornData.rebornIdx
        nextVC.limitTime = rebornData.productLimitTime
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: false, completion: nil)
    }
    
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
        let limitTime = rebornData.productLimitTime
        let minuteLimit1 = limitTime[String.Index(encodedOffset: 3)]
        let minuteLimit2 = limitTime[String.Index(encodedOffset: 4)]
        let url = URL(string: rebornData.productImg ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/6f9043df-c35f-4f57-9212-cccaa0091315.png")
        cell.mfImageView.load(url: url!)
        cell.foodName.text = rebornData.productName
        cell.countLabel.text = "남은 수량: \(String(rebornData.productCnt))"
        cell.descriptionLabel.text = rebornData.productComment
        cell.cautionLabel.text = rebornData.productGuide
        
        if (rebornData.status == "ACTIVE") {
            if (rebornData.productCnt > 0) {
                cell.timeImage.isHidden = false
                cell.timeLabel.isHidden = false
                cell.rebornButton.isHidden = false
                cell.timeLabel.text = "\(minuteLimit1)\(minuteLimit2)분 내 수령"
            } else {
                cell.rebornButton.isEnabled = false
            }
        } else {
            cell.rebornButton.alpha = 0
            cell.rebornButton.isEnabled = false
            cell.timeImage.isHidden = true
            cell.timeLabel.isHidden = true
            cell.rebornButton.isHidden = true
            cell.foodName.translatesAutoresizingMaskIntoConstraints = false
            cell.foodName.topAnchor.constraint(equalTo: cell.timeLabel.topAnchor, constant: 5).isActive = true
            cell.countLabel.translatesAutoresizingMaskIntoConstraints = false
            cell.countLabel.topAnchor.constraint(equalTo: cell.timeLabel.topAnchor, constant: 5).isActive = true
            cell.mfImageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10.79).isActive = true
        }
        cell.index = indexPath.section
        cell.delegate = self
        
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
