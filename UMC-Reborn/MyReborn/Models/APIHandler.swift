//
//  APIHandler.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/02/07.
//

// ================ API GET Request ================

import Foundation
import Alamofire

class APIHandler {
    static let sharedInstance = APIHandler()
    
    func HistoryRebornGetData(handler: @escaping(_ apiData:[HistoryRebornModel])->(Void)) {
        
        let url = "http://www.rebornapp.shop/reborn/history/detail/3"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { responce in
            switch responce.result {
            case .success(let data):
                do {
                    let jsondata = try JSONDecoder().decode([HistoryRebornModel].self, from: data!)
                    handler(jsondata)
                    print(responce)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct HistoryRebornModel: Codable {
    let userIdx: Int
    let rebornTaskIdx: Int
}
