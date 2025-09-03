//
//  SetNicknameServerModel.swift
//  MyDays
//
//  Created by 양재현 on 9/3/25.
//

//MARK: - 닉네임 정하기 서버 모델
import Foundation

//닉네임 등록 요청
struct PostNicknameRequest: Decodable {
    let nickName: String
}
