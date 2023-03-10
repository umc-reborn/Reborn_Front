//
//  MyRebornViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/01/16.
//

import UIKit

class MyRebornViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var MyRebornTableView: UITableView!
    @IBOutlet var userNameLabel: UILabel!
    
    let userIdx = UserDefaults.standard.integer(forKey: "userIndex")
    let username = UserDefaults.standard.string(forKey: "userNickName")
    
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
        case 3: if let vc = storyboard?.instantiateViewController(withIdentifier: "changePwdVC") as? ChangePasswordViewController {
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
        
        self.MyRebornTableView.rowHeight = 64;
        self.navigationItem.title = "마이리본"
        self.navigationItem.backButtonDisplayMode = .minimal
        self.navigationController?.navigationBar.tintColor = .black

        print("마이 리본으로 불러온 userIdx 값은 \(userIdx)")
        print("마이 리본으로 불러온 userNickname 값은 \(username)")
        userNameLabel.text = "\(username!)"
        
        // 그림자
        self.MyRebornTableView.layer.shadowColor = UIColor.gray.cgColor //색상
                self.MyRebornTableView.layer.shadowOpacity = 0.1 //alpha값
                self.MyRebornTableView.layer.shadowRadius = 10 //반경
                self.MyRebornTableView.layer.shadowOffset = CGSize(width: 0, height: 10) //위치조정
                self.MyRebornTableView.layer.masksToBounds = false
        self.MyRebornTableView.layer.cornerRadius = 8;

        
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
let MyRebornMenu: [MyRebornMenuDataModel] = [MyRebornMenuDataModel(MyRebornMenuIcon: UIImage(named: "my"), MyRebornMenuLabel: "회원정보수정", MyRebornNextIcon: UIImage(named: "arrow")), MyRebornMenuDataModel(MyRebornMenuIcon: UIImage(named: "present"), MyRebornMenuLabel: "리본 히스토리", MyRebornNextIcon: UIImage(named: "arrow")), MyRebornMenuDataModel(MyRebornMenuIcon: UIImage(named: "write"), MyRebornMenuLabel: "리뷰 관리", MyRebornNextIcon: UIImage(named: "arrow")), MyRebornMenuDataModel(MyRebornMenuIcon: UIImage(named: "lock_icon"), MyRebornMenuLabel: "비밀번호 변경", MyRebornNextIcon: UIImage(named: "arrow")),]

