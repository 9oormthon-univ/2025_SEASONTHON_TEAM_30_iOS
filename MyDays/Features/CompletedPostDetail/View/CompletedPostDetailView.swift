//
//  CompletedPostDetailView.swift
//  MyDays
//
//  Created by 양재현 on 9/4/25.
//

//MARK: - 완료한 게시물 디테일 뷰
import Kingfisher
import SwiftUI

struct CompletedPostDetailView: View {
    @StateObject var vm = CompletedPostDetailViewModel()
    @FocusState var isFocused: Bool //댓글 포커스 상태
    @Environment(\.dismiss) var dismiss
    let postId: String
    
    var body: some View {
        ZStack {
            Color.mdSurf3.ignoresSafeArea() //로딩중에도 백그라운드 주기위해서
            ScrollView(showsIndicators: false) {
                if let mission = vm.mission, let post = vm.post {
                    VStack(spacing: 0) {
                        //미션카드
                        CalendarMissionCard(date: mission.date, mission: mission.text, isCompleted: true)
                            .padding(.horizontal, 30)
                        
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
                        .padding(.top, 36)
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
                    .padding(.top, 20) //safeAreaTop 이랑 게시물사이 간격
                }
            }
        }
        .background(.mdSurf3)
        .padding(.top, -8) // ScrollView, safeAreaInset간에 조그만 gap 크기만큼 조정
        .onTapGesture {
            isFocused = false //다른데 터치하면 포커스 풀리기
        }
        .toolbar(.hidden, for: .navigationBar)
        //상단 헤더
        .safeAreaInset(edge: .top) {
            VStack(spacing: 0) {
                Text("내가 완료한 챌린지")
                    .font(.b1())
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity)
                    .frame(height: 66)
                    .background(.mdSurf3)
                //X 버튼
                    .overlay(alignment: .trailing) {
                        Image("close")
                            .onTapGesture {
                                dismiss()
                            }
                            .padding(.horizontal, 30)
                    }
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
            .padding(.horizontal, 22.5)
            .padding(.bottom, 10)
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
                dismiss()
                vm.isCompleteDelete = false // 플래그 리셋 (중복 이동 방지)
            }
        }
        //디테일 뷰 조회 시
        .onAppear {
            vm.getCompltedPostDetail(postId: postId)
        }
    }
}

#Preview {
    NavigationStack {
        CompletedPostDetailView(postId: PostDetail.mock.id)
    }
}
