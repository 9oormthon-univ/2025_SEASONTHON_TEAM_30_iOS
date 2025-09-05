//
//  AP.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//

//MARK: - API통신에서 공통 Response 형태입니다.

import Foundation

struct EmptyData: Decodable {} //response body가 비었을 경우

struct ServerResponse<T: Decodable>: Decodable {
    let meta: Meta
    let body: T?
    
    struct Meta: Decodable {
        let code: Int
        let message: String
    }
}
