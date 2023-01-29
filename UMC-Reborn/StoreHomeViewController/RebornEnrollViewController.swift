//
//  RebornEnrollViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/13.
//

import UIKit

class RebornEnrollViewController: UIViewController {
    
    @IBOutlet weak var EnrollTableView: UITableView!
    
    let CautionArray = ["리본 나눔 후 냉동 보관 필수", "당일 섭취를 권장합니다.", "리본 나눔 후 3시간 이내 섭취 권장", "리본 나눔 후 바로 섭취 권장", "리본 나눔 후 3시간 이내 섭취 권장"]
    let DescriptionArray = ["포만감이 좋은 맛있는 베이컨 샌드위치", "부드러운 계란과 바삭한 빵의 조화", "감자가 가득 들어간 고로케", "바스트치즈케이크는 우리 가게가 최고", "우유가 아주 담백한 크로와상"]
    let FoodArray = ["베이컨 샌드위치", "에그 토스트", "감자 고로케케케케", "바스트 치즈 케이크", "우유 크로와상"]
    let CountArray = ["2", "2", "2", "2", "2"]
    let TimeArray = ["10", "20", "10", "20", "10"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EnrollTableView.delegate = self
        EnrollTableView.dataSource = self
        EnrollTableView.rowHeight = UITableView.automaticDimension
        EnrollTableView.estimatedRowHeight = UITableView.automaticDimension
        
        EnrollTableView.layer.masksToBounds = true // any value you want
        EnrollTableView.layer.shadowOpacity = 0.1// any value you want
        EnrollTableView.layer.shadowRadius = 10 // any value you want
        EnrollTableView.layer.shadowOffset = .init(width: 5, height: 10)
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
    }
}
