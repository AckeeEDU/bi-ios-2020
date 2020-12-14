//
//  ProfileView.swift
//  FITstagramSwiftUI
//
//  Created by Jan Kaltoun on 12.12.2020.
//

import SwiftUI

struct ProfileView: View {
    static let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                VStack(alignment: .leading) {
                    Text("username")
                        .font(.largeTitle)
                    
                    Text("\(7) posts")
                }
                
                Spacer()
            }
            .padding([.top, .leading, .trailing])
            
            ScrollView(.vertical) {
                Text(viewModel.description)
                    .lineLimit(nil)
                    .padding([.bottom, .leading, .trailing])
                
                LazyVGrid(columns: Self.columns, spacing: 0) {
                    ForEach(viewModel.photos) { photo in
                        if let image = photo.image {
                            GeometryReader { geometry in
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .clipped()
                            }
                            .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchPhotos()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
