//
//  ReviewManageModel.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/02/09.
//

import Foundation

struct ReviewManageModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    var result: [ReviewManageModelResponse]
}

struct ReviewManageModelResponse: Codable {
    let reviewIdx: Int
    let userIdx: Int
    let userImg: String
    let userNickname: String
    let storeName: String
    let storeCategory: String
    let rebornIdx: Int
    let productName: String
    let reviewScore: Int
    let reviewComment: String
    let reviewCreatedAt: String
    let reviewImg: reviewImgResult
}

struct reviewImgResult : Codable {
    let reviewImage1 : String
    let reviewImage2 : String?
    let reviewImage3 : String?
    let reviewImage4 : String?
    let reviewImage5 : String?
}

//struct ReviewManageList: Codable {
//    let isSuccess:Bool
//    let code: Int
//    let message: String
//    let result: [ReviewManageListModel]
//}

//struct ReviewManageListModel: Codable {
//    let reviewImgList: [String]
//}
