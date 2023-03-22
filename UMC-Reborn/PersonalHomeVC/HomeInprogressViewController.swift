//
//  HomeInprogressViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/02/10.
//

import Foundation
class HomeInprogressViewController: UIViewController {
    
    @IBOutlet var defaultView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var rebornDatas: [InprogressResponse] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        // Do any additional setup after loading the view.
        defaultView.clipsToBounds = true
        defaultView.layer.cornerRadius = 20
        defaultView.layer.masksToBounds = false
        defaultView.layer.shadowOffset = CGSize(width: 5, height: 10)
        defaultView.layer.shadowRadius = 10
        defaultView.layer.shadowOpacity = 0.1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        InprogressService.shared.getInprogress{ result in
                    switch result {
                    case .success(let response):
//                        dump(response)
                        guard let response = response as? InprogressModel else {
                            break
                        }
                        self.rebornDatas = response.result
                        self.defaultView.isHidden = true
                        self.defaultView.backgroundColor = .clear
                        
                        if self.rebornDatas.isEmpty {
                            self.defaultView.isHidden = false
                        }
                    default:
                        self.defaultView.isHidden = false
                        break
                    }
                    self.collectionView.reloadData()
           
            
                }
        
    }
    @IBAction func getNumber(_ sender: Any) {
        let detail = UIStoryboard.init(name: "MyReborn", bundle: nil)
        guard let Checkvc = detail.instantiateViewController(identifier: "historyDetailVC") as? RebornHistoryDetailViewController else {
                    return
                }
        
        navigationController?.pushViewController(Checkvc, animated: true)
    }
    
}

extension HomeInprogressViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rebornDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RebornCell", for: indexPath) as! InprogressCollectionViewCell
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 0
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowOpacity = 0.15
        cell.layer.shadowRadius = 10
        cell.contentView.layer.masksToBounds = true
        cell.layer.masksToBounds = false
        
        let rebornData = rebornDatas[indexPath.row]
        let url = URL(string: rebornData.productImg ?? "")
        cell.ongoingImg.load(url: url!)
        cell.ongoingName.text = rebornData.storeName
        cell.ongoingtime.text = rebornData.productLimitTime
        cell.ongoingCategory.text = rebornData.category
        cell.ongoingProduct.text = rebornData.productName
        
        
        return cell
    }
}
extension HomeInprogressViewController: UICollectionViewDelegateFlowLayout {
    
    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
        
    }

    // cell 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = 338
        let height = 165

        let size = CGSize(width: width, height: height)
        return size
    }
    
    
}
