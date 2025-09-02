//
//  SplashServerModel.swift
//  MyDays
//
//  Created by 양재현 on 9/2/25.
//

//MARK: - 스플레쉬 서버 모델
import Foundation

//스플레쉬 조회 요청
struct GetSplashRequest: Decodable {
    let refreshToken: String? //없을 수도 있으니
}

//스플레쉬 조회 응답
struct GetSplashResponse: Decodable {
    let accessToken: String //백엔드 토큰
    let refreshToken: String //백엔드 토큰
}
