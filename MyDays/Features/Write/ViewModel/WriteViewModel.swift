//
//  WriteViewModel.swift
//  MyDays
//
//  Created by 양재현 on 8/30/25.
//

//MARK: - 미션 작성 화면 뷰모델
import Foundation
import SwiftUI
import PhotosUI

@MainActor
class WriteViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem? //갤러리에서 선택된 사진
    @Published var selectedImage: UIImage? //uiImage로 변경된 사진
    @Published var text: String = "" //콘텐츠 텍스트
    @Published var mission: WriteMission? //미션(Day, 주제)
    @Published var isLoading: Bool = false //작성하기 로딩
    @Published var navigateToPostId: String? = nil //작성하기 성공 후 디테일 페이지 보낼건지
    
    var disabled: Bool { //작성하기 버튼 disabled여부 (선택된 이미지, 작성된 텍스트 있는지 여부에 따라)
        selectedImage == nil || text == ""
    }
    
    private let writeService = WriteService() //의존성 주입 (mock or real)
    
    //MARK: - 작성 페이지 조회
    func getWritePage() {
        Task{
            do {
                let mission = try await writeService.getWritePage()
                
                self.mission = mission
            }
            catch let error as APIError {
                print(error.localizedDescription) //TODO: 에러 팝업 추가하기
            }
        }
    }
    
    //MARK: - 게시물(미션) 작성하기
    func postMission() {
        isLoading = true
        Task{
            guard let selectedImage = selectedImage else { return }
            guard let imageData = selectedImage.jpegData(compressionQuality: 1.0) else { return }
            let base64Img = imageData.base64EncodedString()
            
            //작성 성공 시
            do {
                let fetchedPostId = try await writeService.postMission(request: PostMissionRequest(
                    content: self.text,
                    base64Img: base64Img
                ))
                self.navigateToPostId = fetchedPostId
            }
            //작성 실패 시
            catch let error as APIError {
                print(error.localizedDescription)
            }
            
            isLoading = false
        }
    }
    
    //MARK: - 선택된 이미지 로드
    func loadTransferable() {
        Task {
            guard let item = selectedItem else { return }
            
            do {
                if let data = try await item.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    await MainActor.run {
                        selectedImage = uiImage
                    }
                }
            } catch {
                print("‼️ 이미지 로드 실패: \(error)")
            }
        }
    }
    
    //MARK: - 이미지 X표 누를때
    func closeImage() {
        self.selectedImage = nil
        self.selectedItem = nil
    }
}
