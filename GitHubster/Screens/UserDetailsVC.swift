//
//  UserDetailsVC.swift
//  GitHubster
//
//  Created by Egor Tushev on 29.06.2022.
//

import UIKit

class UserDetailsVC: UIViewController {

    private var login: String = ""

    private let headerView: UIView = UIView(frame: .zero)
    private let bodyView: UIView = UIView(frame: .zero)
    private let createdAtLabel: UILabel = UILabel(frame: .zero)

    init(login: String) {
        super.init(nibName: nil, bundle: nil)
        self.login = login
        title = login
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        makeConstraints()

        NetworkManager.shared.getUser(by: login) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let userInfo):
                DispatchQueue.main.async {
                    self.add(childVC: UserInfoHeaderVC(userInfo: userInfo), to: self.headerView)
                    self.add(childVC: UserInfoBodyVC(userInfo: userInfo), to: self.bodyView)
                    self.createdAtLabel.text = "Created at \(userInfo.createdAt.convertToDisplayFormat())"
                }
            case.failure(let error):
                self.presentAlertVC(title: "Error", message: error.rawValue)
            }
        }
    }

    private func add(childVC: UIViewController, to containerView: UIView) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.addChild(childVC)
            containerView.addSubview(childVC.view)
            childVC.view.frame = containerView.bounds
            childVC.didMove(toParent: self)
        }
    }

    private func configure() {
        view.backgroundColor = .mySystemBackground
        createdAtLabel.textAlignment = .center

        view.addSubview(headerView)
        view.addSubview(bodyView)
        view.addSubview(createdAtLabel)

        headerView.translatesAutoresizingMaskIntoConstraints = false
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        createdAtLabel.translatesAutoresizingMaskIntoConstraints = false

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }

    @objc private func dismissVC() {
        dismiss(animated: true)
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),

            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            bodyView.leftAnchor.constraint(equalTo: view.leftAnchor),
            bodyView.rightAnchor.constraint(equalTo: view.rightAnchor),
            bodyView.heightAnchor.constraint(equalToConstant: 300),

            createdAtLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            createdAtLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            createdAtLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            createdAtLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
