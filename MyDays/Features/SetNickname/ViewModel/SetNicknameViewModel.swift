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
    @Published var isNicknameValid: Bool = true //닉네임 유효 여부
    
    var isDisabled: Bool { //닉네임 버튼 비활성화 여부
        nickName.isEmpty || !isNicknameValid(nickName)
    }
    
    private let setNicknameService = MockSetNicknameService() //의존성 주입 (Real or Mock)
    
    //MARK: - 닉네임 등록
    func setNickname() {
        Task {
            self.isLoading = true
            do {
                _ = try await setNicknameService.setNickname(request: PostNicknameRequest(nickName: nickName))
                
              
                self.isSwitchMain = true
            }
            catch {
                //TODO: 닉네임 중복 알럿 띄워야함...(service에서 ?)
            }
        }
        self.isLoading = false
    }
    
    // MARK: - 닉네임 유효성 검증
    func isNicknameValid(_ nickname: String) -> Bool {
        // 가-힣: 완성형 한글
        let regex = "^[가-힣a-zA-Z0-9]{1,12}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: nickname)
    }
    
}
