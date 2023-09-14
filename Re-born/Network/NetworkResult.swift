//
//  NetworkResult.swift
//  Re-born
//
//  Created by jaegu park on 11/09/23.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
