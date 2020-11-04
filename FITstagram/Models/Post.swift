//
//  Post.swift
//  FITstagram
//
//  Created by Lukáš Hromadník on 04/11/2020.
//

import UIKit

struct PostResponse: Codable {
    let posts: [Post]
}

extension PostResponse {
    enum CodingKeys: String, CodingKey {
        case posts = "records"
    }
}

struct Post: Hashable, Codable {
    let id: Int
    let image: String
    let username: String
    let caption: String
    let lat: Double?
    let lon: Double?
    let location: String?
}

extension Post {
    var icon: UIImage? {
        guard let data = Data(base64Encoded: image) else { return nil }
        return UIImage(data: data)
    }
}
