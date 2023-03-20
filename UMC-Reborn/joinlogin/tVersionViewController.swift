//
//  tVersionViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/03/13.
//

import UIKit

class tVersionViewController: UIViewController {

    
    @IBOutlet var iseeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func iseeButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Personal_Home", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(identifier: "PersonalHomeVC") as? PersonalHomeViewController else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    

}
