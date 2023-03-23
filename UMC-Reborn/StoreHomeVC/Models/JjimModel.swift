//
//  JjimModel.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/06.
//

import Foundation

struct JjimList: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [JjimListModel]
}

// MARK: - Result
struct JjimListModel: Codable {
    var jjimIdx, storeIdx: Int
    var storeName: String
    var storeImage: String?
    var storeCategory: String
    var storeScore: Float
}

struct JjimCountList: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: Int
}
