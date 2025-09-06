//
//  SettingsViewModel.swift
//  MyDays
//
//  Created by 양재현 on 9/7/25.
//

//MARK: - 설정 화면 뷰모델 입니다.
import Foundation
import UserNotifications

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var isShowDeleteAlert: Bool = false //회원탈퇴 알럿
    @Published var isShowLogoutAlert: Bool = false //로그아웃 알럿
    @Published var isToggleOn: Bool = true //알람 토글
    @Published var isShowTimeChangePopUp: Bool = false //시간 변경 팝업
    
    @Published var selectedDate = Date() //선택한 시간
    @Published var isLoading = false //로딩
    @Published var goToLoginView = false //로그아웃, 회원탈퇴 할 때 로그인 뷰로 이동
    
    
    private let settingsService = MockSettingsService() //의존성 주입 (Real or Mock)

    //MARK: - 로그아웃
    func logout() {
        self.isLoading = true
        Task {
            do {
                _ = try await settingsService.logout()
                // 토큰 삭제
               KeychainHelper.delete(key: "accessToken")
               KeychainHelper.delete(key: "refreshToken")
                
                self.goToLoginView = true //로그인 뷰로 이동
            }
            catch let error as APIError {
                print(error.localizedDescription)
            }
            self.isLoading = false
        }
    }
    
    //MARK: - 회원탈퇴
    func deleteAccount() {
        self.isLoading = true
        Task {
            do {
                _ = try await settingsService.deleteAccount()
                // 토큰 삭제
               KeychainHelper.delete(key: "accessToken")
               KeychainHelper.delete(key: "refreshToken")
                
                self.goToLoginView = true //로그인 뷰로 이동
            }
            catch let error as APIError {
                print(error.localizedDescription)
            }
            self.isLoading = false
        }
    }
    
    //MARK: - 설정한 시간에 맞춰 알림 보내기
        func scheduleNotification() async {
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.removeAllPendingNotificationRequests()
            
            //<---- 알람 보낼 콘텐츠 제작 ---->
            let content = UNMutableNotificationContent()
            content.title = "🔥 오늘의 작은 도전"
            content.body = "나를 한층 더 나답게 만들어 줄 거예요"
            content.sound = UNNotificationSound(named: UNNotificationSoundName("noti.caf"))
            //<-------------------------->
            
            //<---- 트리거 설정 ---->
            let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: self.selectedDate)
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: triggerDate, repeats: true)
            //<------------------>
            
            //<---- 알림 요청 생성 + 등록 ---->
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            do {
                try await notificationCenter.add(request)
            } catch {
                print(error)
            }
            //<--------------------------->
        }
    
    //MARK: - 알람 끄기
    func cancelNotifications() async {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
    }
}
