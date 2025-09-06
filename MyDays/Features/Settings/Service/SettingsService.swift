//
//  SettingsService.swift
//  MyDays
//
//  Created by Apple on 9/6/25.
//

//MARK: - 설정 화면 서버 연동 로직
import Alamofire
import Foundation

// MARK: - SettingsService Protocol
protocol SettingsServiceProtocol {
    func logout() async throws -> EmptyData
    func deleteAccount() async throws -> EmptyData
}

// MARK: - SettingsService (실제 API 통신)
class SettingsService: SettingsServiceProtocol {
    //로그아웃
    func logout() async throws -> EmptyData {
        let response: EmptyData = try await APIManager.shared.request("/logout", method: .post)
        
        return response
    }
    //회원탈퇴
    func deleteAccount() async throws -> EmptyData {
        let response: EmptyData = try await APIManager.shared.request("/delete", method: .post)
        
        return response
    }
}

//MARK: - MockSettingsService (테스트용)
class MockSettingsService: SettingsServiceProtocol {
    //로그아웃
    func logout() async throws -> EmptyData {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return EmptyData()
    }
    //회원탈퇴
    func deleteAccount() async throws -> EmptyData {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return EmptyData()
    }
}

