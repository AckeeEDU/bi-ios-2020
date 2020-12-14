//
//  FeedPost.swift
//  FITstagramSwiftUI
//
//  Created by Jan Kaltoun on 12.12.2020.
//

import SwiftUI

struct FeedPost: View {
    let post: Post
    
    @State var numberOfLikes = 0
    
    var body: some View {
        let image = post.image ?? UIImage(systemName: "photo")!
        
        VStack {
            HStack {
                Image(systemName: "person.crop.circle")
                    .font(.title)
                
                Spacer()
                
                VStack {
                    Text(post.author)
                        .font(.headline)
                    
                    if let locationName = post.location, let coordinate = post.coordinate {
                        NavigationLink(
                            destination: FeedPostMapView(
                                location: Location(
                                    name: locationName,
                                    coordinate: coordinate
                                )
                            )
                        ) {
                            Text(locationName)
                                .font(.subheadline)
                        }
                    }
                }
                
                Spacer()
                
                Button(action: didTapFollowButton) {
                    Text("Follow")
                        .font(.callout)
                }
                .disabled(post.isByCurrentUser)
            }
            .padding([.leading, .trailing])
            
            Image(uiImage: image)
                .resizable()
                .aspectRatio(image.size, contentMode: .fit)
            
            VStack(alignment: .leading, spacing: 8) {
                Button(action: likeButtonTapped) {
                    HStack(spacing: 4) {
                        Image(systemName: "heart")
                            .font(.headline)
                        
                        Text("\(numberOfLikes) likes")
                            .font(.subheadline)
                    }
                }
                
                Text(
                    String(post.caption.prefix(255))
                )
                .font(.caption)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.leading, .trailing])
        }
    }
}

extension FeedPost {
    func didTapFollowButton() {
        print("Follow!")
    }
    
    func likeButtonTapped() {
        numberOfLikes += 1
    }
}

struct FeedPost_Previews: PreviewProvider {
    static var previews: some View {
        FeedPost(
            post: Post.preview
        )
    }
}
