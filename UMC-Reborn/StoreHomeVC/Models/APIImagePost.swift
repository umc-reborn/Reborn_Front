//
//  APIImagePost.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/03/23.
//

import Foundation

struct ImageresultModel : Codable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : String
}
