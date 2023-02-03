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
    
    let FoodArray = ["베이컨 샌드위치", "에그 토스트", "감자 고로케케케케", "바스트 치즈 케이크", "우유 크로와상", "베이컨 샌드위치", "에그 토스트", "감자 고로케케케케", "바스트 치즈 케이크", "우유 크로와상"]
    
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
    }
}
