//
//  FeedViewModel.swift
//  FITstagram
//
//  Created by Lukáš Hromadník on 11/11/2020.
//

import Foundation

protocol FeedViewModeling: AnyObject {
    var posts: [Post] { get set }
    var viewModelDidChange: (FeedViewModeling) -> Void { get set }
    
    func loadPhotos()
}

final class FeedViewModel: FeedViewModeling {
    var posts: [Post] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.viewModelDidChange(self)
            }
        }
    }
    
    var viewModelDidChange: (FeedViewModeling) -> Void = { _ in }
    
    private let networkService: NetworkService
    
    // MARK: - Initialization
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Public methods
    
    func loadPhotos() {
        let url = "https://ackeeedu.000webhostapp.com/api.php/records/posts?order=id,desc"
        networkService.fetch(url: url) { [weak self] result in
            switch result {
            case let .success(data):
                let decoded = try! JSONDecoder().decode(PostResponse.self, from: data)
                self?.posts = decoded.posts
            
            case .failure:
                break
            }
        }
    }
}
