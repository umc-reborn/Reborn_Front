//
//  JjimModel.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/06.
//

import Foundation

struct JjimList: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [JjimListModel]
}

// MARK: - Result
struct JjimListModel: Codable {
    let jjimIdx, storeIdx: Int
    let storeName: String
    let storeImage: String?
    let storeCategory: String
    let storeScore: Int
}




struct JjimCountList: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Int
}
