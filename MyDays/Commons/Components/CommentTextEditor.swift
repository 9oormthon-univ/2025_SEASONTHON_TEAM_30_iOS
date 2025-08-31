//
//  CommentTextEditor.swift
//  MyDays
//
//  Created by 양재현 on 8/30/25.
//

//MARK: - 댓글 텍스트 에디터 모디파이어

import SwiftUI

struct CommentTextEditorStyleModifier: ViewModifier {
    @Binding var text: String
    let isFocused: Bool
    var onSend: () -> Void
    
    func body(content: Content) -> some View {
        content
            .accentColor(.white)
            .font(.b2())
            .foregroundColor(.white)
            .padding(.leading, 20)
            .padding(.trailing, 44)
        
            .contentMargins(.leading, -5)
            .contentMargins(.top, 5)
        //                .contentMargins(.bottom, 5)
        
            .frame(minHeight: 50, maxHeight: 110)
            .fixedSize(horizontal: false, vertical: true)
            .scrollContentBackground(.hidden) //기본 배경 제거
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(hex: "000000"))
                    .stroke(
                        LinearGradient(
                        colors: [.mdPrimary, Color(hex: "60CE38")],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                        lineWidth: 2)
            )
        //댓글 달기 + 전송버튼
            .overlay(alignment: .bottom) {
                HStack{
                    if text.isEmpty && !isFocused {
                        Text("댓글달기")
                            .font(.b2Bold())
                            .foregroundStyle(
                                    LinearGradient(
                                        colors: [.mdPrimary, Color(hex: "60CE38")],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                    }
                    Spacer()
                    Image(text == "" ? "up" : "up.circle")
                        .onTapGesture {
                            if !text.isEmpty {
                                onSend()
                            }
                        }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
            }
        //100자 초과하면 막기
            .onChange(of: text) { _, newValue in
                if newValue.count > 100 {
                    text = String(newValue.prefix(100))
                }
            }
        
    }
}
extension View {
    func commentTextEditorStyle(text: Binding<String>, isFocused: Bool, onSend: @escaping () ->  Void) -> some View {
        self.modifier(CommentTextEditorStyleModifier(text: text, isFocused: isFocused, onSend: onSend))
    }
}


#Preview {
    @Previewable @State var text: String = ""
    @FocusState var isFocused: Bool
    
    VStack{
        TextEditor(text: $text)
            .focused($isFocused)
            .commentTextEditorStyle(text: $text, isFocused: isFocused) {
                print("전송 버튼 탭")
            }
    }
    .frame(maxHeight: .infinity)
    .padding(.horizontal, 22.5)
    .background(.mdSurf2)
}
