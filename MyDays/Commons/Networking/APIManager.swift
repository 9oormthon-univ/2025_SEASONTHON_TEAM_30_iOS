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
    let baseURL: String = (Bundle.main.infoDictionary?["BASE_URL"] as? String) ?? ""
    
    // 세션 설정 (타임아웃 등)
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        session = Session(configuration: configuration)
    }
    
    // 모든 API 요청을 처리하는 제네릭 함수
    func request<T: Decodable>(_ endpoint: String, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil) async throws -> T {
        let url = baseURL + "/api" + "/v1" + endpoint
        
        // 🔑 Keychain에서 accessToken 가져오기
        let accessToken = KeychainHelper.load(key: "accessToken") ?? ""
        
        let commonHeaders: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(accessToken)" //TODO: 추후 KeychainManager를 통해 엑세스토큰 넣을 예정
        ]
        
        // Alamofire의 async/await 요청
        let response = await session.request(url, method: method, parameters: parameters, encoding: encoding, headers: commonHeaders)
            .validate(statusCode: 200..<300) // 성공 상태 코드 검증
            .serializingDecodable(ServerResponse<T>.self)
            .response
        
        switch response.result {
        case .success(let serverResponse):
            print("✅ 리스폰 값 : \(serverResponse.body)")
            if let body = serverResponse.body {
                return body
            }
            //body가 null로 오면
            else {
                // 빈 JSON을 디코딩해서 반환
                return try JSONDecoder().decode(T.self, from: Data("{}".utf8))
            }
            
        case .failure(let error):
            // 디코딩 에러 처리
            if let afError = error.asAFError, afError.isResponseSerializationError {
                if let decodingError = afError.underlyingError as? DecodingError {
                    // DecodingError 상세 처리
                    throw APIError.decodingError(decodingError)
                } else {
                    // DecodingError 아니면 그냥 AFError 메시지
                    throw APIError.decodingError(afError)
                }
            }
            //상태코드 에러
            else if let statusCode = response.response?.statusCode {
                switch statusCode {
                case 400: throw APIError.badRequest
                case 401: throw APIError.unauthorized
                case 403: throw APIError.forbidden
                case 404: throw APIError.notFound
                case 409: throw APIError.conflict
                case 500: throw APIError.serverError
                default: throw APIError.unknown(statusCode)
                }
            } else {
                throw APIError.unknown(-1)
            }
        }
    }
}

