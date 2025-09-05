//
//  APIError.swift
//  MyDays
//
//  Created by 양재현 on 9/5/25.
//

//MARK: - API 에러 enum입니다.
import Foundation

enum APIError: LocalizedError {
    case badRequest        // 400 -> 요청 값이 유효하지 않거나 필수 파라미터가 누락되었을 때
    case unauthorized      // 401 -> 인증되지 않은 사용자(유효하지 않은 토큰)일 때
    case forbidden         // 403 -> 해당 리소스에 접근할 권한이 없을 때 (예: 다른 사용자의 게시물 수정 시도)
    case notFound          // 404 -> 요청한 리소스를 찾을 수 없을 때
    case conflict          // 409 -> 리소스가 충돌할 때 (예: 중복된 이메일로 회원가입 시도)
    case serverError       // 500 -> 서버 내부 로직 처리 중 에러가 발생했을 때
    case decodingError(Error)    // 디코딩 실패
    case unknown(Int)      // 기타 상태 코드
    
    var errorDescription: String? {
        switch self {
        case .badRequest: return "‼️400: 요청 값이 유효하지 않거나 필수 파라미터가 누락되었음"
        case .unauthorized: return "‼️401: 인증되지 않은 사용자(유효하지 않은 토큰)임"
        case .forbidden: return "‼️403: 해당 리소스에 접근할 권한이 없음(예: 다른 사용자의 게시물 수정 시도)"
        case .notFound: return "‼️404: 요청한 리소스를 찾을 수 없음"
        case .conflict: return "‼️409: 리소스가 충돌할 때 (예: 중복된 이메일로 회원가입 시도)"
        case .serverError: return "‼️500: 서버에서 오류가 발생함"
        case .decodingError(let error):
            if let decodingError = error as? DecodingError {
                switch decodingError {
                case .typeMismatch(let type, let context):
                    return "‼️디코딩에러 -> 디코딩 타입 불일치: \(type), \(context.debugDescription) at \(context.codingPath)"
                case .valueNotFound(let type, let context):
                    return "‼️디코딩에러 -> 값 없음: \(type), \(context.debugDescription) at \(context.codingPath)"
                case .keyNotFound(let key, let context):
                    return "‼️디코딩에러 -> 키 없음: \(key.stringValue), \(context.debugDescription) at \(context.codingPath)"
                case .dataCorrupted(let context):
                    return "‼️디코딩에러 -> 손상된 데이터: \(context.debugDescription)"
                @unknown default:
                    return "‼️디코딩에러 -> 알 수 없는 디코딩 오류: \(error.localizedDescription)"
                }
            } else {
                return "디코딩 오류: \(error.localizedDescription)"
            }
        case .unknown(let code): return "알 수 없는 오류 (\(code))"
        }
    }
}
