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
        
        
        return true
    }
}
