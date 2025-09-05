//
//  PostDetailService.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//

//MARK: - 게시물 세부 화면 서버 연동 로직
import Alamofire
import Foundation

// MARK: - PostDetailService Protocol
protocol PostDetailServiceProtocol {
    func getPostDetail(postId: String) async throws -> (PostDetail, [PostDetailComment])
    func sendComment(request: SendCommentRequest) async throws -> EmptyData
    func postlike(postId: String) async throws -> EmptyData
    func deletePost(request: DeletePostRequest) async throws -> EmptyData
}

// MARK: - PostDetailService (실제 API 통신)
class PostDetailService: PostDetailServiceProtocol {
    // 디테일 페이지 조회 요청
    func getPostDetail(postId: String) async throws ->  (PostDetail, [PostDetailComment]) {
        let response: GetPostDetailResponse = try await APIManager.shared.request("/posts/\(postId)", method: .get)
        
        let post = PostDetail(from: response.post)
        let comments = response.comments.map { PostDetailComment(from: $0) }
        
        return (post, comments)
    }
    
    // 댓글 전송
    func sendComment(request: SendCommentRequest) async throws -> EmptyData {
        let parameters: Parameters = [
            "postId": request.postId,
            "content": request.content
        ]
        
        let response: EmptyData = try await APIManager.shared.request("/posts/comments", method: .post, parameters: parameters, encoding: JSONEncoding.default)
        
        return response
    }
    
    // 좋아요 기능
    func postlike(postId: String) async throws -> EmptyData {
        let parameters: Parameters = [
            "postId": postId
        ]
        
        let response: EmptyData = try await APIManager.shared.request("/posts/comments", method: .post, parameters: parameters, encoding: JSONEncoding.default)
        
        return response
    }
    
    // 게시물 삭제
    func deletePost(request: DeletePostRequest) async throws -> EmptyData {
        let parameters: Parameters = [
            "postId": request.postId
        ]
        
        let response: EmptyData = try await APIManager.shared.request("/posts/comments", method: .post, parameters: parameters, encoding: JSONEncoding.default)
        
        return response
    }
}

//MARK: - MockPostDetailService (테스트용)
class MockPostDetailService: PostDetailServiceProtocol {
    // 디테일 페이지 조회 요청
    func getPostDetail(postId: String) async throws -> (PostDetail, [PostDetailComment]) {
//        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        return (PostDetail.mock, PostDetailComment.mockComments)
    }
    
    // 댓글 전송
    func sendComment(request: SendCommentRequest) async throws -> EmptyData {
        return EmptyData()
    }
    
    // 좋아요 기능
    func postlike(postId: String) async throws -> EmptyData {
        return EmptyData()
    }
    
    // 게시물 삭제
    func deletePost(request: DeletePostRequest) async throws -> EmptyData {
        return EmptyData()
    }
}
