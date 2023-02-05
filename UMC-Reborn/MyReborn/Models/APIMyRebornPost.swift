//
//  APIMyRebornPost.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/02/03.
//

import Foundation
import Alamofire

struct postReviewReqModel:Codable {
    var userIdx:Int
    var rebornIdx:Int
    var reviewScore:UInt
    var reviewComment:String
}

struct postReviewImageModel:Codable {
    var images:String
}

struct postReviewReqResultModel: Codable {
    var isSuccess:Bool
    var code:Int
    var message:String
    var result:postReviewReqResult
}

struct postReviewReqResult: Codable {
    var reviewIdx:Int
}

class APIMyRebornHandlerPost {
    static let instance = APIMyRebornHandlerPost()
    //
    func SendingPostReborn(parameters: postReviewReqModel, handler: @escaping (_ result: [postReviewReqResultModel])->(Void)) {
        let url = "http://www.rebornapp.shop/review"
        let headers: HTTPHeaders = [
            "content-type": "application/json",
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { responce in
            switch responce.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    print(json)
                    
                    let jsonresult = try JSONDecoder().decode([postReviewReqResultModel].self, from: data!)
                    handler(jsonresult)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    //
    func uploadImage(_ photo: UIImage) {
        let url = "http://www.rebornapp.shop/review"
        let headers: HTTPHeaders = [
            "content-type": "image/png"
        ]
        
        AF.upload(multipartFormData: { (multipart) in
                        if let imageData = photo.jpegData(compressionQuality: 1) {
                            multipart.append(imageData, withName: "photo", fileName: "photo.png", mimeType: "image/png")
                            //이미지 데이터를 POST할 데이터에 덧붙임
                        }
                    }, to: url    //전달할 url
                    ,method: .post        //전달 방식
                    ,headers: headers).responseJSON(completionHandler: { (response) in    //헤더와 응답 처리
                        print(response)
                        
                        if let err = response.error{    //응답 에러
                            print(err)
                            return
                        }
                        print("success")        //응답 성공
                        
                        let json = response.data
                        
                        if (json != nil){
                            print(json)
                        }
                    })
    }
    //
}
