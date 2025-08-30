//
//  PostDetailViewModel.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//

//MARK: - 게시물 디테일 뷰모델 입니다.
import Foundation

@MainActor
class PostDetailViewModel: ObservableObject {
    @Published var post: PostDetail? //게시물 정보
    @Published var comments: [PostDetailComment] = [] //댓글들
    @Published var commentText: String = "" //입력한 댓글 text
    
    private let postDetailService = MockPostDetailService() //의존성 주입 (Real or Mock)

    //MARK: - 디테일 뷰 조회
    func getPostDetail() {
        Task {
            let (fetchedPost, fetchedComments) = try await postDetailService.getPostDetail()
            
            self.post = fetchedPost
            self.comments = fetchedComments
        }
    }
    
    //MARK: - 댓글 전송
    func sendComment() {
        guard let postId = self.post?.id else { return }
        Task {
            _ = try await postDetailService.sendComment(request: SendCommentRequest(
                postId: postId,
                content: self.commentText
            ))
            
            self.commentText = ""
            
            self.getPostDetail() //댓글 전송 후 새로고침을 위해
        }
    }
    
    //MARK: - 좋아요 누르기/취소
    func postLike() {
        guard var post = self.post else { return }
        Task {
            do {
                _ = try await postDetailService.postlike(postId: post.id)
                //좋아요 이미 눌러져있다면
                if post.isLiked {
                    post.likeCount -= 1
                    post.isLiked = false
                }
                //좋아요 안눌러져있다면
                else {
                    post.likeCount += 1
                    post.isLiked = true
                }
                
                self.post = post //다시 포스트에 반영
            }
            catch {
                print("좋아요 누르기/취소 에러")
            }
        }
    }
}
