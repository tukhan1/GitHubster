//
//  User.swift
//  GitHubster
//
//  Created by Egor Tushev on 29.06.2022.
//

struct User: Decodable {
    let login: String
    let id: Int
    let avatarUrl: String
}
