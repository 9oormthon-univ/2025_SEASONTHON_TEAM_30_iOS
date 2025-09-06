//
//  ChallengeStatusViewModel.swift
//  MyDays
//
//  Created by Apple on 8/31/25.
//
// MARK: - 챌린지 현황 뷰 모델입니다.
import Foundation
import SwiftUI

// 선택 가능한 별명의 데이터 모델 정의
struct SelectableTitle: Hashable, Identifiable, Decodable {
    let id: String
    let name: String
    let colorHex: String
}

@MainActor
class ChallengeStatusViewModel: ObservableObject {

    @Published var component: ChallengeStatusComponent?
    @Published var availableTitles: [SelectableTitle] = []
    @Published var isShowingTitleSelection: Bool = false
    
    // 테스트할 때
    // private let service = MockChallengeStatusService()
    
    // 실제로 서비스할 때
    private let service = ChallengeStatusService()

    func fetchChallengeStatus() async {
        do {
            self.component = try await service.getChallengeStatus()
        } catch {
            print("Error fetching challenge status: \(error)")
        }
    }
    
    // 별명 목록을 불러오기
        func fetchAvailableTitles() async {
            do {
                let userTitles = try await service.getUserTitles()
                
                self.availableTitles = userTitles.map { title in
                    SelectableTitle(id: title.titleId, name: title.title, colorHex: title.titleColor)
                }
            } catch {
                print("Error fetching user titles: \(error)")
            }
        }
        
        // 선택된 별명을 서버에 업데이트
        func updateSelectedTitle(_ title: SelectableTitle) async {
            do {
                try await service.updateActiveTitle(titleId: title.id)
                // 성공적으로 업데이트되면, 화면 데이터를 다시 로드하여 변경사항을 즉시 반영
                await fetchChallengeStatus()
            } catch {
                print("Error updating active title: \(error)")
            }
        }
        
        // 별명 탭 시 동작 처리
        func handleTitleAreaTap() {
            component?.isBubbleVisible = false
            isShowingTitleSelection = true
        }
}
