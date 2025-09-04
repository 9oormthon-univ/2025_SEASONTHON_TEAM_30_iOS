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
    @EnvironmentObject var scrollManager: HomeScrollManager
    
    var body: some View {
        Group {
            // MARK: - 첫 로딩용 Skeleton ScrollView
            if vm.isFirstLoading {
                ScrollView {
                    Color.clear.frame(height: 0) //사실 height 0 아니여서 동일하게 맞춰줘야...;
                    // 미션카드
                    missionCard()
                    //스켈레톤
                    VStack(spacing: 26) {
                        ForEach(0..<2, id: \.self) { _ in
                            SkeletonHomePost()
                                .skeleton(isRedacted: true)
                                .padding(.horizontal, 24)
                        }
                    }
                    .padding(.top, 40)
                }
            }
            // MARK: - 실제 데이터 ScrollView
            else {
                ScrollViewReader { proxy in
                    ScrollView {
                        // 꼭대기 ID (홈 화면 젤 위로 스크롤 보내기 위함)
                        Color.clear.frame(height: 0).id("TOP")
                        
                        // 미션카드
                        missionCard()
                        
                        LazyVStack(spacing: 0) {
                            ForEach(vm.posts) { post in
                                VStack(spacing: 0) {
                                    HomePostView(post: post, onLike: {
                                        vm.postLike(post: post)
                                    })
                                    .contentShape(Rectangle())
                                    .padding(.horizontal, 24)
                                    .onTapGesture {
                                        nav.push(AppRoute.postDetail(postId: post.id))
                                    }
                                }
                                
                                //구분 선 (마지막이면 구분선 없게)
                                if post.id != vm.posts.last?.id {
                                    Divider()
                                        .frame(height: 1)
                                        .overlay(.mdSurf4)
                                        .padding(.horizontal, 24)
                                        .padding(.bottom, 26)
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
                        .padding(.top, 40)
                        .padding(.bottom, 60) //마지막 콘텐츠 간격
                        .background(.mdSurf2)
                    }
                    //리프레쉬
                    .refreshable {
                        vm.refreshHome()
                    }
                    //상위 탭 뷰에서 홈 탭을 눌렀을때를 감지해서 스크롤을 젤 위로 올림
                    .onChange(of: scrollManager.scrollToTopTrigger) { _, newValue in
                        if newValue {
                            withAnimation {
                                proxy.scrollTo("TOP", anchor: .top)
                            }
                            scrollManager.scrollToTopTrigger = false // 다시 false로 초기화
                        }
                    }
                }
            }
              
            
        }
        .padding(.top, -8)
        .background(.mdSurf2)
        //홈 헤더
        .safeAreaInset(edge: .top) {
            HomeHeaderView()
        }
    }
    //미션 카드 스켈레톤, 진짜 게시물에 2번쓰는거 번거로우니
    @ViewBuilder
    private func missionCard() -> some View {
        if let mission = vm.mission {
            HomeMissionCard(imgUrl: mission.userImgUrl,
                            mission: mission.text,
                            isCompleted: mission.isCompleted,
                            onChallengeTap: { nav.push(AppRoute.write)})
            .padding(.horizontal, 30)
            .padding(.top, 24)
        }
    }
}

//MARK: - 젤 위에 헤더부분
struct HomeHeaderView: View {
    var body: some View {
        HStack(spacing: 0) {
            Image("logo")
                .padding(.leading, 10)
            Spacer()
            //알람
            Image("noti")
                .padding(10)
                .onTapGesture {
                    //알람 기능
                }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 40)
        .padding(.horizontal, 30)
        .background(.mdSurf2)
    }
}

//MARK: - 홈 미션 카드
struct HomeMissionCard: View {
    let imgUrl: String
    let mission: String
    let isCompleted: Bool
    
    let onChallengeTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            //유저이미지 + 오늘의 챌린지를 확인하세요 !
            HStack(spacing: 0) {
                //유저 이미지
                KFImage(URL(string: imgUrl))
                    .placeholder { // 로딩 중
                        Circle()
                            .fill(.mdNavi2)
                            .frame(width: 42, height: 42)
                    }
                    .cancelOnDisappear(true)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 42, height: 42)
                    .clipped()
                    .clipShape(Circle())
                
                //말풍선
                Triangle()
                        .fill(.mdSurf4)
                       .frame(width: 16, height: 16)
                       .rotationEffect(.degrees(0))
                       .padding(.leading, 6)
                       .padding(.trailing, -1)
                
                Text("오늘의 챌린지를 확인하세요!")
                    .font(.b3())
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.mdSurf4)
                        )
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
                        Text(isCompleted ? "도전 완료" : "도전하기")
                            .font(.l1())
                        
                        Image(isCompleted ? "check" : "right")
                            .renderingMode(.template)
                    }
                    .frame(height: 30)
                    .padding(.leading, 10)
                    .padding(.trailing, 5)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 100)
                            .fill(isCompleted ? .mdSurf4 : .mdSurf3)
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        .mdPrimary,
                                        Color(hex: "69FF40"),
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ),
                                lineWidth: isCompleted ? 0 : 2
                            )
                    )
                }
            }
            .padding(.top, 10)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 30)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(.mdSurf3)
                .stroke(.mdDim, lineWidth: 1)
        )
    }
    //말풍선 삼각형
    struct Triangle: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: 0, y: rect.height / 2))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.closeSubpath()
            return path
        }
    }
}


#Preview {
    NavigationStack{
        HomeView()
            .environmentObject(NavigationManager())
            .environmentObject(HomeScrollManager())
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
