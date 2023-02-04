////
////  JoinLoginAPIHandler.swift
////  UMC-Reborn
////
////  Created by 김예린 on 2023/02/03.
////
//
//import Foundation
//import Alamofire
//
//
//struct Model:Encodable {
//    var nId:String
//    var nPw:String
//}
//
//class JoinLoginAPIHandler {
//    static let instance = JoinLoginAPIHandler()
//
//    func SendingPostRequest(){
//        let url = "/users/log-in"
//        let headers:HTTPHeaders = [
//            "content-type" : "application/json"
//        ]
//
//        AF.request(url, method:.post, parameters: pparameters, encoder: JSONParameterEncoder.default, headers: headers).response { rresponse in
//            switch rresponse.result {
//            case .success(let data):
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
//                    print(json)
//
//                    let jsonresult = try JSONDecoder().decode([TrainModel].self, from: data!)
//                    handler(jsonresult)
//
//                }catch {
//                    print(error.localizedDescription)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//}
//
//struct TrainModel:Codable {
//    var isSuccess: Bool
//    var code: Int
//    var message: String
//    var result: ResultModel
//    var storeName : String
//
//}
//
//struct ResultModel: Codable {
//    var userIdx: Int
//    var userNickname : String
//    var jwt: String
//}
