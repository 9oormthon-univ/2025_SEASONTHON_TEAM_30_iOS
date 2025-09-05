//
//  CalendarServerModel.swift
//  MyDays
//
//  Created by 양재현 on 8/31/25.
//

//MARK: - 캘린더 뷰 서버모델
import Foundation

//주 단위 캐린더 조회 Response
struct GetWeeksResponse: Decodable {
    let dayContents: [DayContentsResponse]
    
    struct DayContentsResponse: Decodable {
        //미션 내용들
        let day: Int
        let date: String
        let missionText: String
        let isCompleted: Bool
        
        let post: PostResponse?
        
        struct PostResponse: Decodable {
            //게시물 내용들
            let postId: String
            let userimgUrl: String
            let userName: String
            let userTitle: String
            let userTitleColor: String
            let createdAt: String
            let content: String
            let contentImgUrl: String
            let likeCount: Int
            let isLiked: Bool
            let commentCount: Int
        }
    }
}

