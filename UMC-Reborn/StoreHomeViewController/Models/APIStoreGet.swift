//
//  APIStoreGet.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/31.
//

import Foundation
import Alamofire

class APIHandlerStoreGet {
    static let sharedInstance = APIHandlerStoreGet()
    
    func SendingGetStore(handler: @escaping(_ apiData:[StoreListModel])->(Void)) {
        let url = "http://www.rebornapp.shop/store/9"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { responce in
            switch responce.result {
            case .success(let data):
                do {
                    let jsondata = try JSONDecoder().decode([StoreListModel].self, from: data!)
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

struct StoreList:Codable {
    let isSuccess:Bool
    let code:Int
    let message:String
    let result:StoreListModel
}

struct StoreListModel:Codable {
    let storeIdx:Int
    let storeName:String
    let storeImage:String
    let storeAddress:String
    let storeDescription:String
    let storeScore:Float
    let category:String
}
