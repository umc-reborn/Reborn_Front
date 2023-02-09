//
//  RebornHistoryModel.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/02/08.
//

import Foundation

struct RebornHistoryModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    var result: [RebornHistoryResponse]
}

struct RebornHistoryResponse: Codable {
    let rebornTaskIdx: Int
    let storeName: String
    let storeImage: String
    let storeScore: Double
    let category: String
    let status: String
    let createdAt: String
}
