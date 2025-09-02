//
//  KeychainHelper.swift
//  MyDays
//
//  Created by 양재현 on 9/2/25.
//

//MARK: - 엑세스, 리프레쉬 토큰을 저장, 불러오기 위한 KeyChain 헬퍼입니다.
import Foundation
import Security

enum KeychainHelper {
    //MARK: - 저장
    static func save(key: String, value: String) {
        if let data = value.data(using: .utf8) {
            // 기존 값 있으면 삭제
            let query = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: key
            ] as CFDictionary
            SecItemDelete(query)
            
            // 새 값 추가
            let attributes = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: key,
                kSecValueData: data
            ] as CFDictionary
            
            SecItemAdd(attributes, nil)
        }
    }
    
    //MARK: - 불러오기
    static func load(key: String) -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)
        
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    //MARK: - 삭제
    static func delete(key: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ] as CFDictionary
        SecItemDelete(query)
    }
}
