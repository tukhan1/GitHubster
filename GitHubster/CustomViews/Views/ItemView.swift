//
//  ItemView.swift
//  GitHubster
//
//  Created by Egor Tushev on 30.06.2022.
//

import UIKit

enum ItemType {
    case followers, following
}

class ItemView: UIView {

    private let stackView: UIStackView = UIStackView(frame: .zero)
    private let itemCounter: UILabel = UILabel(frame: .zero)
    private let itemTitleLabel: UILabel = UILabel(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        makeConstraints()
    }

    func set(itemInfoType: ItemType, withCount count: Int) {
        switch itemInfoType {
        case .followers:
            itemTitleLabel.text = "Followers"
        case .following:
            itemTitleLabel.text = "Following"
        }
        itemCounter.text = String(count)
    }

    private func configure() {

        configureLabels()

        stackView.addArrangedSubview(itemCounter)
        stackView.addArrangedSubview(itemTitleLabel)
        stackView.axis = .vertical
        stackView.distribution = .fill

        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureLabels() {
        itemCounter.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        itemTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .heavy)

        itemTitleLabel.textColor = .darkGray

        itemCounter.textAlignment    = .center
        itemTitleLabel.textAlignment = .center
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
