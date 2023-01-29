//
//  SecondTabViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/25.
//

import UIKit

class SecondTabViewController: UIViewController {
    
    var shopList: [String] = ["bread_image", "cake_image", "goods_picture"]
    
    
    @IBOutlet weak var STtableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        STtableView.delegate = self
        STtableView.dataSource = self
        STtableView.rowHeight = UITableView.automaticDimension
        STtableView.estimatedRowHeight = UITableView.automaticDimension
        STtableView.contentInset = .zero
        STtableView.contentInsetAdjustmentBehavior = .never
        
        STtableView.layer.masksToBounds = true // any value you want
        STtableView.layer.shadowOpacity = 0.1// any value you want
        STtableView.layer.shadowRadius = 10 // any value you want
        STtableView.layer.shadowOffset = .init(width: 0, height: 10)

        // Do any additional setup after loading the view.
    }

}
