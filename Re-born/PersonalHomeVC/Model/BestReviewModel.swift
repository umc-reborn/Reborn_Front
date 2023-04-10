//
//  BestReviewModel.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/02/05.
//

import Foundation

struct BestReviewModel : Codable {
    let isSuccess : Bool
    let code : Int
    let message : String
    var result : [BestReivewResponse]
}

struct BestReivewResponse : Codable {
    let reviewIdx: Int
    let userIdx: Int
    let userImg: String?
    let userNickname : String
    let storeName : String
    let storeCategory : String
    let rebornIdx : Int
    let productName: String
    let reviewScore: Int
    let reviewComment : String
    let reviewImage1 : String
    let reviewImage2 : String?
    let reviewImage3 : String?
    let reviewImage4 : String?
    let reviewImage5 : String?
    let reviewCreatedAt : String
}
