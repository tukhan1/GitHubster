//
//  UserInfoHeaderVC.swift
//  GitHubster
//
//  Created by Egor Tushev on 29.06.2022.
//

import UIKit

class UserInfoHeaderVC: UIViewController {

    private let avatarImageView: GitHubImageView = GitHubImageView(frame: .zero)
    private let stackView: UIStackView = UIStackView(frame: .zero)
    private let itemViewOne: ItemView = ItemView(frame: .zero)
    private let itemViewTwo: ItemView = ItemView(frame: .zero)
    
    private let avatarSize: CGFloat = 120

    private var userInfo: UserInfo!

    init(userInfo: UserInfo) {
        super.init(nibName: nil, bundle: nil)
        self.userInfo = userInfo
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeConstraints()
        configureUIElements()
    }

    private func configureUIElements() {
        avatarImageView.downloadImage(from: userInfo.avatarUrl)
        itemViewOne.set(itemInfoType: .followers, withCount: userInfo.followers)
        itemViewTwo.set(itemInfoType: .following, withCount: userInfo.following)
    }

    private func configure() {

        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(itemViewOne)
        stackView.addArrangedSubview(itemViewTwo)

        avatarImageView.layer.cornerRadius = avatarSize / 2

        let subViews = [avatarImageView, stackView]

        subViews.forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func makeConstraints() {

        let padding: CGFloat = 12

        NSLayoutConstraint.activate([
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: avatarSize),
            avatarImageView.widthAnchor.constraint(equalToConstant: avatarSize),

            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: padding),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            stackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
