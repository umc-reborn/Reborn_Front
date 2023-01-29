//
//  FirstMainViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/26.
//

import UIKit

class FirstMainViewController: UIViewController {
    
    let StoreArray = ["가나다라마바사아", "챱챱챱챱챱스테이크"]
    let FoodArray = ["맛있는우유식빵", "쫀득쫀득쫀득도넛"]
    let CountArray = ["1", "2"]
    let TimeArray = ["09:12", "10:13"]
    
    
    @IBOutlet weak var StoreFirsttableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        StoreFirsttableView.delegate = self
        StoreFirsttableView.dataSource = self
        StoreFirsttableView.rowHeight = UITableView.automaticDimension
        StoreFirsttableView.estimatedRowHeight = UITableView.automaticDimension
        StoreFirsttableView.contentInset = .zero
        StoreFirsttableView.contentInsetAdjustmentBehavior = .never
        StoreFirsttableView.layer.masksToBounds = true // any value you want
        StoreFirsttableView.layer.shadowOpacity = 0.1// any value you want
        StoreFirsttableView.layer.shadowRadius = 10 // any value you want
        StoreFirsttableView.layer.shadowOffset = .init(width: 5, height: 10)
    }
    

    @objc func shareButtonTapped(sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "CodeViewController") as? CodeViewController else { return }
        nextVC.modalPresentationStyle = .overCurrentContext
        self.present(nextVC, animated: true, completion: nil)
    }

}
