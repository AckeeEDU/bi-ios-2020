//
//  CreatePostView.swift
//  FITstagramSwiftUI
//
//  Created by Jan Kaltoun on 12.12.2020.
//

import SwiftUI

struct CreatePostView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = CreatePostViewModel()
    
    @State var imagePickerIsPresented = false
    @State var errorIsPresented = false
    
    var body: some View {
        Form {
            VStack(alignment: .leading) {
                Text("Photo caption")
                    .font(.headline)
                
                TextEditor(text: $viewModel.caption)
                    .frame(height: 100)
            }
            
            HStack {
                if let location = viewModel.location {
                    Text(location.name)
                } else {
                    Text("No location")
                }
                
                Spacer()
                
                Button(action: didTapLocationButton) {
                    Image(
                        systemName: viewModel.location == nil ? "location.fill" : "trash"
                    )
                }
            }
            
            Button(action: didTapSelectPhotoButton) {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(image.size, contentMode: .fit)
                } else {
                    Text("Select photo")
                }
            }
            .frame(maxWidth: .infinity)
            .aspectRatio(1, contentMode: .fill)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: Button(action: didTapCancelButton) {
                Text("Cancel")
            },
            trailing: Group {
                switch viewModel.state {
                case .ready, .finished:
                    Button(action: didTapCreateButton) {
                        Text("Create")
                    }
                case .saving:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
        )
        .sheet(isPresented: $imagePickerIsPresented) {
            ImagePicker(image: $viewModel.image)
        }
        .alert(isPresented: $errorIsPresented) {
            Alert(
                title: Text("Error"),
                message: Text("Something went horrendously wrong."),
                dismissButton: .default(Text("YOLO")) {
                    errorIsPresented = false
                }
            )
        }
        .onReceive(viewModel.$state) { state in
            switch state {
            case .ready:
                break
            case .saving:
                break
            case let .finished(success):
                if success {
                    dismiss()
                } else {
                    viewModel.state = .ready
                }
            }
        }
    }
}

extension CreatePostView {
    func didTapLocationButton() {
        viewModel.location == nil ?
            viewModel.requestUserLocation() :
            viewModel.removeUserLocation()
    }
    
    func didTapSelectPhotoButton() {
        imagePickerIsPresented = true
    }
    
    func didTapCancelButton() {
        dismiss()
    }
    
    func didTapCreateButton() {
        viewModel.createPost()
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
    }
}
