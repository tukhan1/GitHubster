//
//  UserInfoBodyVC.swift
//  GitHubster
//
//  Created by Egor Tushev on 30.06.2022.
//

import UIKit

class UserInfoBodyVC: UIViewController {
    
    private var userInfo: UserInfo!

    private let nameView: InfoView = InfoView(frame: .zero)
    private let emailView: InfoView = InfoView(frame: .zero)
    private let organizationView: InfoView = InfoView(frame: .zero)

    init(userInfo: UserInfo) {
        super.init(nibName: nil, bundle: nil)
        self.userInfo = userInfo
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        makeConstraints()
        configureUIElements()
    }

    private func configureUIElements() {
        nameView.set(infoType: .name, withText: userInfo.name ?? "N/A")
        organizationView.set(infoType: .organization, withText: userInfo.company ?? "N/A")
        emailView.set(infoType: .email, withText: userInfo.email ?? "N/A")
    }

    private func configure() {

        let subViews = [nameView, organizationView, emailView]

        subViews.forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                subView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
                subView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
                subView.heightAnchor.constraint(equalToConstant: 70)
            ])
        }
    }

    private func makeConstraints() {

        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            organizationView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 20),
            emailView.topAnchor.constraint(equalTo: organizationView.bottomAnchor, constant: 20)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
