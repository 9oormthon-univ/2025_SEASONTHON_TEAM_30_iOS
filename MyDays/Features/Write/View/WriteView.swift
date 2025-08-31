//
//  WriteView.swift
//  MyDays
//
//  Created by 양재현 on 8/30/25.
//

//MARK: - 미션 작성 화면
import PhotosUI
import SwiftUI

struct WriteView: View {
    @StateObject var vm: WriteViewModel = WriteViewModel()
    @FocusState var isFocused: Bool //미션 작성 텍스트 에디터 포커스
    @EnvironmentObject var nav: NavigationManager
    
    var body: some View {
        ScrollView {
            //오늘의 미션을 했다면
            if vm.mission?.isCompleted == true {
                TodayCompletedMissionBox()
                    .padding(.top, 40)
                    .padding(.horizontal, 26.5)
            }
            //오늘의 미션을 안했다면
            else {
                VStack(spacing: 30) {
                    //텍스트 에디터
                    TextEditor(text: $vm.text)
                        .focused($isFocused)
                        .textEditorStyle(text: $vm.text, placeholder: "내용을 입력하세요")
                    
                    //선택된 이미지
                    if let selectedImage = vm.selectedImage {
                        SelectedImageView(uiImage: selectedImage, selectedImage: $vm.selectedImage)
                    }
                    
                    //사진 추가 박스
                    else {
                        PhotosPicker(selection: $vm.selectedItem,
                                     matching: .images) {
                            AddPhotoBox()
                        }
                    }
                    
                    //작성하기 버튼
                    Button(vm.isLoading ? "" : "작성하기") { vm.postMission() }
                        .buttonStyle(.primary(isDisabled: vm.disabled))
                        .disabled(vm.disabled)
                        .overlay {
                            if vm.isLoading {
                                ProgressView()
                            }
                        }
                }
                .padding(.top, 40)
                .padding(.horizontal, 30)
                .padding(.bottom, 54 + 25) //탭뷰 height 는 54임
            }
        }
        .background(.mdSurf2)
        .onTapGesture {
            isFocused = false //다른데 터치하면 포커스 풀리기
        }
        .toolbar(.hidden, for: .navigationBar)
        //헤더 질문
        .safeAreaInset(edge: .top, alignment: .center, spacing: nil) {
            QuestionHeaderView(dayText: vm.mission?.day ?? "",
                               question: vm.mission?.text ?? "")
        }
        //사진 변경 감지해서 로드
        .onChange(of: vm.selectedItem) { _, _ in
            vm.loadTransferable()
        }
        //작성 완료 감지해서 디테일 페이지로 이동
        .onChange(of: vm.shouldNavigateToDetail) { _, newValue in
            if newValue {
                nav.push(AppRoute.postDetail)
                vm.shouldNavigateToDetail = false // 플래그 리셋 (중복 이동 방지)
            }
        }
        //작성 화면 페이지 조회 시
        .onAppear {
            vm.getWritePage()
        }
    }
}
//MARK: - 젤 위에 질문뷰
struct QuestionHeaderView: View {
    let dayText: String
    let question: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                //Day + 미션 내용
                VStack(alignment: .leading, spacing: 10) {
                    Text(dayText)
                        .font(.t2())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(question)
                        .font(.b1())
                        .foregroundColor(.white)
                }
                
                Spacer()
                //닫기 버튼 TODO: X버튼 피그마 확인
                Image("close")
                    .onTapGesture {
                        
                    }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 117)
        .padding(.horizontal, 30)
        .background(.mdSurf2)
        .dropshadow1()
    }
}


//MARK: - 텍스트 에디터 모디파이어
struct TextEditorStyleModifier: ViewModifier {
    @Binding var text: String
    var placeholder: String
    
    func body(content: Content) -> some View {
        content
            .accentColor(.white)
            .foregroundColor(.white)
            .padding(20)
            .contentMargins(.leading, -5) //딱맞네 이렇게 두니
            .contentMargins(.top, -8)
            .contentMargins(.bottom, 8)
        
            .frame(minHeight: 117)
            .scrollContentBackground(.hidden) //기본 배경 제거
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.mdSurf3)
            )
        //placeholder
            .overlay(alignment: .topLeading) {
                if text == "" {
                    Text(placeholder)
                        .font(.b2())
                        .foregroundColor(.mdBrightSurf)
                        .padding(.leading, 20)
                        .padding(.top, 20)
                }
            }
        //최대글자수 0/300
            .overlay(alignment: .bottomTrailing) {
                HStack(spacing: 0) {
                    Text("\(text.count)")
                        .foregroundColor(text == "" ? .mdDim : .white)
                    
                    Text("/300")
                        .foregroundColor(.mdDim)
                }
                .font(.b2())
                .padding(.trailing, 20.5)
                .padding(.bottom, 14)
            }
        //300자 초과하면 막기
            .onChange(of: text) { _, newValue in
                if newValue.count > 300 {
                    text = String(newValue.prefix(300))
                }
            }
    }
    
}

extension View {
    func textEditorStyle(text: Binding<String>, placeholder: String) -> some View {
        self.modifier(TextEditorStyleModifier(text: text, placeholder: placeholder))
    }
}
//MARK: - 선택된 이미지
struct SelectedImageView: View {
    let uiImage: UIImage
    @Binding var selectedImage: UIImage?
    
    var body: some View {
        let size = UIScreen.main.bounds.width - 109
        
        Image(uiImage: uiImage)
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .clipped()
            .clipShape( RoundedRectangle(cornerRadius: 12))
            .overlay(alignment: .topTrailing){
                Image("close.circle")
                    .onTapGesture {
                        selectedImage = nil
                    }
                    .padding(20)
            }
    }
}

//MARK: - 사진 추가 박스
struct AddPhotoBox: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("사진을 추가해주세요")
                .font(.b1())
                .foregroundColor(.white)
            
            Image("plus.circle")
                .padding(.top, 10)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 26.5)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.mdSurf3)
        )
        
    }
}

//MARK: - 오늘의 챌린지 완료 박스
struct TodayCompletedMissionBox: View {
    var body: some View {
        Text("오늘의 챌린지를 완료했어요!")
            .font(.b1())
            .foregroundColor(.mdBrightBlack)
            .frame(maxWidth: .infinity)
            .frame(height: 117)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
            )
    }
}

#Preview {
    NavigationStack{
        WriteView()
    }
}
