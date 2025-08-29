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
//    @StateObject var navigationManager = NavigationManager() //밑에는 .enviornment로 주입시키기
    
    var body: some View {
//        NavigationStack(path: $navigationManager.path) {
            // 콘텐츠 영역
            TabView(selection: $selectedTab) {
                Group {
                    Color.black
                        .tag(TabItem.home)
                    
                    Color.blue
                        .tag(TabItem.write)
                    
                    Color.red
                        .tag(TabItem.my)
                    //                    Text("\(selectedTab.title) View")
                    //                        .tag(selectedTab)
                    //                        .onTapGesture {
                    //                            navigationManager.path.append(.homeView)
                    //                        }
                }
                .toolbar(.hidden, for: .tabBar)
            }
            //            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // 커스텀 탭 바
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
//            .navigationDestination(for: StackViewType.self) { stackViewType in
//                // ✅ 중요
//                switch stackViewType {
//                case .homeView:
//                    Color.red
//                case .heartView:
//                    Color.blue
//                }
//            }
        
        
    }
    
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

