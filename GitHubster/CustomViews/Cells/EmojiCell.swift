//
//  EmojiCell.swift
//  GitHubster
//
//  Created by Egor Tushev on 29.06.2022.
//

import UIKit

class EmojiCell: UICollectionViewCell {

    static let identifire = "\(EmojiCell.self)"

    private let emojiImageView: GitHubImageView = GitHubImageView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    func configureElements(with imageUrl: String) {
        emojiImageView.downloadImage(from: imageUrl)
    }

    private func configure() {
        addSubview(emojiImageView)

        emojiImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            emojiImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            emojiImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            emojiImageView.topAnchor.constraint(equalTo: self.topAnchor),
            emojiImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
