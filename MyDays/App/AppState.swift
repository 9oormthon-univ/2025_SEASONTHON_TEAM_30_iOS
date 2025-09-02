//
//  AppState.swift
//  MyDays
//
//  Created by 양재현 on 9/2/25.
//

//MARK: - 루트 뷰에서 앱이 어떤 화면인지 정해줍니다.
import Foundation

class AppState: ObservableObject {
    enum RootView {
        case splash, login, main
    }
    
    @Published var currentView: RootView = .splash
}
