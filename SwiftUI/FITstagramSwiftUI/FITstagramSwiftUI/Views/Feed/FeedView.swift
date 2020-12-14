//
//  FeedView.swift
//  FITstagramSwiftUI
//
//  Created by Jan Kaltoun on 12.12.2020.
//

import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    
    @State var createPostIsPresented = false
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.posts) { post in
                    FeedPost(post: post)
                }
            }
        }
        .navigationTitle(Text("Feed"))
        .navigationBarItems(
            leading: Button(action: didTapRefreshButton) {
                Image(systemName: "arrow.clockwise")
            },
            trailing: Button(action: didTapCreateButton) {
                Image(systemName: "plus")
            }
        )
        .onAppear {
            refresh()
        }
        .sheet(isPresented: $createPostIsPresented, onDismiss: { refresh() }) {
            NavigationView {
                CreatePostView()
            }
        }
        
    }
}

extension FeedView {
    func didTapRefreshButton() {
        refresh()
    }
    
    func didTapCreateButton() {
        createPostIsPresented = true
    }
    
    func refresh() {
        viewModel.loadPhotos()
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
