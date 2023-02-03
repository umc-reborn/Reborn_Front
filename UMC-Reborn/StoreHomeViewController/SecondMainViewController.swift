//
//  SecondMainViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/26.
//

import UIKit

class SecondMainViewController: UIViewController {
    
    let StoreArray = [["가나다라마바사아"], ["챱챱챱챱챱스테이크"]]
    let FoodArray = [["맛있는우유식빵"], ["쫀득쫀득쫀득도넛"]]
    let CountArray = [["1"], ["2"]]
    let TimeArray = [["09:12"], ["10:13"]]

    @IBOutlet weak var StoreSecondtableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        StoreSecondtableView.delegate = self
        StoreSecondtableView.dataSource = self
        StoreSecondtableView.rowHeight = UITableView.automaticDimension
        StoreSecondtableView.estimatedRowHeight = UITableView.automaticDimension
        StoreSecondtableView.contentInset = .zero
        StoreSecondtableView.contentInsetAdjustmentBehavior = .never
        StoreSecondtableView.layer.masksToBounds = true // any value you want
        StoreSecondtableView.layer.shadowOpacity = 0.1// any value you want
        StoreSecondtableView.layer.shadowRadius = 10 // any value you want
        StoreSecondtableView.layer.shadowOffset = .init(width: 5, height: 10)
    }
}
