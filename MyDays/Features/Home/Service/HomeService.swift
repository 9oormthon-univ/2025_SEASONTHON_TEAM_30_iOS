//
//  HomeService.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//

//MARK: - 홈 화면 서버 연동 로직
import Alamofire
import Foundation

// MARK: - HomeService Protocol
// 실제 서비스와 Mock 서비스 모두 이 프로토콜을 따릅니다.
protocol HomeServiceProtocol {
    func getHomePosts(page: Int) async throws -> [Post]
}

// MARK: - HomeService (실제 API 통신)
// HomeServiceProtocol을 채택하여 실제 서버와 통신하는 역할을 합니다.
class HomeService {
    // 서버로부터 홈 게시물 조회 요청
    func getHomePosts(page: Int) async throws -> [Post] {

        // APIManager를 사용해 서버로부터 데이터 가져오기
        let response: GetHomeResponse = try await APIManager.shared.request("/profile", method: .get)
        
        // 서버 모델을 앱 모델로 변환
        let posts = response.posts.map { Post(from: $0) }
        
        return posts
    }
}

//MARK: - MockHomeService (테스트용)
class MockHomeService {
    // 서버로부터 홈 조회 요청
    func getHomePosts(page: Int) async throws -> [Post] {
//        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // 페이지당 게시물 수를 정의합니다.
            let pageSize = 5
        
        // Mock 데이터 배열을 가져옵니다.
                let allPosts = Post.mockPosts
                
                // 시작 인덱스와 끝 인덱스를 계산합니다.
                let startIndex = (page - 1) * pageSize
                let endIndex = startIndex + pageSize
                
                // 인덱스가 유효한지 확인하고, 유효한 범위의 게시물만 잘라냅니다.
                guard startIndex < allPosts.count else {
                    print("Mock: 더이상 데이터 없어요")
                    return [] // 더 이상 데이터가 없으면 빈 배열 반환
                }
                
                let endIndexWithBounds = min(endIndex, allPosts.count)
                let paginatedPosts = Array(allPosts[startIndex..<endIndexWithBounds])
                
                return paginatedPosts
//        return (UserProfile.mock, Post.mockPosts)
    }
}
