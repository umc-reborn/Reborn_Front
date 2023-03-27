//
//  PopularShopViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/01/18.
//

import UIKit
import Tabman
import Pageboy

class PopularShopViewController: TabmanViewController {
    
    @IBOutlet weak var tabView: UIView!
    private var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabMan()
    }
    
    // MARK: - Function
    private func setupTabMan(){
        let firstVC = storyboard?.instantiateViewController(withIdentifier: "SideDishVC") as! PopularTableViewController
        firstVC.tabName = "CAFE"
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "SideDishVC") as! PopularTableViewController
        secondVC.tabName = "SIDEDISH"
        let thirdVC = storyboard?.instantiateViewController(withIdentifier: "SideDishVC") as! PopularTableViewController
        thirdVC.tabName = "FASHION"
        let fourthVC = storyboard?.instantiateViewController(withIdentifier: "SideDishVC") as! PopularTableViewController
        fourthVC.tabName = "LIFE"
        let fifthVC = storyboard?.instantiateViewController(withIdentifier: "SideDishVC") as! PopularTableViewController
        fifthVC.tabName = "ETC"

       
        viewControllers.append(firstVC)
        viewControllers.append(secondVC)
        viewControllers.append(thirdVC)
        viewControllers.append(fourthVC)
        viewControllers.append(fifthVC)
        
        
        tabView.backgroundColor = .white
//        tabView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        tabView.layer.cornerRadius = 10
        tabView.layer.shadowOffset = CGSize(width: 5, height: -5)
        tabView.layer.shadowOpacity = 0.15
        tabView.layer.shadowRadius = 8
        tabView.layer.masksToBounds = false
        tabView.clipsToBounds = true
        
        
        self.dataSource = self
        let bar = TMBar.ButtonBar()
        // 배경 회색으로 나옴 -> 하얀색으로 바뀜
        bar.backgroundView.style = .blur(style: .light)
        // 간격 설정
        bar.layout.contentInset = UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 25)
        // 버튼 글씨 커스텀
        bar.buttons.customize { (button) in
            button.tintColor = .systemGray4
            button.selectedTintColor = .black
            button.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            button.selectedFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
        }
        // 밑줄 쳐지는 부분
        bar.indicator.weight = .custom(value: 2)
        bar.indicator.tintColor = .black
        addBar(bar, dataSource: self, at: .custom(view: tabView, layout: nil))
    }
}
    
    
    extension PopularShopViewController: PageboyViewControllerDataSource, TMBarDataSource {
        
        func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
            switch index {
            case 0:
                return TMBarItem(title: "카페·디저트")
            case 1:
                return TMBarItem(title: "반찬")
            case 2:
                return TMBarItem(title: "패션")
            case 3:
                return TMBarItem(title: "편의·생활")
            case 4:
                return TMBarItem(title: "기타")
            default:
                let title = "Page \(index)"
               return TMBarItem(title: title)
            }
        }

        func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
            return viewControllers.count
        }
        
        func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
            return viewControllers[index]
        }
        
        func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
            return nil
        }
    }
