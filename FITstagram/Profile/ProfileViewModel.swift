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
    
    func fetchPhotos() {
        let url = URL(string: "https://ackeeedu.000webhostapp.com/api.php/records/posts?filter=username,eq,\(username)")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("[ERROR]", error)
                return
            }
            
            guard let data = data else { assertionFailure(); return }
            
            let decoded = try! JSONDecoder().decode(PostResponse.self, from: data)
            self.photos = decoded.posts
        }
        task.resume()
    }
}
