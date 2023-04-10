//
//  FinishWriteReviewViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/02/14.
//

import UIKit

class FinishWriteReviewViewController:UIViewController {
    
    var storeTitle: String = ""
    var storeCategory: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundView.layer.shadowColor = UIColor.gray.cgColor //색상
                self.backgroundView.layer.shadowOpacity = 0.1 //alpha값
                self.backgroundView.layer.shadowRadius = 10 //반경
                self.backgroundView.layer.shadowOffset = CGSize(width: 0, height: 10) //위치조정
                self.backgroundView.layer.masksToBounds = false
        self.backgroundView.layer.cornerRadius = 8;
        
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    @IBOutlet var backgroundView: UIView!
    @IBAction func onClickButton(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "MyReborn", bundle: nil)
        guard let rvc = storyboard.instantiateViewController(withIdentifier: "reviewManageVC") as? ReviewManageViewController else {return}
        
        navigationController?.pushViewController(rvc, animated: true)
    }
}
