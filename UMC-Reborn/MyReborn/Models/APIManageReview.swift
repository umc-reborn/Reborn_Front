//
//  APIManageReview.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/02/07.
//

//import Foundation
//import Alamofire
//
//struct ManageReviewReqModel:Codable {
//    var reviewIdx:Int
//    var userIdx:Int
//    var userImg:UInt
//    var userNickname:String
//    var storeName:String
//    var storeCategory:String
//    var rebornIdx:Int
//    var productName:String
//    var reviewScore:Int
//    var reviewComment:String
//    var reviewImg:
//    var reviewImage1:String?
//    var reviewImage2:String?
//    var reviewImage3:String?
//    var reviewImage4:String?
//    var reviewImage5:String?
//    var reviewCreatedAt:String
//}
//
//struct reviewImg :Codable {
//    
//}
//
//struct ManageReviewReqResultModel: Codable {
//    var isSuccess:Bool
//    var code:Int
//    var message:String
//    var result:postReviewReqResult
//}
//
//struct ManageReviewReqResult: Codable {
//    var reviewIdx:Int
//}
//
//class APIMyRebornHandlerPost {
//    static let instance = APIMyRebornHandlerPost()
//    //
//    func SendingPostReborn(parameters: postReviewReqModel, handler: @escaping (_ result: [postReviewReqResultModel])->(Void)) {
//        let url = "http://www.rebornapp.shop/review"
//        let headers: HTTPHeaders = [
//            "content-type": "application/json",
//        ]
//
//        // ====================
//        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { responce in
//            switch responce.result {
//            case .success(let data):
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
//                    print(json)
//
//                    let jsonresult = try JSONDecoder().decode([postReviewReqResultModel].self, from: data!)
//                    handler(jsonresult)
//                } catch {
//                    print(error.localizedDescription)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//        // ====================
//    }
//    //
//    //
//
// }
