//
//  FirstTabViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/25.
//

import UIKit

class FirstTabViewController: UIViewController {
    
    var shopList: [String] = ["bread_image", "cake_image", "goods_picture"]
    
    @IBOutlet weak var FTtableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FTtableView.delegate = self
        FTtableView.dataSource = self
        FTtableView.rowHeight = UITableView.automaticDimension
        FTtableView.estimatedRowHeight = UITableView.automaticDimension
        
        FTtableView.layer.masksToBounds = true // any value you want
        FTtableView.layer.shadowOpacity = 0.1// any value you want
        FTtableView.layer.shadowRadius = 10 // any value you want
        FTtableView.layer.shadowOffset = .init(width: 5, height: 10)
    }
}
    

extension FirstTabViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return shopList.count
    }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell: FirstTabTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FirstTab_TableViewCell", for: indexPath) as! FirstTabTableViewCell
            
            cell.FTimageView.image = UIImage(named: shopList[indexPath.section])
            return cell
        }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
        
}

