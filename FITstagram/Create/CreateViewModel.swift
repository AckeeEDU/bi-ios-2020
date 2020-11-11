//
//  CreateViewModel.swift
//  FITstagram
//
//  Created by Lukáš Hromadník on 11/11/2020.
//

import UIKit

protocol CreateViewModeling: AnyObject {
    var caption: String { get set }
    var image: UIImage? { get set }
    var viewModelDidChange: (CreateViewModeling) -> Void { get set }
    
    func createPost(completion: @escaping (Bool) -> Void)
}

final class CreateViewModel: CreateViewModeling {
    var caption = ""
    var image: UIImage? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.viewModelDidChange(self)
            }
        }
    }
    
    var viewModelDidChange: (CreateViewModeling) -> Void = { _ in }
    
    private var username: String {
        UserDefaults.standard.string(forKey: "username") ?? "username"
    }
    
    private let networkService: NetworkServicing
    
    // MARK: - Initialization
    
    init(networkService: NetworkServicing = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Public methods
    
    func createPost(completion: @escaping (Bool) -> Void) {
        var urlRequest = URLRequest(url: URL(string: "https://ackeeedu.000webhostapp.com/api.php/records/posts")!)
        urlRequest.allHTTPHeaderFields = ["Content-Type": "application/json"]
        urlRequest.httpMethod = "POST"
        
        let body: [String: Any?] = [
            "image": image?.jpegData(compressionQuality: 0.5)?.base64EncodedString(),
            "username": username,
            "caption": caption,
            "lat": nil,
            "lon": nil,
            "location": nil
        ]
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: body)
        
        networkService.fetch(urlRequest: urlRequest) { result in
            switch result {
            case .success:
                completion(true)
            
            case .failure:
                completion(false)
            }
        }
    }
}
