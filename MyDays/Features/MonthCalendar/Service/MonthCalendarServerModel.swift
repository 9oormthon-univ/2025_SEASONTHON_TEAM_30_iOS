//
//  MonthCalendarServerModel.swift
//  MyDays
//
//  Created by 양재현 on 9/1/25.
//

//MARK: - 월 단위 달력 서버모델
import Foundation

// 달력의 post 리스트 Response 
struct GetCalendarPostsResponse: Decodable {
    let userCreatedAt: Date // 유저 생성일
    let posts: [MonthCalendarPostResponse]
    
    struct MonthCalendarPostResponse: Decodable {
        let postId: String // 게시물 pk
        let imageUrl: String // 이미지 url
        let date: Date // 날짜
        
        enum CodingKeys: String, CodingKey {
            case postId, imageUrl, date
        }
        
        // 서버에서 문자열로 오는 날짜(ISO 8601)를 Date로 변환
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            postId = try container.decode(String.self, forKey: .postId)
            imageUrl = try container.decode(String.self, forKey: .imageUrl)

            let dateString = try container.decode(String.self, forKey: .date)
            let formatter = ISO8601DateFormatter()
            guard let parsedDate = formatter.date(from: dateString) else {
                throw DecodingError.dataCorruptedError(
                    forKey: .date,
                    in: container,
                    debugDescription: "‼️[디코딩 에러] Date string does not match ISO8601 format"
                )
            }
            date = parsedDate
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case userCreatedAt, posts
    }
    
    // userCreatedAt 디코딩
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let createdAtString = try container.decode(String.self, forKey: .userCreatedAt)
        let formatter = ISO8601DateFormatter()
        guard let parsedDate = formatter.date(from: createdAtString) else {
            throw DecodingError.dataCorruptedError(
                forKey: .userCreatedAt,
                in: container,
                debugDescription: "‼️[디코딩 에러] User created date does not match ISO8601 format"
            )
        }
        userCreatedAt = parsedDate
        
        posts = try container.decode([MonthCalendarPostResponse].self, forKey: .posts)
    }
}
