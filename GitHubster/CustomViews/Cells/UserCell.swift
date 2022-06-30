//
//  UsersCell.swift
//  GitHubster
//
//  Created by Egor Tushev on 29.06.2022.
//

import UIKit

final class UserCell: UITableViewCell {

    static let identifire = "\(UserCell.self)"

    private let avatarImageView: GitHubImageView = GitHubImageView(frame: .zero)
    private let loginLabel: UILabel = UILabel(frame: .zero)
    private let idLabel: UILabel = UILabel(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        makeConstraints()
    }

    func configureElements(login: String, id: Int, avatarURL: String) {
        loginLabel.text = login
        idLabel.text = "ID: \(id)"

        loginLabel.textAlignment = .left
        idLabel.textAlignment = .left

        avatarImageView.downloadImage(from: avatarURL)
    }

    private func configure() {
        let views = [avatarImageView, loginLabel, idLabel]
        views.forEach { view in
            contentView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        loginLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        idLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)

        accessoryType = .disclosureIndicator
    }

    private func makeConstraints() {
        let padding: CGFloat = 12
        NSLayoutConstraint.activate([
            avatarImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: padding),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 65),
            avatarImageView.widthAnchor.constraint(equalToConstant: 65),

            loginLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: padding),
            loginLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            loginLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -padding),
            loginLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),

            idLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: padding),
            idLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            idLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -padding),
            idLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
