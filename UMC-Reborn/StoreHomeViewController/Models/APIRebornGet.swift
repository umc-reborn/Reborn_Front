//
//  APIHandlerGet.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/30.
//

import Foundation
import Alamofire

class APIHandlerGet {
    static let sharedInstance = APIHandlerGet()
    
    func SendingGetReborn(handler: @escaping(_ apiData:[RebornListModel])->(Void)) {
        let url = "http://www.rebornapp.shop/reborns/store/1"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { responce in
            switch responce.result {
            case .success(let data):
                do {
                    let jsondata = try JSONDecoder().decode([RebornListModel].self, from: data!)
                    handler(jsondata)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct RebornList:Codable {
    let isSuccess:Bool
    let code:Int
    let message:String
    let result:RebornListModel
}

struct RebornListModel:Codable {
    let rebornIdx:Int
    let productName:String
    let productGuide:String
    let productComment:String
    let productImg: String
    let productLimitTime:String
    let productCnt:Int
    let status:String
}
