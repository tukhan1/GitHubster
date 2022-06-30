//
//  AppDelegate.swift
//  GitHubster
//
//  Created by Egor Tushev on 29.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = createTabbar()

        window?.makeKeyAndVisible()

        return true
    }

    private func createUsersNC() -> UINavigationController {
        let usersVC = UsersVC()
        usersVC.title = "Users"
        usersVC.tabBarItem = UITabBarItem(title: "Users", image: UIImage(named: "person.2"), tag: 0)
        return UINavigationController(rootViewController: usersVC)
    }

    private func createEmojiNC() -> UINavigationController {
        let emojiVC = EmojiVC()
        emojiVC.title = "Emoji"
        emojiVC.tabBarItem = UITabBarItem(title: "Emoji", image: UIImage(named:"face.smiling"), tag: 1)
        return UINavigationController(rootViewController: emojiVC)
    }

    private func createTabbar() -> UITabBarController {
        let tabbar = UITabBarController()
        tabbar.viewControllers = [createUsersNC(), createEmojiNC()]
        return tabbar
    }
}

