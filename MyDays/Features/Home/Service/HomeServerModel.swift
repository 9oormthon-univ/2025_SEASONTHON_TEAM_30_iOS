//
//  HomeServerModel.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//

//MARK: - 홈 뷰 서버모델
import Foundation

//홈 조회 Response
struct GetHomePostsResponse: Decodable {
    let posts: [PostsResponse]
    
    struct PostsResponse: Decodable {
        // + pk (or Id) : String
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

//미션 조회 Response
struct GetHomeMissionResponse: Decodable {
    let day: String
    let text: String
    let isCompleted: Bool
}
