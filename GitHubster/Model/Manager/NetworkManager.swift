//
//  NetworkManager.swift
//  GitHubster
//
//  Created by Egor Tushev on 29.06.2022.
//

import UIKit

final class NetworkManager {

    static let shared = NetworkManager()

    let cahce = NSCache<NSString, UIImage>()

    private let baseURL: String = "https://api.github.com/"

    func getUsers(since lastUserId: Int, complition: @escaping (Result<[User], MyError>) -> Void) {

        let path = "users?since=\(lastUserId)"

        request(with: path, complition: complition)
    }

    func getEmoji(complition: @escaping (Result<[Emoji], MyError>) -> Void) {

        let path = "emojis"

        request(with: path) { (result: Result<[String: String], MyError>) in
            switch result {
            case .success(let emojiDict):
                var emojis: [Emoji] = []
                emojiDict.forEach { emojis.append(Emoji(title: $0.key, emojiURL: $0.value)) }
                complition(.success(emojis))
            case .failure(let error):
                complition(.failure(error))
            }
        }
    }

    func getUser(by login: String, complition: @escaping (Result<UserInfo, MyError>) -> Void) {

        let path = "users/\(login)"

        request(with: path, complition: complition)
    }

    private func request<T: Decodable>(with path: String, complition: @escaping (Result<T, MyError>) -> Void) {
        guard let url = URL(string: baseURL + path) else {
            complition(.failure(MyError.unableToComplite))
            return
        }

        let request = URLRequest(url: url)
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: request) { data, response, error in

            if let _ = error {
                complition(.failure(MyError.unableToComplite))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                complition(.failure(MyError.invalidResponse))
                return
            }

            guard let safeData = data else {
                complition(.failure(MyError.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let data = try decoder.decode(T.self, from: safeData)
                complition(.success(data))
            } catch {
                complition(.failure(MyError.invalidData))
            }
        }
        task.resume()
    }
}
