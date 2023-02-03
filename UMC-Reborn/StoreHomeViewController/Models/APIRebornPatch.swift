//
//  APIRebornPatch.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/01.
//

import Foundation

struct RebornPatchModel:Codable {
    let rebornIdx:Int
    let productName:String
    let productGuide:String
    let productComment:String
    let productImg:String
    let productLimitTime:String
    let productCnt:Int
}
