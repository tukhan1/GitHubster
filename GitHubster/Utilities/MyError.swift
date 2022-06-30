//
//  MyError.swift
//  GitHubster
//
//  Created by Egor Tushev on 30.06.2022.
//

import Foundation

enum MyError: String,Error {
    case invalidData = "There is some problem with followers. Try again a bit later."
    case invalidResponse = "Invalid response from the server. Try again later."
    case unableToComplite = "Unable to complite this action. Check your internet connection and try again 😉"
}
