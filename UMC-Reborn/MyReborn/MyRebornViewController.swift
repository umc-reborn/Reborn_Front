//
//  MyRebornViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/01/16.
//

import UIKit

class MyRebornViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var MyRebornTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyRebornMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyRebornCell", for: indexPath) as? MyRebornCell else { return UITableViewCell() }
        
        cell.menuIcon.image = MyRebornMenu[indexPath.row].MyRebornMenuIcon
        cell.menuLabel.text = MyRebornMenu[indexPath.row].MyRebornMenuLabel
        cell.nextIcon.image = MyRebornMenu[indexPath.row].MyRebornNextIcon
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 메뉴 별로 viewController 넘기기
        switch indexPath.row {
            // 회원정보수정
        case 0: if let vc = storyboard?.instantiateViewController(withIdentifier: "editUserProfileVC") as? EditUserProfileViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
            // 리본 히스토리
        case 1: if let vc = storyboard?.instantiateViewController(withIdentifier: "rebornHistoryVC") as? RebornHistoryViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
            // 리뷰 관리
        case 2: if let vc = storyboard?.instantiateViewController(withIdentifier: "reviewManageVC") as? ReviewManageViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
        default:
            
            return
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyRebornTableView.delegate = self
        MyRebornTableView.dataSource = self
        
        self.MyRebornTableView.rowHeight = 60;

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 화면 넘어갔다가 다시 돌아왔을 때 cell 포커스 해제
        if let selectedIndexPath = MyRebornTableView.indexPathForSelectedRow {
            MyRebornTableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
}


// 메뉴 TableViewCell에 들어갈 데이터 모델
struct MyRebornMenuDataModel {
    let MyRebornMenuIcon: UIImage?  // 메뉴 타이틀
    let MyRebornMenuLabel: String   // 아이콘
    let MyRebornNextIcon: UIImage?  // 화살표 아이콘
}

// 메뉴 TableViewCell 데이터
let MyRebornMenu: [MyRebornMenuDataModel] = [MyRebornMenuDataModel(MyRebornMenuIcon: UIImage(named: "my"), MyRebornMenuLabel: "회원정보수정", MyRebornNextIcon: UIImage(named: "arrow")), MyRebornMenuDataModel(MyRebornMenuIcon: UIImage(named: "present"), MyRebornMenuLabel: "리본 히스토리", MyRebornNextIcon: UIImage(named: "arrow")), MyRebornMenuDataModel(MyRebornMenuIcon: UIImage(named: "write"), MyRebornMenuLabel: "리뷰 관리", MyRebornNextIcon: UIImage(named: "arrow")),]

