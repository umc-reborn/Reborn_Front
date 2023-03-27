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
    @IBOutlet var userAddress: UILabel!
    @IBOutlet var userImage: UIImageView!
    
    let userIdx = UserDefaults.standard.integer(forKey: "userIndex")
    
    var userJWT : String = ""
    
    var getUserName: String = ""
    
    // 로그아웃
    var rebornData: LogoutresultModel!
    
    // 회원탈퇴
    var rebornDatas: UserDeleteresultModel!
    
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
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.userJWT = UserDefaults.standard.string(forKey: "userJwt") ?? ""
        }
        
        MyRebornTableView.delegate = self
        MyRebornTableView.dataSource = self
        
        userImage.layer.cornerRadius = self.userImage.frame.size.height / 2
        userImage.layer.masksToBounds = true
        userImage.clipsToBounds = true
        self.MyRebornTableView.rowHeight = 56;
        self.MyRebornTableView.layer.cornerRadius = 10
        self.navigationItem.title = "마이리본"
        self.navigationItem.backButtonDisplayMode = .minimal
        self.navigationController?.navigationBar.tintColor = .black
        
        // 그림자
        self.MyRebornTableView.layer.shadowColor = UIColor.gray.cgColor //색상
                self.MyRebornTableView.layer.shadowOpacity = 0.1 //alpha값
                self.MyRebornTableView.layer.shadowRadius = 10 //반경
                self.MyRebornTableView.layer.shadowOffset = CGSize(width: 0, height: 10) //위치조정
                self.MyRebornTableView.layer.masksToBounds = false
        self.MyRebornTableView.layer.cornerRadius = 8;

        userResult()
    }
    
    func userResult() {
        
        let url = APIConstants.baseURL + "/users/inform"
        let encodedStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let url = URL(string: encodedStr) else { print("err"); return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        

        
        print("응답하라 \(userJWT)")
        
        // Header
        request.addValue("\(userJWT)", forHTTPHeaderField: "X-ACCESS-TOKEN")
        
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
                    let decodedData = try decoder.decode(UserList.self, from: safeData)
                    let storeDatas = decodedData.result
                    print(storeDatas)
                    DispatchQueue.main.async {
                        self.userAddress.text = "\(storeDatas.userAddress)"
                        let url = URL(string: storeDatas.userImg ?? "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/6f9043df-c35f-4f57-9212-cccaa0091315.png")
                        self.userImage.load(url: url!)
                        self.userNameLabel.text = "\(storeDatas.userNickname)"
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 화면 넘어갔다가 다시 돌아왔을 때 cell 포커스 해제
        if let selectedIndexPath = MyRebornTableView.indexPathForSelectedRow {
            MyRebornTableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
        

    }
    
    @IBAction func logoutButton(_ sender: Any) {
        let parameterDatas = LogoutModel(jwt: userJWT )
        APIHandlerLogoutPost.instance.SendingPostReborn(token: userJWT , parameters: parameterDatas) { result in self.rebornData = result }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            let goLogin = UIStoryboard.init(name: "JoinLogin", bundle: nil)
            guard let rvc = goLogin.instantiateViewController(withIdentifier: "FirstLoginViewController") as? FirstLoginViewController else {return}
            self.present(rvc, animated: true)
        }
    }
    
    @IBAction func deleteUserButton(_ sender: Any) {
        let parameterDatas = UserDeleteModel(userIdx: userIdx, status: "DELETE")
        APIHandlerUserDeletePost.instance.SendingPostReborn(token: userJWT , parameters: parameterDatas) { result in self.rebornDatas = result }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            let goLogin = UIStoryboard.init(name: "JoinLogin", bundle: nil)
            guard let rvc = goLogin.instantiateViewController(withIdentifier: "FirstLoginViewController") as? FirstLoginViewController else {return}
            rvc.modalPresentationStyle = .fullScreen
            self.present(rvc, animated: true, completion: nil)

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

