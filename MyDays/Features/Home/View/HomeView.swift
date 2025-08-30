//
//  HomeView.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//

//MARK: - 홈 화면(View) 입니다.
import Kingfisher
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var nav: NavigationManager
    @StateObject var vm = HomeViewModel()
    //TODO: 텍스트 길어질떄 줄바꿈되는거 그거 Extension
    //TODO: Refreshable
    var body: some View {
        ScrollView {
            //TODO: 미션카드

            
            //게시물 리스트
            LazyVStack(spacing: 0) {
                ForEach(vm.posts) { post in
                    VStack(spacing: 0) {
                        HomePostView(post: post, onLike: {
                            //TODO: - 좋아요 눌렀을떄 처리
                            print("onLike")
                        })
                            .padding(.horizontal, 30)
                            .onTapGesture {
                                nav.push(AppRoute.postDetail) //TODO: - 하트 영역이랑 댓글 영역도 고려
                            }
                        
                    }
                    //구분선 마지막 콘텐츠 빼고 주기
                    if vm.posts.last != nil {
                        Divider()
                            .frame(height: 1)
                            .overlay(.mdSurf2)
                            .padding(.horizontal, 30)
                            .padding(.bottom, 20)
                    }
                }
                // Sentinel View (무한 스크롤 트리거) TODO: 이거 이상한데 count수정
                if vm.hasMorePages && vm.posts.count > 2 {
                    ProgressView()
                    //                        .padding()
                        .onAppear {
                            if !vm.isLoading {
                                vm.getHome()
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 30)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(.white)
                //Shadows 디자인 시스템 적용안되서 일단 임시로 이렇게 해둠
                    .shadow(color: Color(hex: "000000", alpha: 0.04), radius: 4, x: 2, y: -2)
                   
            )
        }
        .background(.mdSurf1)
        //헤더 질문
        .safeAreaInset(edge: .top, alignment: .center, spacing: nil) {
            HomeHeaderView()
        }
        .onAppear{
            vm.getHome()
        }
    }
}

//MARK: - 젤 위에 헤더부분
struct HomeHeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack{
                Text("MyDays")
                    .foregroundColor(.black)
                
                Spacer()
                Image(systemName: "bell")
                
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 40)
        .padding(.horizontal, 30)
        .background(.mdSurf1)
    }
}


#Preview {
    NavigationStack{
        HomeView()
            .environmentObject(NavigationManager())
    }
}
//MARK: - 홈 뷰 용

//맨 밑 스크롤뷰 끝날때 처리랑 + 스크롤뷰에 컨텐츠 없으면 쪼그라듬

//<-만약에 카드 탭하면 챌린지 도전 탭으로 이동->
//                    .onTapGesture {
//                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.1)) {
//                            selectedTab = .favorite
//                        }
//                    }
//<--------------------------------->
