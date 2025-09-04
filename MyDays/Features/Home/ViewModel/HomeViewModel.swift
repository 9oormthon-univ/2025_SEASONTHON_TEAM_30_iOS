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
    
    @Published var isFirstLoading: Bool = false //처음 홈 조회 로딩
    @Published var isMoreLoading: Bool = false //게시물 더 받아올때 로딩
    @Published var isRefreshing: Bool = false //리프레쉬 로딩
    
    private let homeService = MockHomeService() //의존성 주입 (Real or Mock)
    
    // 💡 무한 스크롤을 위한 상태 변수
    @Published var currentPage = 1 // 현재 페이지 번호
    @Published var hasMorePages = true // 더 이상 페이지가 없는지 여부
    
    init() {
        getHomeFirst()
    }
    //MARK: - 홈 첫 조회
    func getHomeFirst() {
        self.isFirstLoading = true
        Task {
            do {
                getMission()
                let fetchedPosts = try await homeService.getHomePosts(page: currentPage)
                
                self.posts = fetchedPosts
                self.currentPage += 1
            }
            catch {
                print("‼️홈 첫 조회 오류")
            }
            self.isFirstLoading = false
        }
    }
    
    //MARK: - 스크롤로 게시물 더 가져올때
    func getMorePosts() {
        // 이미 페이지를 불러오고 있거나 더 이상 페이지가 없으면 무시
        guard !isMoreLoading && hasMorePages else {
            print("더 이상 페이지 없음")
            return
        }
        self.isMoreLoading = true
        
        Task {
            do {
                let fetchedPosts = try await homeService.getHomePosts(page: currentPage)
                
                if fetchedPosts.isEmpty {
                    self.hasMorePages = false
                } else {
                    self.posts.append(contentsOf: fetchedPosts)
                    self.currentPage += 1
                }
            }
            catch {
                print("‼️게시물 더 받기 오류")
            }
            self.isMoreLoading = false
        }
    }
    
    //MARK: - 새로고침
    func refreshHome() {
        Task {
            self.currentPage = 1
            self.hasMorePages = true
            
            do {
                let fetchedPosts = try await homeService.getHomePosts(page: currentPage)
                self.posts = [] // 기존 게시물 초기화
                
                
                self.posts = fetchedPosts
                self.currentPage += 1
            } catch {
                print("‼️새로고침 오류")
            }
        }
    }
    
    //MARK: - 좋아요 누르기/취소
    func postLike(post: Post) {
        Task {
            do {
                _ = try await homeService.postlike(postId: post.id)
                // posts 배열에서 해당 post 인덱스 찾기
                if let index = posts.firstIndex(where: { $0.id == post.id }) {
                    posts[index].isLiked.toggle()          // 좋아요 상태 반전
                    posts[index].likeCount += posts[index].isLiked ? 1 : -1 // 좋아요 카운트 변경
                }
            }
            catch {
                print("‼️좋아요 오류")
            }
        }
    }
    
    //MARK: - 미션 조회
    func getMission() {
        Task {
            do {
                let fetchedMission = try await homeService.getHomeMission()
                self.mission = fetchedMission
            }
            catch {
                print("‼️미션받기 오류")
            }
        }
    }
}
