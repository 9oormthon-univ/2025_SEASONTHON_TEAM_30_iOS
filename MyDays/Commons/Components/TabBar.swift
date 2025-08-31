//
//  TabBar.swift
//  MyDays
//
//  Created by 양재현 on 8/31/25.
//

//MARK: - 하단 탭 바 입니다.
import SwiftUI

struct TabBar: View {
    @Binding var selectedTab: TabItem
    @Namespace private var namespace
    
    var body: some View {
        HStack(spacing: 0) {
            if selectedTab != TabItem.home {
                Spacer()
            }
            tabBarItem(tab: TabItem.home)
            Spacer()
            tabBarItem(tab: TabItem.calendar)
            Spacer()
            tabBarItem(tab: TabItem.status)
            if selectedTab != TabItem.status {
                Spacer()
            }
        }
        .padding(.horizontal, 5)
        .frame(maxWidth: 314)
        .frame(height: 54)
        .background(
            RoundedRectangle(cornerRadius: 100)
                .fill(.mdBrightBlack)
        )
        .padding(.horizontal, 30)
        
        
    }
    //MARK: - 탭 아이템
    @ViewBuilder
    private func tabBarItem(tab: TabItem) -> some View {
        HStack {
            //탭 아이템 이미지
            Image(tab.rawValue)
                .renderingMode(.template)
                .foregroundColor(selectedTab == tab ? .white : .mdNavi3)
            
            if selectedTab == tab {
                //탭 아이템 텍스트
                Text(tab.title)
                    .font(.l1())
                    .foregroundColor(.white)
                    .transition(
                        .asymmetric(
                            insertion: .opacity.combined(with: .scale(scale: 1.05, anchor: .leading)),
                            removal: .opacity
                        )
                    )
            }
        }
        .frame(height: 44)
        .padding(.horizontal, 16)
        .background(
            Group {
                if selectedTab == tab {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(.mdNavi2)
                        .matchedGeometryEffect(id: "selectedTab", in: namespace)
                        .animation(nil, value: selectedTab)
                }
            }
        )
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.85, blendDuration: 0.2)) {
                selectedTab = tab
            }
        }
    }
}

#Preview {
    @Previewable @State var selectedTab: TabItem = .home
   
    TabBar(selectedTab: $selectedTab)
}
