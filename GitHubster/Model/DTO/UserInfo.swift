//
//  UserDetail.swift
//  GitHubster
//
//  Created by Egor Tushev on 29.06.2022.
//

struct UserInfo: Decodable {
    let login: String
    let avatarUrl: String
    var name: String?
    var company: String?
    var email: String?
    let following: Int
    let followers: Int
    let createdAt: String
}
