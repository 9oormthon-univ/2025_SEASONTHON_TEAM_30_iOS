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
    @Environment(\.refresh) private var refresh

    var body: some View {
        Group {
            // MARK: - 첫 로딩용 Skeleton ScrollView
            if vm.isFirstLoading {
                ScrollView {
                    // 미션카드
                    missionCard()
                    //스켈레톤
                    VStack(spacing: 16) {
                        ForEach(0..<2, id: \.self) { _ in
                            SkeletonHomePost()
                                .skeleton(isRedacted: true)
                                .padding(.horizontal, 30)
                        }
                    }
                    .padding(.top, 25)
                }
            }
            // MARK: - 실제 데이터 ScrollView
           else {
                ScrollView {
                    // 미션카드
                    missionCard()
                    
                    LazyVStack(spacing: 0) {
                        ForEach(vm.posts) { post in
                            VStack(spacing: 0) {
                                HomePostView(post: post, onLike: {
                                    print("onLike")
                                })
                                .padding(.horizontal, 30)
                                .onTapGesture {
                                    nav.push(AppRoute.postDetail)
                                }
                            }
                            
                            //구분 선
                            if vm.posts.last != nil {
                                Divider()
                                    .frame(height: 1)
                                    .overlay(.mdSurf2)
                                    .padding(.horizontal, 30)
                                    .padding(.bottom, 20)
                            }
                        }
                        
                        // 무한 스크롤 트리거 (페이지 받아올 게 더있으면 progress 대기시켜놓기 ?)
                        if vm.hasMorePages {
                            ProgressView()
                                .onAppear {
                                    if !vm.isMoreLoading {
                                        vm.getMorePosts()
                                    }
                                }
                        }
                    }
                    .padding(.top, 25)
                    .background(.mdSurf2)
                }
               //리프레쉬
                .refreshable {
                    vm.refreshHome()
                }
            }
            
           
        }
        .background(.mdSurf2)
        .safeAreaInset(edge: .top) {
            HomeHeaderView(onTapLogo: {
               
        })
        }
    }
    //미션 카드 스켈레톤, 진짜 게시물에 2번쓰는거 번거로우니
    @ViewBuilder
    private func missionCard() -> some View {
        if let mission = vm.mission {
            HomeMissionCard(day: mission.day,
                            mission: mission.text,
                            isCompleted: mission.isCompleted,
                            onChallengeTap: { nav.push(AppRoute.write)})
                .padding(.horizontal, 30)
                .padding(.top, 25)
        }
    }
}

//MARK: - 젤 위에 헤더부분
struct HomeHeaderView: View {
    let onTapLogo: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            //알람
            Image("noti")
                .padding(10)
                .onTapGesture {
                    //알람 기능
                }
        }
        .overlay(
            Image("logo")
                .onTapGesture {
                    onTapLogo()
                }
        )
        .frame(maxWidth: .infinity)
        .frame(height: 40)
        .padding(.horizontal, 30)
        .background(.mdSurf2)
    }
}

//MARK: - 홈 미션 카드
struct HomeMissionCard: View {
    let day: String
    let mission: String
    let isCompleted: Bool
    
    let onChallengeTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            //Day + 오늘의 챌린지를 확인하세요 !
            HStack(spacing: 10) {
                Text(day)
                    .font(.b3Bold())
                    .foregroundColor(.mdPrimaryText)
                    .padding(.horizontal, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(.mdPrimaryCon)
                    )
                Text("오늘의 챌린지를 확인하세요!")
//                    .font(.b3Light())
                    .foregroundColor(.white)
            }
            //미션 내용
            Text(mission.forceCharWrapping)
                .font(.b2Bold())
                .foregroundColor(.white)
                .padding(.top, 15)
            
            //도전하기 버튼
            Button(action: { onChallengeTap() }) {
                HStack(spacing: 0) {
                    Spacer()
                    HStack(spacing: 0) {
                        Text("도전하기")
                            .font(.l1())
                        
                        Image("right")
                            .renderingMode(.template)
                    }
                    .frame(height: 30)
                    .padding(.leading, 10)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 100)
                            .fill(.mdSurf3)
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        .mdPrimary,
                                        Color(hex: "69FF40"),
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ),
                                lineWidth: 2
                            )
                    )
                }
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 30)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(.mdSurf3)
                .stroke(.mdDim, lineWidth: 1)
        )
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
