//
//  PostDetailCommentView.swift
//  MyDays
//
//  Created by 양재현 on 8/30/25.
//

//MARK: - 작성글 디테일 뷰 Comment View
import SwiftUI
import Kingfisher

struct DetailCommentView: View {
    let comment: PostDetailComment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            //<--- 유저 이미지 + 닉넴 + 칭호 + 작성시간 --->
            HStack(spacing: 10) {
                //유저 이미지
                KFImage(URL(string: comment.userimgUrl))
                    .placeholder { // 로딩 중
                        ProgressView()
                    }
                    .cancelOnDisappear(true)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: 42)
                    .clipped()
                    .clipShape(Circle())
                
                //유저 닉네임
                Text(comment.userName)
                    .font(.b3())
                    .foregroundColor(.black)
                
                //유저 칭호
                UserTitleBadge(title: comment.userTitle, color: Color(hex: comment.userTitleColor))
                
                Circle()
                    .frame(width: 4, height: 4)
                    .foregroundColor(.mdDim2)
                
                //작성시간
                Text(comment.createdAt)
                    .font(.b3())
                    .foregroundColor(.mdDim2)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            //<---------------------------->
            
            //댓글 내용
            Text(comment.content.forceCharWrapping)
                .font(.b2())
                .foregroundColor(.black)
                .padding(.leading, 52)
        }
        
    }
}

#Preview {
    DetailCommentView(comment: PostDetailComment.mockComments[0])
}
