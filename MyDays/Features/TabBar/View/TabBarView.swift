//
//  TabView.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//
//MARK: - 탭바 뷰
import SwiftUI

struct TabBarView: View {
    @State private var selectedTab: TabItem = .home
    @StateObject var navigationManager = NavigationManager()
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            // 콘텐츠 영역
            TabView(selection: $selectedTab) {
                Group {
                    HomeView()
                        .tag(TabItem.home)
                    
                    Color.blue
                        .tag(TabItem.calendar)
                    
                    Color.red
                        .tag(TabItem.status)
                }
                .toolbar(.hidden, for: .tabBar)
            }
            
            // 커스텀 탭 바
            .overlay(alignment: .bottom) {
                TabBar(selectedTab: $selectedTab)
            }
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
}

//MARK: - TabItem enum
enum TabItem: String, CaseIterable, Identifiable {
    case home = "home.fill"
    case calendar = "calendar.fill"
    case status = "fire.fill"
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .home: return "챌린지 피드"
        case .calendar: return "나의 달력"
        case .status: return "챌린지 현황"
        }
    }
}



#Preview {
    NavigationStack{
        TabBarView()
            .environmentObject(NavigationManager())
    }
}
