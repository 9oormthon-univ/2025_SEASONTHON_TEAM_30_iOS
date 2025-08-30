//
//  PostDetailView.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//

//MARK: - 작성글 디테일 뷰
import Kingfisher
import SwiftUI

struct PostDetailView: View {
    @StateObject var vm = PostDetailViewModel()
    @FocusState var isFocused: Bool //댓글 포커스 상태
    @EnvironmentObject var nav: NavigationManager
    
    var body: some View {
        ScrollView {
            if let post = vm.post {
                VStack(spacing: 0) {
                    //게시물
                    DetailPostView(
                        post: post,
                        onLike: {
                            vm.postLike()
                        }
                    )
                    .padding(.horizontal, 30)
                    
                    //구분선
                    Divider()
                        .frame(height: 1)
                        .overlay(.mdSurf2)
                        .padding(.horizontal, 30)
                        .padding(.top, 20)
                    
                    //댓글 리스트
                    LazyVStack(spacing: 20) {
                        ForEach(vm.comments) { comment in
                            DetailCommentView(comment: comment)
                                .padding(.horizontal, 30)
                        }
                    }
                    .padding(.top, 20)
                }
                .padding(.top, 20) //safeAreaTop 이랑 게시물사이 간격
            }
        }
        .onTapGesture {
            isFocused = false //다른데 터치하면 포커스 풀리기
        }
        .toolbar(.hidden, for: .navigationBar)
        //상단 바 (챌린지 피드 + 뒤로가기 버튼)
        .safeAreaInset(edge: .top) {
            Text("챌린지 피드")
                .font(.b1())
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(.white)
                .dropshadow1()
                //뒤로 가기 버튼
                .overlay(alignment: .leading) {
                    Image("back")
                        .onTapGesture {
                            nav.popLast()
                        }
                        .padding(.horizontal, 30)
                }
        }
        //댓글 텍스트 에디터
        .safeAreaInset(edge: .bottom) {
            VStack{
                TextEditor(text: $vm.commentText)
                    .focused($isFocused)
                    .commentTextEditorStyle(
                        text: $vm.commentText,
                        isFocused: isFocused,
                        onSend: {
                            isFocused = false
                            vm.sendComment()
                        })
                
            }
            .padding(.horizontal, 30)
        }
        //디테일 뷰 조회 시
        .onAppear {
            vm.getPostDetail()
        }
    }
}

#Preview {
    PostDetailView()
}
