//
//  ThirdMainViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/26.
//

import UIKit

class ThirdMainViewController: UIViewController {
    
    let StoreArray = [["가나다라마바사아"], ["챱챱챱챱챱스테이크"]]
    let FoodArray = [["맛있는우유식빵"], ["쫀득쫀득쫀득도넛"]]
    let CountArray = [["1"], ["2"]]
    
    @IBOutlet weak var StoreThirdtableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        StoreThirdtableView.delegate = self
        StoreThirdtableView.dataSource = self
        StoreThirdtableView.rowHeight = UITableView.automaticDimension
        StoreThirdtableView.estimatedRowHeight = UITableView.automaticDimension
        StoreThirdtableView.contentInset = .zero
        StoreThirdtableView.contentInsetAdjustmentBehavior = .never
        StoreThirdtableView.layer.masksToBounds = true // any value you want
        StoreThirdtableView.layer.shadowOpacity = 0.1// any value you want
        StoreThirdtableView.layer.shadowRadius = 10 // any value you want
        StoreThirdtableView.layer.shadowOffset = .init(width: 5, height: 10)
    }
}
