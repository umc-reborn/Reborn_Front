//
//  HelloSecondViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/01.
//

import UIKit

class HelloSecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func NextButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "JoinLogin", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(identifier: "tVersionViewController") as? tVersionViewController else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
