//
//  Post.swift
//  FITstagram
//
//  Created by Lukáš Hromadník on 04/11/2020.
//

import Foundation

struct PostResponse: Codable {
    let records: [Post]
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
