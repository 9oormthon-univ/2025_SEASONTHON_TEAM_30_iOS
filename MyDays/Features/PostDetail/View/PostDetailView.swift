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
    let postId: String
    
    var body: some View {
        ScrollView {
            if let post = vm.post {
                VStack(spacing: 0) {
                    //게시물
                    DetailPostView(
                        post: post,
                        onLike: {
                            vm.postLike()
                        },
                        onMore: {
                            vm.isShowActionSheet.toggle()
                        }
                    )
                    .padding(.horizontal, 24)
                    
                    //구분선
                    Divider()
                        .frame(height: 1)
                        .overlay(.mdNavi2)
                        .padding(.horizontal, 24)
                    
                    //댓글 리스트
                    LazyVStack(spacing: 20) {
                        ForEach(vm.comments) { comment in
                            DetailCommentView(comment: comment)
                                .padding(.horizontal, 24)
                        }
                    }
                    .padding(.top, 20)
                }
                .padding(.bottom, 20) //마지막 게시물이랑 간격 차이
                .padding(.top, 36) //safeAreaTop 이랑 게시물사이 간격
            }
        }
        .background(.mdSurf3)
        .padding(.top, -8) // ScrollView, safeAreaInset간에 조그만 gap 크기만큼 조정
        .onTapGesture {
            isFocused = false //다른데 터치하면 포커스 풀리기
        }
        .toolbar(.hidden, for: .navigationBar)
        //상단 바 (챌린지 피드 + 뒤로가기 버튼)
        .safeAreaInset(edge: .top) {
            HStack(spacing: 0) {
                //뒤로가기 버튼
                Image("back")
                    .onTapGesture {
                        nav.popLast()
                    }
                Spacer()
            }
            .overlay(
                Text("챌린지 피드")
                    .font(.b1())
                    .foregroundColor(.white)
            )
            .padding(.top, 10)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .padding(.horizontal, 30)
            .background(.mdSurf3)
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
        //더보기 아이콘 눌렀을 때 액션시트
        .confirmationDialog("", isPresented: $vm.isShowActionSheet) {
            Button("삭제하기", role: .destructive) {
                vm.isShowAlert.toggle()
            }
            Button("취소", role: .cancel) {}
        }
        //삭제하기 알럿
        .alert("정말로 삭제하시겠습니까?", isPresented: $vm.isShowAlert) {
            Button("확인", role: .none) {
                vm.deletePost()
            }
            Button("취소", role: .cancel) {}
        }
        //삭제완료 후 감지해서 이전뷰로 이동
        .onChange(of: vm.isCompleteDelete) { _, newValue in
            if newValue {
                nav.popLast() //이전 뷰로
                vm.isCompleteDelete = false // 플래그 리셋 (중복 이동 방지)
            }
        }
        //디테일 뷰 조회 시
        .onAppear {
            vm.getPostDetail()
        }
    }
}

#Preview {
    NavigationStack {
        PostDetailView(postId: PostDetail.mock.id)
    }
}
