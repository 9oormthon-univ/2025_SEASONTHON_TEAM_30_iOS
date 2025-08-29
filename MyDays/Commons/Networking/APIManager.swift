//
//  APIManager.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//

//MARK: - API 통신에 관련된 공통 로직 매니저 입니다. (Alamofire 라이브러리 이용)
import Foundation
import Alamofire

class APIManager {
    // 앱 전체에서 공유되는 싱글톤 인스턴스
    static let shared = APIManager()
    
    private let session: Session
    private let baseURL: String = "https://api.your-app.com" //TODO: 추후 config파일에서 변경 예정
    
    // 세션 설정 (타임아웃 등)
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        session = Session(configuration: configuration)
    }
    
    // 모든 API 요청을 처리하는 제네릭 함수
    func request<T: Decodable>(_ endpoint: String, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil) async throws -> T {
        let url = baseURL + endpoint
        
        let commonHeaders: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer YOUR_ACCESS_TOKEN_HERE" //TODO: 추후 KeychainManager를 통해 엑세스토큰 넣을 예정
        ]
        
        // Alamofire의 async/await 요청
        let response = await session.request(url, method: method, parameters: parameters, encoding: encoding, headers: commonHeaders)
            .validate(statusCode: 200..<300) // 성공 상태 코드 검증
            .serializingDecodable(ServerResponse<T>.self)
            .response
        
        switch response.result {
        case .success(let serverResponse):
            
            return serverResponse.body
            
        case .failure(let error):
            // 더 구체적인 오류 처리(공통 팝업 등)
            throw error
        }
    }
}


