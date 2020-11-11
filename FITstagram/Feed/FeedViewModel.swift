//
//  FeedViewModel.swift
//  FITstagram
//
//  Created by Lukáš Hromadník on 11/11/2020.
//

import Foundation

final class FeedViewModel {
    var posts: [Post] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.viewModelDidChange(self)
            }
        }
    }
    
    var viewModelDidChange: (FeedViewModel) -> Void = { _ in }
    
    func loadPhotos() {
        let url = URL(string: "https://ackeeedu.000webhostapp.com/api.php/records/posts?order=id,desc")!
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("[ERROR]", error.localizedDescription)
                return
            }
            
            guard let data = data else { assertionFailure(); return }
            
            let decoded = try! JSONDecoder().decode(PostResponse.self, from: data)
            self?.posts = decoded.posts
        }
        task.resume()
    }
}
