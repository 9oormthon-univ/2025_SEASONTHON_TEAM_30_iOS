//
//  WriteServerModel.swift
//  MyDays
//
//  Created by 양재현 on 8/30/25.
//

//MARK: - 작성화면 서버모델
import Foundation

//작성화면 페이지 조회 Response
struct GetWritePageResponse: Decodable {
    let missionText: String
}

//게시물 작성 Request
struct PostMissionRequest: Decodable {
    let content: String
    let base64Img: String
}

//게시물 작성 Response
struct PostMissionResponse: Decodable, Equatable {
    let postId: String
}
