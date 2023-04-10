//
//  ReviewModel.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/06.
//

import Foundation

struct ReviewList: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [ReviewListModel]
}

struct ReviewListModel: Codable {
    var reviewIdx, userIdx: Int
    var userImg: String?
    var userNickname, storeName, storeCategory: String
    var rebornIdx: Int
    var productName: String
    var reviewScore: Int
    var reviewComment: String
    var reviewImg: String?
    var reviewCreatedAt: String
}

struct ReviewCountList: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: Int
}
