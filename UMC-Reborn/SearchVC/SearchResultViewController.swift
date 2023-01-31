//
//  SearchResultViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/25.
//

import UIKit
import DropDown

class SearchResultViewController: UIViewController {
    
    var shopList: [String] = ["베이커리","어쩌구","저쩌구","베이커리","어쩌구","저쩌구","베이커리","어쩌구","저쩌구","베이커리","어쩌구","저쩌구"]
    var ratingNum: [String] = ["5.0","4.5","3.2","5.0","4.5","3.2","5.0","4.5","3.2","5.0","4.5","3.2"]
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
        
}

// MARK: - Extensions
extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SearchResultTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! SearchResultTableViewCell
        
        cell.shopnameLabel.text = shopList[indexPath.row]
        cell.ratingnum.text = ratingNum[indexPath.row]
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    
}
