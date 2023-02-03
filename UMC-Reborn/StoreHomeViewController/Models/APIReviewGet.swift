//
//  APIReviewGet.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/31.
//

import Foundation
import Alamofire

class APIHandlerReviewGet {
    static let sharedInstance = APIHandlerReviewGet()
    
    func SendingGetReview(handler: @escaping(_ apiData:[ReviewList])->(Void)) {
        let url = ""
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { responce in
            switch responce.result {
            case .success(let data):
                do {
                    let jsondata = try JSONDecoder().decode([ReviewList].self, from: data!)
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

struct ReviewList:Codable {
    let isSuccess:Bool
    let code:Int
    let message:String
    let result:ReviewListModel
}

struct ReviewListModel:Codable {
    let reviewIdx:Int
    let userIdx:Int
    let userImge:String
    let userNickname:String
    let storeName:String
    let storeCategory:String
    let rebornIdx:Int
    let productName:String
    let reviewScore:Int
    let reviewComment:String
    let reviewImage1:String
    let reviewImage2:String
    let reviewImage3:String
    let reviewImage4:String
    let reviewImage5:String
    let reviewCreatedAt:String
}

class APIHandlerReviewCount {
    static let sharedInstance = APIHandlerReviewCount()
    
    func SendingGetReviewCount(handler: @escaping(_ apiData:[ReviewCount])->(Void)) {
        let url = ""
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { responce in
            switch responce.result {
            case .success(let data):
                do {
                    let jsondata = try JSONDecoder().decode([ReviewCount].self, from: data!)
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

struct ReviewCount:Codable {
    let isSuccess:Bool
    let code:Int
    let message:String
    let result:Int
}
