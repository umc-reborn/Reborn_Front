//
//  RebornHistoryViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/01/18.
//

import UIKit

class RebornHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    /*
    // 메뉴 TableViewCell에 들어갈 데이터 모델
    struct MyRebornMenuDataModel {
        let MyRebornMenuIcon: UIImage?  // 메뉴 타이틀
        let MyRebornMenuLabel: String   // 아이콘
        let MyRebornNextIcon: UIImage?  // 화살표 아이콘
    }
    
    // 메뉴 TableViewCell 데이터
    let MyRebornMenu: [MyRebornMenuDataModel] = [MyRebornMenuDataModel(MyRebornMenuIcon: UIImage(named: "my"), MyRebornMenuLabel: "회원정보수정", MyRebornNextIcon: UIImage(named: "arrow")), MyRebornMenuDataModel(MyRebornMenuIcon: UIImage(named: "present"), MyRebornMenuLabel: "리본 히스토리", MyRebornNextIcon: UIImage(named: "arrow")), MyRebornMenuDataModel(MyRebornMenuIcon: UIImage(named: "write"), MyRebornMenuLabel: "리뷰 관리", MyRebornNextIcon: UIImage(named: "arrow")),]
    */
    
    @IBOutlet weak var RebornHistoryTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RebornHistoryCell", for: indexPath) as? RebornHistoryTableViewCell else { return UITableViewCell() }
        
        return cell
    }

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RebornHistoryTableView.dataSource = self
        RebornHistoryTableView.delegate = self
        self.RebornHistoryTableView.rowHeight = 88;
        self.navigationItem.title = "리본 히스토리"
        
    }
    
}
