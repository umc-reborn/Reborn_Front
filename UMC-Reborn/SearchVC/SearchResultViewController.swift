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
        dropView.backgroundColor = UIColor.white
        dropView.layer.cornerRadius = 10
        
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().selectedTextColor = UIColor.red
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
        DropDown.appearance().setupCornerRadius(10)
        dropdown.dismissMode = .automatic
        
        ivIcon.tintColor = UIColor.gray
        tfInput.text = "정렬"
    }
    
    func setDropdown(){
        dropdown.dataSource = itemList
        
        dropdown.anchorView = self.dropView
        
        dropdown.bottomOffset = CGPoint(x: 0, y: dropView.bounds.height)
        dropdown.selectionAction = { [weak self] (index, item) in
            self!.tfInput.text = item
            self!.ivIcon.image = UIImage.init(named: "chevron.down")
        }
        
        dropdown.cancelAction = {[weak self] in
            self?.ivIcon.image = UIImage.init(named: "chevron.down")
        }
    }
    
    @IBAction func dropdownClicked(_ sender: Any){
        dropdown.show()
        self.ivIcon.image = UIImage.init(named: "chevron.up")
        ivIcon.tintColor = UIColor.red
    }
    
    func searchResult(){
       let text = keyword
        print(text)
        var url = APIConstants.baseURL + "/store/search?keyword=\(text)"
       
        let encodedStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!


        // 문자열 타입의 URL을 구조체 타입의 URL로 변환
        guard let url = URL(string: encodedStr) else { print("err"); return }


        /* Case 1. URL 구조체 사용 (GET 요청에만 사용 가능)
        URLSession.shared.dataTask(with: structUrl) { data, response, error in
                ...
        }.resume()   */

        // Case 2. URLRequest 구조체 사용 (GET 이외의 요청 가능)
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
                        

                        // 우리가 사용하려는 형태(구조체/클래스)로 변형 후 출력(dump)
                                
                        // dump(parseJSON(safeData))   // json decode를 구현한 함수 호출
                        // json decode 구현
                do {
                    let decoder = JSONDecoder()

                    var decodedData = try decoder.decode(SearchModel.self, from: safeData)
                    decodedData.result.sort { $0.storeName.count < $1.storeName.count }
//
                    self.searchDatas = decodedData.result
                    print(searchDatas)
//                    print(SearchModel)
//                    let inx = decodedData.storeIdx
//                    let name = decodedData.storeName
//                    let img = decodedData.storeImage
//                    let address = decodedData.storeAddress
//                    let description = decodedData.storeDescription
//                    let score = decodedData.storeScore
//                    let category = decodedData.category
//
//                    let searchData = SearchResponse(storeIdx: inx, storeName: name, storeImage: img, storeAddress: address, storeDescription: description, storeScore: score, category: category)
                    DispatchQueue.main.async {
                        self.ResultTableView.reloadData()
                        print("여기여기여기여기오류 : \(self.searchDatas.count)")
                    }

                } catch {
                    print("Error")
                }
            }
        }.resume()  // 일시정지 상태로 작업이 부여된 URLSession에 작업 부여(작업 시작)
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
        cell.shopnameLabel.text = searchData.storeName
        cell.ratingnum.text = String(searchData.storeScore)
        
//        cell.shopnameLabel.text = shopList[indexPath.row]
//        cell.ratingnum.text = ratingNum[indexPath.row]
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    
}
