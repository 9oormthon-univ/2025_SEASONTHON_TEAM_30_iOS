//
//  ChallengeStatusViewModel.swift
//  MyDays
//
//  Created by Apple on 8/31/25.
//
// MARK: - 챌린지 현황 뷰 모델입니다.
import Foundation
import SwiftUI

// 선택 가능한 칭호의 데이터 모델 정의
struct SelectableTitle: Hashable, Identifiable, Decodable {
    let id: String
    let name: String
    let colorHex: String
    
    /*var color: Color {
        Color(hex: colorHex)
    }*/
}

/*
// 사용자 이름 밑에 나오는 젤리 메시지
enum GrowthStage: String, Decodable {
    case making
    case growing
    case fullyGrown
    
    // 각 상태에 맞는 메시지를 반환
    var message: String {
        switch self{
        case .making:
            return "나의 젤리가 만들어지고 있어요!"
        case .growing:
            return "나의 젤리가 점점 성장하고 있어요!"
        case .fullyGrown:
            return "축하드려요! 젤리가 다 성장했어요."
        }
    }
}
 */

@MainActor
class ChallengeStatusViewModel: ObservableObject {
    // @Published var component: ChallengeStatusComponent = .mock
    @Published var component: ChallengeStatusComponent?
    @Published var availableTitles: [SelectableTitle] = []
    @Published var isShowingTitleSelection: Bool = false
    
    // 테스트할 때
    private let service = MockChallengeStatusService()
    
    // 실제로 할 때
    // private let service: ChallengeStatusServiceProtocol
    
    /* 필요 없음
    var isWriteButtonDisabled: Bool {
            component.completeMission
    }
     
    
    init(service: ChallengeStatusServiceProtocol = ChallengeStatusService()) {
        self.service = service
    }
     */
    
    func fetchChallengeStatus() async {
        do {
            self.component = try await service.getChallengeStatus()
        } catch {
            print("Error fetching challenge status: \(error)")
            // TODO: 사용자에게 에러 알림 표시
        }
    }
    
    // 칭호 목록을 불러오기
        func fetchAvailableTitles() async {
            do {
                let userTitles = try await service.getUserTitles()
                // 서버 모델 [UserTitle]을 View 모델 [SelectableTitle]로 변환
                self.availableTitles = userTitles.map { title in
                    SelectableTitle(id: title.titleId, name: title.title, colorHex: title.titleColor)
                }
            } catch {
                print("Error fetching user titles: \(error)")
                // TODO: 사용자에게 에러 알림 표시
            }
        }
        
        // 선택된 칭호를 서버에 업데이트
        func updateSelectedTitle(_ title: SelectableTitle) async {
            do {
                try await service.updateActiveTitle(titleId: title.id)
                // 성공적으로 업데이트되면, 화면 데이터를 다시 로드하여 변경사항을 즉시 반영
                await fetchChallengeStatus()
            } catch {
                print("Error updating active title: \(error)")
                // TODO: 사용자에게 에러 알림 표시
            }
        }
        
        // 칭호 탭 시 동작 처리
        func handleTitleAreaTap() {
            /* 백에서
             if .bubbleVisible {
                // TODO: 말풍선을 다시 보지 않도록 UserDefaults 등에 저장하는 로직 추가 가능
            }*/
            isShowingTitleSelection = true
        }
}
