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
    //TODO: Refreshable
    var body: some View {
        ScrollView {
            //미션카드
            if let mission = vm.mission {
                HomeMissionCard(day: mission.day,
                                mission: mission.text,
                                isCompleted: mission.isCompleted,
                                onChallengeTap: { nav.push(AppRoute.write)})
                    .padding(.horizontal, 30)
                    .padding(.top, 25)
                
            }

            
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
            .padding(.top, 25)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(.mdSurf2)
                //Shadows 디자인 시스템 적용안되서 일단 임시로 이렇게 해둠
                    .shadow(color: Color(hex: "000000", alpha: 0.04), radius: 4, x: 2, y: -2)
                   
            )
        }
        .background(.mdSurf2) //전체 배경
        //헤더 질문
        .safeAreaInset(edge: .top, alignment: .center, spacing: nil) {
            HomeHeaderView()
        }
        .onAppear{
            vm.getMission()
            vm.getHome()
        }
    }
}

//MARK: - 젤 위에 헤더부분
struct HomeHeaderView: View {
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
                    .font(.b3Light())
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
