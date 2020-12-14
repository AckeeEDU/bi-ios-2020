//
//  FeedViewModel.swift
//  FITstagram
//
//  Created by Lukáš Hromadník on 11/11/2020.
//

import Foundation

final class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    private let networkService: NetworkServicing
    
    // MARK: - Initialization
    
    init(networkService: NetworkServicing = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Public methods
    
    func loadPhotos() {
        let url = "https://ackeeedu.000webhostapp.com/api.php/records/posts?order=id,desc"
        
        networkService.fetch(url: url) { [weak self] result in
            switch result {
            case let .success(data):
                let decoded = try! JSONDecoder().decode(PostResponse.self, from: data)
                
                DispatchQueue.main.async { [weak self] in
                    self?.posts = decoded.posts
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
