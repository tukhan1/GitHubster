//
//  InfoView.swift
//  GitHubster
//
//  Created by Egor Tushev on 30.06.2022.
//

import UIKit

enum InfoType {
    case name, organization, email
}

class InfoView: UIView {

    private let infoTitleLabel: UILabel = UILabel(frame: .zero)
    private let infoLabel: UILabel = UILabel(frame: .zero)
    private let viewIn: UIView = UIView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        makeConstraints()
        configureLabels()
        configureLayer()
    }

    func set(infoType: InfoType, withText text: String) {
        switch infoType {
        case .name:
            infoTitleLabel.text = "Name:"
        case .organization:
            infoTitleLabel.text = "Organization:"
        case .email:
            infoTitleLabel.text = "Email:"
        }
        infoLabel.text = text
    }

    private func configure() {

        backgroundColor = .mySystemBackground

        addSubview(infoTitleLabel)
        addSubview(viewIn)
        viewIn.addSubview(infoLabel)

        viewIn.translatesAutoresizingMaskIntoConstraints = false
        infoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureLayer() {
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
    }

    private func configureLabels() {
        infoLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        infoTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        
        infoLabel.lineBreakMode = .byTruncatingTail
        infoLabel.numberOfLines = 2
        infoLabel.minimumScaleFactor = 0.7
        infoTitleLabel.textColor = .darkGray
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            viewIn.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            viewIn.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
            viewIn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            viewIn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            
            infoTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            infoTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            infoTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            infoTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            infoLabel.topAnchor.constraint(equalTo: viewIn.topAnchor),
            infoLabel.leftAnchor.constraint(equalTo: viewIn.leftAnchor),
            infoLabel.rightAnchor.constraint(equalTo: viewIn.rightAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: viewIn.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
