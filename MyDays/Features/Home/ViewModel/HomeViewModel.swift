//
//  HomeViewModel.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//

//MARK: - 홈 뷰 모델 입니다.
import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var mission: HomeMission? //홈 미션 모델
    @Published var posts: [Post] = [] //게시물들
    @Published var isLoading: Bool = false
    
    private let homeService = MockHomeService() //의존성 주입 (Real or Mock)
    
    // 💡 무한 스크롤을 위한 상태 변수
    @Published var currentPage = 1 // 현재 페이지 번호
    @Published  var hasMorePages = true // 더 이상 페이지가 없는지 여부
    
    //MARK: - 홈 조회
    //    func getHome() {
    //
    //        isLoading = true
    //        print("로딩 true")
    //        Task{
    //
    //            // HomeService의 getHome()을 호출하여 데이터를 가져옵니다.
    //            let (profile, fetchedPosts) = try await homeService.getHomePosts(page: currentPage)
    //
    //            // 성공 시, @Published 속성을 업데이트하여 뷰를 갱신합니다.
    //            self.userProfile = profile
    //            self.posts = fetchedPosts
    //
    //            isLoading = false
    //            print("로딩 false")
    //        }
    //    }
    func getHome() {
        guard !isLoading && hasMorePages else {
            print("이미 로딩중 or 더 이상 페이지업음")
            return }
        isLoading = true
        
        Task {
            let fetchedPosts = try await homeService.getHomePosts(page: currentPage)
            
            
            if fetchedPosts.isEmpty {
                self.hasMorePages = false
            } else {
                self.posts.append(contentsOf: fetchedPosts)
                self.currentPage += 1
            }
            self.isLoading = false
        }
    }
    //MARK: - 미션 조회
    func getMission() {
        Task {
            let fetchedMission = try await homeService.getHomeMission()
            self.mission = fetchedMission
        }
    }
}
