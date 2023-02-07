//
//  FirstLoginViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/01/22.
//

import UIKit
//import Tabman
//import Pageboy

//extension FirstLoginViewController: PageboyViewControllerDataSource, TMBarDataSource {
//
//    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
//        switch index {
//        case 0:
//            return TMBarItem(title: "이웃 로그인")
//        case 1:
//            return TMBarItem(title: "가게 로그인")
//        default:
//            let title = "Page \(index)"
//           return TMBarItem(title: title)
//        }
//    }
//
//    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
//        return viewControllers.count
//    }
//
//    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
//        return viewControllers[index]
//    }
//
//    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
//        return nil
//    }
//}

class FirstLoginViewController: ViewController {
    

    @IBOutlet weak var FirstView: UIView!
    
    
//    private var viewControllers: [UIViewController] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupTabMan()
        
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
    }
        
//    private func setupTabMan(){
//
//            let vc1 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NbViewcontroller") as! NbViewcontroller
//            let vc2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShopLoginViewController") as! ShopLoginViewController
//
//
//            viewControllers.append(vc1)
//            viewControllers.append(vc2)
//
//
//            self.dataSource = self
//            let bar = TMBar.ButtonBar()
//            // 배경 회색으로 나옴 -> 하얀색으로 바뀜
//            bar.backgroundView.style = .blur(style: .light)
//            // 간격 설정
//            bar.layout.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
//            // 버튼 글씨 커스텀
//            bar.buttons.customize { (button) in
//                button.tintColor = .systemGray4
//                button.selectedTintColor = .black
//                button.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
//                button.selectedFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
//
//            }
//            // 밑줄 쳐지는 부분
//            bar.indicator.weight = .custom(value: 2)
//            bar.indicator.tintColor = .black
//            addBar(bar, dataSource: self, at: .custom(view: FirstView, layout: nil))
//
//            }
            
            
        }
    
        
    
    

    
   


