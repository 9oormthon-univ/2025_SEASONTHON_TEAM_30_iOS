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
    @Published var isShowActionSheet: Bool = false //액션 시트 보여줄지
    @Published var isShowAlert: Bool = false //삭제 알럿 보여줄지
    @Published var isCompleteDelete: Bool = false //삭제 완료 후 네비게이션 트리거
    
    private let postDetailService = PostDetailService() //의존성 주입 (Real or Mock)

    //MARK: - 디테일 뷰 조회
    func getPostDetail(postId: String) {
        Task {
            do {
                let (fetchedPost, fetchedComments) = try await postDetailService.getPostDetail(postId: postId)
                
                self.post = fetchedPost
                self.comments = fetchedComments
            }
            catch let error as APIError {
                print(error.localizedDescription)
            }
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
            
            self.getPostDetail(postId: postId) //댓글 전송 후 새로고침을 위해
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
    
    //MARK: - 게시물 삭제
    func deletePost() {
        guard let postId = self.post?.id else { return }
        Task {
            do {
                _ = try await postDetailService.deletePost(request: DeletePostRequest(
                    postId: postId
                ))
                self.isCompleteDelete = true //네비게이션 트리거
            }
            catch {
                
            }
        }
    }
}
