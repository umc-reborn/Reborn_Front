//
//  SearchResultViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/25.
//

import UIKit
import DropDown

class SearchResultViewController: UIViewController {
    
    var SearchInput : String = ""
    var searchDatas: [SearchResponse] = []

    
    @IBOutlet weak var countNum: UILabel!
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var dropView: UIView!
    @IBOutlet weak var ResultTableView: UITableView!
    
    let dropdown = DropDown()
    let itemList = ["  이름순","  별점순"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "Background")

        setSearchBar()
        initUI()
        setDropdown()
//        searchResult()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchResult()
//        searchsorted()

    }
    
    func setSearchBar(){
        
        //서치바 만들기
        let text = SearchInput
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width //화면 너비
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: width - 50, height: 0))
        searchBar.placeholder = "\(text)"
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchBar.searchTextField.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.searchTextField.layer.borderWidth = 1.0
        searchBar.searchTextField.layer.cornerRadius = 4
        let search = UIBarButtonItem(customView: searchBar)
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 26
        self.navigationItem.rightBarButtonItems = [search, spacer]
        searchBar.delegate = self
            
        }
    
//    func userPressedToEnter(keyword: String) {
//        searchBar.text = SearchInput
//        searchResult()
//    }
    
    func initUI(){
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().selectedTextColor = UIColor.red
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
        DropDown.appearance().setupCornerRadius(10)
        dropdown.dismissMode = .automatic
        
        ivIcon.tintColor = UIColor.gray
        tfInput.text = "   정렬"
        tfInput.layer.borderWidth = 0
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
            if self!.tfInput.text == "  이름순" {
                 print("이름순 정렬")
//                 self?.getGoalListsortbyAsc()
                self!.searchDatas.sort{ $0.storeName < $1.storeName }
                self!.ResultTableView.reloadData()
                 
             } else {
                 print("별점순 정렬")
//                 self?.getGoalListsortbyDesc()
                 self!.searchDatas.sort{ $0.storeScore > $1.storeScore }
                 DispatchQueue.main.async {
                     self!.ResultTableView.reloadData()
                }
                 
             }
            
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
       let text = SearchInput
        print(text)
        var url = APIConstants.baseURL + "/store/search?keyword=\(text)"
        let encodedStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        
        guard let url = URL(string: encodedStr) else { print("err"); return }


        var request = URLRequest(url: url)
        request.httpMethod = "GET"


        URLSession.shared.dataTask(with: request) { [self] data, response, error in
            // error 발생 시 리턴
            if error != nil {
                print("err")
                return
            }

           
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~=
            response.statusCode else {
                print("Error: HTTP request failed")
                return
            }

            // 데이터가 존재하면 출력
            if let safeData = data {
                
//                print(String(decoding: safeData, as: UTF8.self))
                        
                do {
                    let decoder = JSONDecoder()

                    var decodedData = try decoder.decode(SearchModel.self, from: safeData)
                    decodedData.result.sort { $0.storeName.count < $1.storeName.count }
//
                    self.searchDatas = decodedData.result
//                    print(searchDatas)
                    DispatchQueue.main.async {
                        self.ResultTableView.reloadData()
                        print("count : \(self.searchDatas.count)")
                        countNum.text = "총 \(self.searchDatas.count)개"
                    }

                } catch {
                    print("Error")
                }
            }
        }.resume()
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

extension SearchResultViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SearchInput = searchBar.text!
        searchResult()
    }
    func userPressedToEnter(keyword: String) {
        
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel")
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
        let url = URL(string: searchData.userImage)
        cell.shopImg.load(url: url!)
        cell.shopnameLabel.text = searchData.storeName
        cell.ratingnum.text = String(searchData.storeScore)
        cell.categoryLabel.text = searchData.category
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard: UIStoryboard = UIStoryboard(name: "Personal_Home", bundle: nil)
        guard let svc1 = storyboard.instantiateViewController(identifier: "ModalPersonalViewController") as? ModalPersonalViewController else { return }
        svc1.storeIdm1 = searchDatas[indexPath.row].storeIdx
        print(searchDatas[indexPath.row].storeIdx)
        print("&&&&&&&&")
        UserDefaults.standard.set(searchDatas[indexPath.row].storeIdx, forKey: "storeid")
        self.present(svc1, animated: true)

    }
    
    
}
