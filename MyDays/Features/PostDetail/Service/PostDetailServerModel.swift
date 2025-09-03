//
//  PostDetailServerModel.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//

//MARK: - 게시물 디테일 뷰 서버모델
import Foundation

//게시물 디테일 뷰 조회 Response
struct GetPostDetailResponse: Decodable {
    let post: PostsResponse
    let comments: [CommentsResponse]
    
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
    }
    
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

//댓글 전송 Request
struct SendCommentRequest: Decodable {
    let postId: String
    let content: String
}

//게시물 삭제 Request
struct DeletePostRequest: Decodable {
    let postId: String
}
