//
//  RebornHistoryViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/01/18.
//

import UIKit

class RebornHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var RebornHistoryTableView: UITableView!
    @IBOutlet weak var totalNum: UILabel!
    
    var historyDatas: [RebornHistoryResponse] = []
    var userIdx:Int?

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.totalNum.text = "\(historyDatas.count)"
        return historyDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RebornHistoryCell", for: indexPath) as? RebornHistoryTableViewCell else { return UITableViewCell() }
//
        let cell = RebornHistoryTableView.dequeueReusableCell(withIdentifier: "RebornHistoryCell", for: indexPath) as! RebornHistoryTableViewCell
        
        let historyData = historyDatas[indexPath.row]
        let url = URL(string: historyData.storeImage)
        cell.storeImage.load(url: url!)
        cell.storeName.text = historyData.storeName
        cell.date.text = String(historyData.createdAt.prefix(10))
        cell.status.text = historyData.status
        cell.storeScore.text = String(historyData.storeScore)
        cell.category.text = historyData.category
        let taskIndex = historyData.rebornTaskIdx
        UserDefaults.standard.set(taskIndex, forKey: "rebornTaskIdx")
        print("taskIdx는 \(taskIndex)")
        
        //        self.historyDatas = response.result
        //        let taskIdx = historyData.rebornTaskIdx
        //        print("taskIdx는 \(taskIdx)")

        return cell
    }

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RebornHistoryTableView.dataSource = self
        RebornHistoryTableView.delegate = self
        self.RebornHistoryTableView.rowHeight = 88;
        self.navigationItem.title = "리본 히스토리"
        
        RebornHistoryService.shared.getRebornHistory{ result in
            switch result {
            case .success(let response):
                print("성공")
                dump(response)
                guard let response = response as? RebornHistoryModel else {
                    print("실패")
                    break
                }
                self.historyDatas = response.result

            default:
                break
            }
            self.RebornHistoryTableView.reloadData()
        }
        //        print(historyDatas)
    }
}
