//
//  ChallengeStatusServerModel.swift
//  MyDays
//
//  Created by Apple on 9/5/25.
//

//MARK: - 챌린지 상태 뷰 서버모델
import Foundation

// MARK: - GetChallengeStatusResponse
struct GetChallengeStatusResponse: Decodable {
    let nickName: String
    let growthMessage: String
    let isBubbleVisible: Bool
    let userTitle: String
    let userTitleColor: String
    let progress: Double
    let imageUrl: String
    let totalChallengeCount: Int
    let daysCount: Int
    let isCompleteMission: Bool
    
    /*
    let meta: Meta
    let body: ChallengeStatusBody
    
    struct Meta: Decodable {
        let code: Int
        let message: String
    }
    
    struct ChallengeStatusBody: Decodable {
        let nickName: String
        let growthMessage: String
        let isBubbleVisible: Bool
        let userTitle: String
        let userTitleColor: String
        let progress: Double
        let imageUrl: String
        let totalChallengeCount: Int
        let daysCount: Int
        let isCompleteMission: Bool
    }
     */
}

// MARK: - Request / Response 모델 정의
struct UpdateActiveTitleRequest: Encodable {
    let titleId: String
    
    func toDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
              let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }
        return dict
    }
}

struct EmptyResponse: Decodable {}

// MARK: - User Titles Response
struct GetUserTitlesResponse: Decodable {
    
    let titles: [Title]
    struct Title: Decodable {
        let titleId: String
        let title: String
        let titleColor: String
    }

    /*
    struct Meta: Decodable {
        let code: Int
        let message: String
    }
    
    struct Title: Decodable {
        
    }
    
    struct Body: Decodable {
        let titles: [UserTitle]
    }
    
    let meta: Meta
    let body: Body
     */
}


