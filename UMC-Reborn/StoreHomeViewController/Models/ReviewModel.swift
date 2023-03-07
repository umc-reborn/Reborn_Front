//
//  ReviewModel.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/06.
//

import Foundation

struct ReviewList: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [ReviewListModel]
}

struct ReviewListModel: Codable {
    let reviewIdx, userIdx: Int
    let userImg: String?
    let userNickname, storeName, storeCategory: String
    let rebornIdx: Int
    let productName: String
    let reviewScore: Int
    let reviewComment: String
    let reviewImgList: [String?]
    let reviewCreatedAt: String
}

struct ReviewStoreList: Codable {
    let isSuccess:Bool
    let code: Int
    let message: String
    let result: [ReviewStoreListModel]
}

struct ReviewStoreListModel: Codable {
    let reviewImgList: [String]
}



struct ReviewCountList: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Int
}
