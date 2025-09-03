//
//  SetNicknameViewModel.swift
//  MyDays
//
//  Created by 양재현 on 9/3/25.
//

//MARK: - 닉네임 정하기 뷰모델 입니다.
import Foundation

@MainActor
class SetNicknameViewModel: ObservableObject {
    @Published var isSwitchMain: Bool = false //홈 화면으로 전환할지 (닉네임 설정 성공시)
    @Published var nickName: String = ""
    @Published var isLoading: Bool = false //닉넴 설정 로딩
    
    var isDisabled: Bool { //닉네임 버튼 비활성화 여부
        nickName.isEmpty
    }
    
    private let setNicknameService = MockSetNicknameService() //의존성 주입 (Real or Mock)
    
    //MARK: - 닉네임 등록
    func setNickname() {
        Task {
            self.isLoading = true
            do {
                _ = try await setNicknameService.setNickname(request: PostNicknameRequest(nickName: nickName))
                
                self.isLoading = false
                self.isSwitchMain = true
            }
            catch {
                
            }
        }
    }
}
