//
//  PostDetail.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//

//MARK: - 디테일 페이지 게시물 모델
import Foundation

struct PostDetail: Identifiable, Equatable {
    let id: String
    let userimgUrl: String //유저 이미지 Url
    let userName: String //유저 닉네임
    let userTitle: String //유저 칭호
    let userTitleColor: String //유저 칭호 색깔
    let createdAt: String //작성 시간
    let content: String //내용
    let contentImgUrl: String //게시물 이미지 Url
    var likeCount: Int //좋아요 개수
    var isLiked: Bool //좋아요 눌렀는지
    let commentCount: Int //댓글 개수
    let isOwner: Bool //게시물 주인인지
}

// 서버 응답 모델을 Post 모델로 매핑하기 위한 이니셜라이저
extension PostDetail {
    init(from data: GetPostDetailResponse.PostsResponse) {
        self.id = data.postId
        self.userimgUrl = APIManager.shared.baseURL + data.userimgUrl
        self.userName = data.userName
        self.userTitle = data.userTitle
        self.userTitleColor = data.userTitleColor
        self.createdAt = data.createdAt
        self.content = data.content
        self.contentImgUrl = APIManager.shared.baseURL + data.contentImgUrl
        self.likeCount = data.likeCount
        self.isLiked = data.isLiked
        self.commentCount = data.commentCount
        self.isOwner = data.isOwner
    }
}

// 완료한 디테일 페이지 서버 응답 모델을 Post 모델로 매핑하기 위한 이니셜라이저
extension PostDetail {
    init(from data: CompletedDetailResponse.PostsResponse) {
        self.id = data.postId
        self.userimgUrl = APIManager.shared.baseURL + data.userimgUrl
        self.userName = data.userName
        self.userTitle = data.userTitle
        self.userTitleColor = data.userTitleColor
        self.createdAt = data.createdAt
        self.content = data.content
        self.contentImgUrl = APIManager.shared.baseURL + data.contentImgUrl
        self.likeCount = data.likeCount
        self.isLiked = data.isLiked
        self.commentCount = data.commentCount
        self.isOwner = data.isOwner
    }
}


// MARK: - Mock 데이터
extension PostDetail {
    static let mock: PostDetail = PostDetail(
        id: "1",
        userimgUrl: "https://picsum.photos/50?1",
        userName: "나다",
        userTitle: "성실꾼",
        userTitleColor: "#FFDC68",
        createdAt: "2025-08-29",
        content: "오늘 날씨가 정말 좋네요!",
        contentImgUrl: "https://picsum.photos/200?1",
        likeCount: 12,
        isLiked: false,
        commentCount: 3,
        isOwner: true
    )
}
