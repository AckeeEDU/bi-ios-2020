//
//  ProfileViewModel.swift
//  FITstagram
//
//  Created by Lukáš Hromadník on 11/11/2020.
//

import Foundation

final class ProfileViewModel {
    var username: String {
        get { UserDefaults.standard.string(forKey: "username") ?? "username" }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "username")
            fetchPhotos()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.viewModelDidChange(self)
            }
        }
    }
    
    var photos: [Post] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.viewModelDidChange(self)
            }
        }
    }
    
    var viewModelDidChange: (ProfileViewModel) -> Void = { _ in }
    
    private let networkService: NetworkService
    
    // MARK: - Initialization
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Public methods
    
    func fetchPhotos() {
        let url = "https://ackeeedu.000webhostapp.com/api.php/records/posts?filter=username,eq,\(username)"
        networkService.fetch(url: url) { [weak self] result in
            switch result {
            case let .success(data):
                let decoded = try! JSONDecoder().decode(PostResponse.self, from: data)
                self?.photos = decoded.posts
                
            case .failure:
                break
            }
        }
    }
}
