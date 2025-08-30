//
//  NavigationManager.swift
//  MyDays
//
//  Created by 양재현 on 8/30/25.
//

//MARK: - 네비게이션 매니저
import Foundation
import SwiftUI

@MainActor
class NavigationManager: ObservableObject {
    @Published var path = NavigationPath() // 현재 네비게이션 경로를 저장
    
    // 새로운 화면(stage)을 네비게이션 스택에 푸시합니다.
    func push<T: Hashable>(_ stage: T) {
        path.append(stage)
    }
    
    // 네비게이션 스택을 초기화하여 루트 화면으로 이동합니다.
    func popToRoot() {
        path = NavigationPath()
    }
    
    // 네비게이션 스택의 마지막 화면을 제거합니다.
    func popLast() {
        path.removeLast()
    }
}


