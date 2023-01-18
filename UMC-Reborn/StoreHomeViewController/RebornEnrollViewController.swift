//
//  RebornEnrollViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/13.
//

import UIKit

class RebornEnrollViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var EnrollTableView: UITableView!
    
    let tableArray = [[""], [""], [""]]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Enroll_TableViewCell") else {
            fatalError("셀이 존재하지 않습니다")
        }
        cell.textLabel?.text = self.tableArray[indexPath.section][indexPath.row]
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)]
        
        EnrollTableView.delegate = self
        EnrollTableView.dataSource = self
        EnrollTableView.rowHeight = UITableView.automaticDimension
        EnrollTableView.estimatedRowHeight = UITableView.automaticDimension
        EnrollTableView.contentInset = .zero
        EnrollTableView.contentInsetAdjustmentBehavior = .never
        
        EnrollTableView.layer.masksToBounds = false // any value you want
        EnrollTableView.layer.shadowOpacity = 0.15// any value you want
        EnrollTableView.layer.shadowRadius = 20 // any value you want
        EnrollTableView.layer.shadowOffset = .init(width: 0, height: 10)
    }
}
