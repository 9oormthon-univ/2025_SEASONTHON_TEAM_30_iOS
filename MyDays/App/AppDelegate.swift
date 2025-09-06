//
//  AppDelegate.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//

import UIKit
import KakaoSDKCommon

class AppDelegate: NSObject, UIApplicationDelegate {
    
    //MARK: - 앱 시작 시 초기 설정
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        
        // kakao sdk 초기화
        let kakaoNativeAppKey = (Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String) ?? ""
        KakaoSDK.initSDK(appKey: kakaoNativeAppKey)
        
        // 앱 시작할때 알림 권한 받기
        UNUserNotificationCenter.current().delegate = self
               UNUserNotificationCenter.current().requestAuthorization(
                   options: [.alert, .badge, .sound],
                   completionHandler: { _, _ in }
               )
        
        
        return true
    }
}


//MARK: - 푸시 알림 관련 처리
extension AppDelegate: UNUserNotificationCenterDelegate {
    // Foreground에서 알림이 도착했을때 호출
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("foreground에서 알림 도착")
        completionHandler([.badge, .banner, .list, .sound])
    }
    
    // 유저가 푸시 알림을 탭했을때 처리
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print("유저가 푸시 알람을 탭함")
        completionHandler()
    }
}
