//
//  TabView.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//
//MARK: - 홈, 게시물 작성, 마이페이지 탭바뷰
import SwiftUI

// TabItem enum
enum TabItem: String, CaseIterable, Identifiable {
    case home = "home.fill"
    case write = "fire.fill"
    case my = "person.fill"
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .home: return "챌린지 피드"
        case .write: return "챌린지 도전"
        case .my: return "나의 챌린지"
        }
    }
}

struct TabBarView: View {
    @State private var selectedTab: TabItem = .home
    @Namespace private var namespace
    @StateObject var navigationManager = NavigationManager()
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            // 콘텐츠 영역
            TabView(selection: $selectedTab) {
                Group {
                    HomeView()
                        .tag(TabItem.home)
                    
                    WriteView()
                        .tag(TabItem.write)
                    
                    Color.red // <--- !!!!! 요기다가 채영님이 만든 뷰 넣으면 됩니다 ~ !!!!!
                        .tag(TabItem.my)
                }
                .toolbar(.hidden, for: .tabBar)
            }
            //            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // 커스텀 탭 바 영역
            .overlay(alignment: .bottom) {
                HStack {
                    ForEach(TabItem.allCases) { tab in
                        Spacer()
                        tabBarItem(tab: tab)
                        Spacer()
                    }
                }
                //                .padding(.horizontal, 10)
                .frame(maxWidth: 320)
                .frame(height: 54)
                .background(.black)
                .cornerRadius(30)
            }
            .ignoresSafeArea(.keyboard)
            //네비게이션 목적지
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .postDetail:
                    PostDetailView()
                    
                case .write:
                    WriteView()
                }
                
            }
        }
        //네비게이션 매니저 하위뷰에 주입
        .environmentObject(navigationManager)
        
        
    }
    
    //MARK: - 탭 아이템
    @ViewBuilder
    private func tabBarItem(tab: TabItem) -> some View {
        HStack {
            Image(tab.rawValue)
                .font(.title2)
            
            if selectedTab == tab {
                Text(tab.title)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background(
            ZStack {
                if selectedTab == tab {
                    Capsule()
                        .fill(Color.white)
                        .matchedGeometryEffect(id: "selectedTab", in: namespace)
                }
            }
        )
        .foregroundColor(selectedTab == tab ? .black : .gray)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.1)) {
                selectedTab = tab
            }
        }
    }
}

#Preview {
    NavigationStack{
        TabBarView()
            .environmentObject(NavigationManager())
    }
}
