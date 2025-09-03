//
//  CompletedPostDetailService.swift
//  MyDays
//
//  Created by 양재현 on 9/4/25.
//

//MARK: - 완료한 게시물 세부 화면 서버 연동 로직
import Alamofire
import Foundation

// MARK: - CompletedPostDetailService Protocol
protocol CompletedPostDetailServiceProtocol {
    func getCompletedPostDetail(postId: String) async throws -> (CompletedMission, PostDetail, [PostDetailComment])
    func sendComment(request: SendCommentRequest) async throws -> EmptyData
    func postlike(postId: String) async throws -> EmptyData
    func deletePost(postId: String) async throws -> EmptyData
}

// MARK: - PostDetailService (실제 API 통신)
class CompletedPostDetailService: CompletedPostDetailServiceProtocol {
    // 완료한 디테일 페이지 조회 요청
    func getCompletedPostDetail(postId: String) async throws ->  (CompletedMission, PostDetail, [PostDetailComment]) {
        let parameters: Parameters = [
            "postId": postId
        ]
        
        let response: CompletedDetailResponse = try await APIManager.shared.request("/posts/{postId}", method: .get, parameters: parameters)
        
        let mission = CompletedMission(from: response.mission)
        let post = PostDetail(from: response.post)
        let comments = response.comments.map { PostDetailComment(from: $0) }
        
        return (mission, post, comments)
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
    func deletePost(postId: String) async throws -> EmptyData {
        let parameters: Parameters = [
            "postId": postId
        ]
        
        let response: EmptyData = try await APIManager.shared.request("/posts/comments", method: .post, parameters: parameters, encoding: JSONEncoding.default)
        
        return response
    }
}

//MARK: - MockCompletedPostDetailService (테스트용)
class MockCompletedPostDetailService: CompletedPostDetailServiceProtocol {
    // 완료한 디테일 페이지 조회 요청
    func getCompletedPostDetail(postId: String) async throws -> (CompletedMission, PostDetail, [PostDetailComment]) {
//        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        return (CompletedMission.mock, PostDetail.mock, PostDetailComment.mockComments)
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
    func deletePost(postId: String) async throws -> EmptyData {
        return EmptyData()
    }
}
