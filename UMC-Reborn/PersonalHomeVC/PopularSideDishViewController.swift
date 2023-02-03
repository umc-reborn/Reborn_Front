//
//  PopularSideDishViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/18.
//

import UIKit

class PopularSideDishViewController: UIViewController {
    
    
    var shopList: [String] = ["베이커리","어쩌구","저쩌구"]
    var locationList: [String] = ["연남동","홍제동","연희동"]
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var categoryListTableView: UITableView!

    @IBOutlet weak var backgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadow()
        
        categoryListTableView.delegate = self
        categoryListTableView.dataSource = self
        


    }
    
    private func addShadow(){
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.borderWidth = 0
        backgroundView.layer.borderColor = UIColor.black.cgColor
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 2, height: 0)
        backgroundView.layer.shadowOpacity = 0.15
        backgroundView.layer.shadowRadius = 8
        backgroundView.layer.masksToBounds = true
        backgroundView.layer.masksToBounds = false
    }


}

// MARK: - Extensions
extension PopularSideDishViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PopularListCell", for: indexPath) as! CategoryTableViewCell
        
        cell.shopnameLabel.text = shopList[indexPath.row]
        cell.locationLabel.text = locationList[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    
}

