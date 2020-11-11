//
//  CreateViewModel.swift
//  FITstagram
//
//  Created by Lukáš Hromadník on 11/11/2020.
//

import UIKit

final class CreateViewModel {
    var caption = ""
    var image: UIImage? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.viewModelDidChange(self)
            }
        }
    }
    var username: String {
        UserDefaults.standard.string(forKey: "username") ?? "username"
    }
    
    var viewModelDidChange: (CreateViewModel) -> Void = { _ in }
    
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
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("[ERROR]", error.localizedDescription)
                completion(false)
                return
            }
            
            guard let data = data else { assertionFailure(); return }
            
            print(String(data: data, encoding: .utf8)!)
            
            completion(true)
        }
        task.resume()
    }
}
