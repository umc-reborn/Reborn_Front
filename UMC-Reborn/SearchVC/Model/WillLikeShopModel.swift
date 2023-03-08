//
//  WillLikeShopModel.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/02/26.
//

import Foundation


struct WillLikeShopModel : Codable {
    let isSuccess : Bool
    let code : Int
    let message : String
    var result : [LikeShopsponse]
}

struct LikeShopsponse : Codable {
    let storeIdx: Int
    let storeName : String
    let userImage: String
    let hasJjim : Bool
    let storeScore : Float
    let category : String
}
