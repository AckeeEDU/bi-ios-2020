//
//  ProfileViewModel.swift
//  FITstagram
//
//  Created by Lukáš Hromadník on 11/11/2020.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    @Published var username: String
    @Published var description = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Fusce nibh. Etiam sapien elit, consequat eget, tristique non, venenatis quis, ante. Nunc tincidunt ante vitae massa. Ut in tortor nulla. Sed lobortis ornare porta. Ut dapibus semper nisl, quis imperdiet massa efficitur nec. Donec magna lorem, interdum nec dui in, posuere dapibus ex. Etiam porttitor sem a venenatis ornare. Duis sodales ipsum eget vestibulum auctor. Sed pellentesque sed ipsum ac consequat. Donec quis vehicula nunc."
    @Published var photos: [Post] = []
    
    private let networkService: NetworkServicing
    
    // MARK: - Initialization
    
    init(networkService: NetworkServicing = NetworkService()) {
        self.networkService = networkService
        
        username = UserDefaults.standard.string(forKey: "username") ?? "username"
    }
}

// MARK: - Public methods

extension ProfileViewModel {
    func fetchPhotos() {
        let url = "https://ackeeedu.000webhostapp.com/api.php/records/posts?filter=username,eq,\(username)"
        
        networkService.fetch(url: url) { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(data):
                    let decoded = try! JSONDecoder().decode(PostResponse.self, from: data)
                    self?.photos = decoded.posts
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
}
