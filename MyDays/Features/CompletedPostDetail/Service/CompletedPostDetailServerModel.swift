//
//  CompletedPostDetailServerModel.swift
//  MyDays
//
//  Created by 양재현 on 9/4/25.
//

//MARK: - 완료한 디테일 페이지 서버모델
import Foundation

//완료한 디테일 페이지 조회 Response
struct CompletedDetailResponse: Decodable {
    //미션 내용
    let mission: MissionResponse
    let post: PostsResponse
    let comments: [CommentsResponse]
    
    struct MissionResponse: Decodable {
        let date: String
        let missionText: String
    }
    
    //게시물
    struct PostsResponse: Decodable {
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
        let isOwner: Bool
    }
    
    //댓글
    struct CommentsResponse: Decodable {
        let commentId: String
        let userimgUrl: String
        let userName: String
        let userTitle: String
        let userTitleColor: String
        let createdAt: String
        let content: String
    }
    
   
}
