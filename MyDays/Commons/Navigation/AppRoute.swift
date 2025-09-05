//
//  AppRoute.swift
//  MyDays
//
//  Created by 양재현 on 8/30/25.
//

//MARK: - 앱 네비게이션 루트 모음입니다.
import Foundation

enum AppRoute: Hashable {
    case setNickname //닉네임 등록 페이지
    
    case postDetail(postId: String) //게시물 디테일 페이지
    case write //게시물 작성페이지
    case setting //설정 페이지
    case completedLogin(nickName: String) //닉네임 설정후 페이지
}
