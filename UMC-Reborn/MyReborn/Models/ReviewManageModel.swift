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
    var reviewImg: ReviewImg
}

struct ReviewImg: Codable {
    let reviewImage1: String
}
