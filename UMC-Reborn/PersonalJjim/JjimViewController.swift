//
//  JjimViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/30.
//

import UIKit
import DropDown

class JjimViewController: UIViewController {
    
    let dropdown = DropDown()

    // DropDown 아이템 리스트
    let itemList = ["   정렬", "이름순", "별점순", "인기순"]
    
    let jjimview = UserDefaults.standard.integer(forKey: "userIndex")
    
    var jjimDatas: [JjimListModel] = []
    var jjimPopularDatas: [JjimListModel] = []
    var jjimNameDatas: [JjimListModel] = []
    var jjimScoreDatas: [JjimListModel] = []

    @IBOutlet weak var JjimCountLabel: UILabel!
    @IBOutlet weak var JjimTableView: UITableView!
    @IBOutlet weak var JjimView: UIView!
    @IBOutlet weak var JjimTextField: UITextField!
    @IBOutlet weak var JjimButton: UIButton!
    
    
    func initUI() {
        DropDown.appearance().textColor = UIColor.black // 아이템 텍스트 색상
        DropDown.appearance().selectedTextColor = UIColor(red: 255/255, green: 77/255, blue: 21/255, alpha: 1) // 선택된 아이템 텍스트 색상
        DropDown.appearance().backgroundColor = UIColor.white // 아이템 팝업 배경 색상
        DropDown.appearance().selectionBackgroundColor = UIColor.white // 선택한 아이템 배경 색상
        DropDown.appearance().setupCornerRadius(15)
            dropdown.dismissMode = .automatic // 팝업을 닫을 모드 설정
        DropDown.appearance().textFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 13) ?? UIFont.systemFont(ofSize: 13)
                
            JjimTextField.text = "   정렬" // 힌트 텍스트
    }
    
    func setDropdown() {
        // dataSource로 ItemList를 연결
        dropdown.dataSource = itemList
        dropdown.cellHeight = 30
        // anchorView를 통해 UI와 연결
        dropdown.anchorView = self.JjimView
        
        // View를 갖리지 않고 View아래에 Item 팝업이 붙도록 설정
        dropdown.bottomOffset = CGPoint(x: 0, y: JjimView.bounds.height)
        
        // Item 선택 시 처리
        dropdown.selectionAction = { [weak self] (index, item) in
            //선택한 Item을 TextField에 넣어준다.
            self!.JjimTextField.text = item
        }
        
        // 취소 시 처리
        dropdown.cancelAction = { [weak self] in
        }
    }

    // View 클릭 시 Action
    @IBAction func dropdownClicked(_ sender: Any) {
        dropdown.show() // 아이템 팝업을 보여준다.
        // 아이콘 이미지를 변경하여 DropDown이 펼쳐진 것을 표현
    }
    
    func JjimResult() {
        
        let url = APIConstants.baseURL + "/jjim/\(String(jjimview))"
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
                    let decodedData = try JSONDecoder().decode(JjimList.self, from: safeData)
                    self.jjimDatas = decodedData.result
                    print(jjimDatas)
                    DispatchQueue.main.async {
                        self.JjimTableView.reloadData()
                        print("count: \(self.jjimDatas.count)")
                        
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
    
    func JjimCountResult() {
        
        let url = APIConstants.baseURL + "/jjim/cnt/\(String(jjimview))"
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
                    let decodedData = try decoder.decode(JjimCountList.self, from: safeData)
                    let storeDatas = decodedData.result
                    DispatchQueue.main.async {
                        self.JjimCountLabel.text = "총 \(storeDatas)건"
                    }
                } catch {
                    print("error")
                }
            }
        }.resume()
    }
    
    func JjimPopularResult() {
        
        let url = APIConstants.baseURL + "/jjim/22?sort=jjimCnt"
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
                    let decodedData = try JSONDecoder().decode(JjimList.self, from: safeData)
                    self.jjimPopularDatas = decodedData.result
                    print(jjimPopularDatas)
                    DispatchQueue.main.async {
                        self.JjimTableView.reloadData()
                        print("count: \(self.jjimPopularDatas.count)")
                        
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
    
    func JjimNameResult() {
        
        let url = APIConstants.baseURL + "/jjim/22?sort=storeName"
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
                    let decodedData = try JSONDecoder().decode(JjimList.self, from: safeData)
                    self.jjimNameDatas = decodedData.result
                    print(jjimNameDatas)
                    DispatchQueue.main.async {
                        self.JjimTableView.reloadData()
                        print("count: \(self.jjimNameDatas.count)")
                        
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
    
    func JjimScoreResult() {
        
        let url = APIConstants.baseURL + "/jjim/22?sort=storeScore"
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
                    let decodedData = try JSONDecoder().decode(JjimList.self, from: safeData)
                    self.jjimScoreDatas = decodedData.result
                    print(jjimScoreDatas)
                    DispatchQueue.main.async {
                        self.JjimTableView.reloadData()
                        print("count: \(self.jjimScoreDatas.count)")
                        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        JjimView.layer.cornerRadius = 15
        JjimView.layer.borderWidth = 1
        JjimView.layer.borderColor = UIColor(red: 255/255, green: 77/255, blue: 21/255, alpha: 1).cgColor
        
        JjimTextField.layer.cornerRadius = 5
        JjimTextField.layer.borderWidth = 1
        JjimTextField.layer.borderColor = UIColor.white.cgColor

        JjimTableView.delegate = self
        JjimTableView.dataSource = self
        JjimTableView.rowHeight = UITableView.automaticDimension
        JjimTableView.estimatedRowHeight = UITableView.automaticDimension
        
        JjimTableView.layer.masksToBounds = true // any value you want
        JjimTableView.layer.shadowOpacity = 0.1// any value you want
        JjimTableView.layer.shadowRadius = 10 // any value you want
        JjimTableView.layer.shadowOffset = .init(width: 5, height: 10)
        
        initUI()
        setDropdown()
        JjimResult()
        JjimCountResult()
//        JjimPopularResult()
//        JjimNameResult()
//        JjimScoreResult()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        JjimResult()
        JjimCountResult()
    }
}
