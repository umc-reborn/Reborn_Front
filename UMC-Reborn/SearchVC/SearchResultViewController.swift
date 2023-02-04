//
//  SearchResultViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/25.
//

import UIKit
import DropDown

class SearchResultViewController: UIViewController {
    
    var keyword : String = ""
    var searchDatas: [SearchResponse] = []
    
    @IBOutlet weak var countNum: UILabel!
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var dropView: UIView!
    @IBOutlet weak var ResultTableView: UITableView!
    
    let dropdown = DropDown()
    let itemList = ["이름순","별점순","인기순"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "Background")

        setSearchBar()
        initUI()
        setDropdown()
        searchResult()
        
    }
    
    func setSearchBar(){
        
        //서치바 만들기
        //            let searchBar = UISearchBar()
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 400, height: 0))
        searchBar.placeholder = "Search"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
            
        }
    
    func initUI(){
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().selectedTextColor = UIColor.red
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
        DropDown.appearance().setupCornerRadius(10)
        dropdown.dismissMode = .automatic
        
        ivIcon.tintColor = UIColor.gray
        tfInput.text = "정렬"
        tfInput.textColor = UIColor.gray
        dropView.layer.cornerRadius = 15
        dropView.layer.borderWidth = 0.5
        dropView.layer.borderColor = UIColor.gray.cgColor
        ResultTableView.backgroundColor = .white
        ResultTableView.layer.cornerRadius = 10
        ResultTableView.layer.borderWidth = 0
        ResultTableView.layer.borderColor = UIColor.black.cgColor
        ResultTableView.layer.shadowColor = UIColor.black.cgColor
        ResultTableView.layer.shadowOffset = CGSize(width: 2, height: 0)
        ResultTableView.layer.shadowOpacity = 0.05
        ResultTableView.layer.shadowRadius = 8
        ResultTableView.layer.masksToBounds = true
        ResultTableView.layer.masksToBounds = false
    }
    
    func setDropdown(){
        dropdown.dataSource = itemList
        dropdown.anchorView = self.dropView
        dropdown.bottomOffset = CGPoint(x: 0, y: dropView.bounds.height)
        dropdown.selectionAction = { [weak self] (index, item) in
            self!.tfInput.text = item
            self!.tfInput.textColor = UIColor.black
            self!.dropView.layer.borderColor = UIColor.red.cgColor
            self!.ivIcon.image = UIImage(systemName:"chevron.down")
        }
        
        dropdown.cancelAction = {[weak self] in
            self?.ivIcon.image = UIImage(systemName:"chevron.down")
        }
    }
    
    @IBAction func dropdownClicked(_ sender: Any){
        dropdown.show()
        self.ivIcon.image = UIImage(systemName:"chevron.up")
    }
    // MARK: - API
    func searchResult(){
       let text = keyword
        print(text)
        var url = APIConstants.baseURL + "/store/search?keyword=\(text)"
        let encodedStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        // 문자열 타입의 URL을 구조체 타입의 URL로 변환
        guard let url = URL(string: encodedStr) else { print("err"); return }

        // URLRequest 구조체 사용 (GET 이외의 요청 가능)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // URL Session 생성 (서버랑 통신하는 객체 ~= 브라우저)
        // dataTask -> 비동기적으로 처리됨
        URLSession.shared.dataTask(with: request) { [self] data, response, error in
            // error 발생 시 리턴
            if error != nil {
                print("err")
                return
            }

            // 응답코드에 따른 처리
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~=
            response.statusCode else {
                print("Error: HTTP request failed")
                return
            }

            // 데이터가 존재하면 출력
            if let safeData = data {
                // Data 타입을 String 타입으로 변환
                print(String(decoding: safeData, as: UTF8.self))
                        
                do {
                    let decoder = JSONDecoder()

                    var decodedData = try decoder.decode(SearchModel.self, from: safeData)
                    decodedData.result.sort { $0.storeName.count < $1.storeName.count }
//
                    self.searchDatas = decodedData.result
                    print(searchDatas)
                    DispatchQueue.main.async {
                        self.ResultTableView.reloadData()
                        print("count : \(self.searchDatas.count)")
                        countNum.text = "총 \(self.searchDatas.count)개"
                    }

                } catch {
                    print("Error")
                }
            }
        }.resume()  // 일시정지 상태로 작업이 부여된 URLSession에 작업 부여(작업 시작)
    }
        
}
// MARK: - UIImg
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

// MARK: - Extensions
extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SearchResultTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! SearchResultTableViewCell
        
        let searchData = searchDatas[indexPath.row]
        let url = URL(string: searchData.storeImage)
        cell.shopImg.load(url: url!)
        cell.shopnameLabel.text = searchData.storeName
        cell.ratingnum.text = String(searchData.storeScore)
        cell.categoryLabel.text = searchData.category
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    
}
