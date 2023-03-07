//
//  FinishWriteReviewViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/02/14.
//

import UIKit

class FinishWriteReviewViewController:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    @IBAction func onClickButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "MyReborn", bundle: nil)
        guard let rvc = storyboard.instantiateViewController(withIdentifier: "rebornHistoryVC") as? RebornHistoryViewController else {return}
        
        navigationController?.pushViewController(rvc, animated: true)
    }
}
