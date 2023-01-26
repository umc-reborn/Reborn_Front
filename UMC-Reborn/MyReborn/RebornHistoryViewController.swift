//
//  RebornHistoryViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/01/18.
//

import UIKit

class RebornHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var RebornHistoryTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RebornHistoryCell", for: indexPath) as? RebornHistoryTableViewCell else { return UITableViewCell() }
        
        return cell
    }

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RebornHistoryTableView.dataSource = self
        
        RebornHistoryTableView.delegate = self
        
        self.RebornHistoryTableView.rowHeight = 88;
        
    }
    
}
