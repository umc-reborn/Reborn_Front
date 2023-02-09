//
//  NetworkResult.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/04.
//  Created by nayeon  on 2023/02/01.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
