//
//  Id_PassWordSecondViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/03.
//

import UIKit

class Id_PassWordSecondViewController: UIViewController {

    
    @IBOutlet weak var PgIdPw: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //progressview
        PgIdPw.progressViewStyle = .default
        PgIdPw.progressTintColor = .myorange
        PgIdPw.progress = 0.66
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
