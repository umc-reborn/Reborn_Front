//
//  JoinNeighborPost.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/07.
//

import Foundation
import Alamofire

struct joinNeiModel: Encodable {
    var userId : String
    var userEmail : String
    var userPwd : String
    var userNickname : String
    var userAdAgreement : String
    var userBirthDate : Int
    var userAddress : String
    var userLikes : String
}

// 이미지도 보내야 함

class JoinNeighborPost {
    static let instance = JoinNeighborPost()
    
    //func sendingPostJoinNeighbor(parrrmeter: )
}


struct jnModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: joinResultModel
}

struct joinResultModel: Codable {
    let userIdx: Int
    let userNickname: String
    let jwt: String
}
