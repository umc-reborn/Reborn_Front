//
//  RebornHistoryDetailModel.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/02/08.
//

import Foundation

struct RebornHistoryDetailModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    var result: [RebornHistoryDetailResponse]
}

struct RebornHistoryDetailResponse: Codable {
    let productName: String
    let productGuide: String
    let productComment: String
    let storeName: String
    let storeImage: String
    let storeAddress: String
    let category: String
    let productExchangeCode: Int
    let createdAt: String
    let status: String
}
