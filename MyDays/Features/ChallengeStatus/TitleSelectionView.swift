//
//  TitleSelectionView.swift
//  MyDays
//
//  Created by Apple on 9/3/25.
//

// MARK: - 별명 선택(View) 입니다.

import SwiftUI

struct TitleSelectionView: View {
    // ViewModel을 받아 데이터 처리
    @ObservedObject var vm: ChallengeStatusViewModel
    @Environment(\.dismiss) var dismiss
    
    // 사용자가 선택한 칭호를 임시 저장
    @State private var selectedTitle: SelectableTitle?
    
    // 현재 설정된 별명 기억하는 용도
    @State private var currentTitle: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // 헤더
            TitleSelectionHeaderView(dismiss: { dismiss() })
            
            // 별명 목록
            // TODO: - 그림자 효과 오버레이로??
            ScrollView{
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(vm.availableTitles) { title in
                        UserTitleBadge(title: title.name, color: title.colorHex)
                            //.padding(4)
                            .cornerRadius(12)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        //.fill(Color.mdSurf3)
                                        .shadow(color: selectedTitle == title ? .white.opacity(0.8) : .clear,
                                                radius: 5)
                            )
                            .onTapGesture {
                                selectedTitle = title
                            }
                    }
                        .frame(maxWidth: .infinity, alignment: .leading) // 전체 왼쪽 정렬
                }
                .padding(.leading, 30)   // 왼쪽 여백 30
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
            
            Text("챌린지 수행을 통해 별명을 얻어보세요")
                .font(.b3())
                .foregroundColor(Color(hex:"#818181"))
                .padding(.horizontal, 83.5)
                .padding(.bottom, 10)
            
            // 저장하기 버튼
            Button(action: {
                // 선택된 칭호가 있을 경우에만 저장하고 창 닫기
                if let finalTitle = selectedTitle {
                // 비동기 함수 호출을 위해 Task 블록 추가
                    Task {
                        await vm.updateSelectedTitle(finalTitle)
                        dismiss()
                    }
                }
            }) {
                Text("저장하기")
            }
            .buttonStyle(TitleSelectionSaveButtonStyle())
            // 현재 별명과 다른 걸 골랐을 때만 버튼 활성화
            .disabled(selectedTitle == nil || selectedTitle?.name == currentTitle)
            .padding(.horizontal, 30)
            .padding(.bottom, 18)
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.mdSurf3)
        .onAppear {
            // 시트가 나타날 때 현재 설정된 칭호를 기본 선택값으로 설정
            Task {
                await vm.fetchAvailableTitles()
                  
                /*
                // 칭호 목록 로드가 완료된 후 현재 칭호 설정
                self.currentTitle = vm.component.userTitle
                if let current = vm.availableTitles.first(where: { $0.name == self.currentTitle }) {
                    self.selectedTitle = current
                }
                 */
            }
        }
    }
    
    // MARK: - 헤더
    struct TitleSelectionHeaderView: View {
        let dismiss: () -> Void
        
        var body: some View {
            ZStack {
                // 중앙 타이틀
                Text("별명 선택")
                    .font(.b1())
                    .foregroundColor(.white)
                
                // 오른쪽 닫기 버튼
                HStack {
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image("close")
                            .resizable()
                            .frame(width: 15, height: 15)
                    }
                }
            }
            .padding(30)
            .background(.mdSurf3)
        }
    }
    
    
    // MARK: - 유연한 그리드 레이아웃을 위한 Helper View
    struct FlowLayout<Content: View>: View {
        let alignment: HorizontalAlignment
        let spacing: CGFloat
        @ViewBuilder let content: () -> Content
        
        var body: some View {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        
        private func generateContent(in g: GeometryProxy) -> some View {
            var width = CGFloat.zero
            var height = CGFloat.zero
            
            return ZStack(alignment: .topLeading) {
                self.content()
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(self.alignment, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height + spacing
                        }
                        let result = width
                        if d.width > 0 {
                            width -= d.width + spacing
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        let result = height
                        if d.height > 0 {
                            height = 0
                        }
                        return result
                    })
            }
        }
    }
    // MARK: - 저장하기 버튼
    struct TitleSelectionSaveButtonStyle: ButtonStyle {
        @Environment(\.isEnabled) private var isEnabled
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.b2Bold())
                .foregroundColor(isEnabled ? .mdBrightBlack : .mdDim)
                .frame(maxWidth: 315)
                .frame(height: 56)
                .background(isEnabled ? .mdPrimary : .mdNavi2)
                .cornerRadius(12)
        }
    }
    
}
