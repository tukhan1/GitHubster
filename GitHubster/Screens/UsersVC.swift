//
//  UsersVC.swift
//  GitHubster
//
//  Created by Egor Tushev on 29.06.2022.
//

import UIKit

final class UsersVC: UIViewController {

    private var users: [User] = []
    private var lastUserID: Int = 0

    private let tableView: UITableView = UITableView(frame: .zero)
    private var pullControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        makeConstraints()

        configurePullControll()

        getUsers(since: lastUserID)
    }

    private func getUsers(since id: Int) {

        showLoadingView()

        NetworkManager.shared.getUsers(since: id) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case.success(let users):
                DispatchQueue.main.async {
                    self.users.append(contentsOf: users)
                    if let lastUserId = users.last?.id {
                        self.lastUserID = lastUserId
                    } else {
                        print("Array is empty")
                    }
                    self.tableView.reloadData()
                }
            case.failure(let error):
                self.presentAlertVC(title: "Error", message: error.rawValue)
            }
        }
    }

    private func configure() {
        view.addSubview(tableView)

        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifire)

        view.backgroundColor = .mySystemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    fileprivate func configurePullControll() {
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        tableView.refreshControl = pullControl
    }

    @objc private func refreshListData(_ sender: Any) {
        tableView.reloadData()
        self.pullControl.endRefreshing()
    }
}

extension UsersVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifire, for: indexPath) as! UserCell
        let user = users[indexPath.row]
        cell.configureElements(login: user.login, id: user.id, avatarURL: user.avatarUrl)
        return cell
    }
}

extension UsersVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let userDetailsVC = UserDetailsVC(login: users[indexPath.row].login)
        let navController = UINavigationController(rootViewController: userDetailsVC)
        present(navController, animated: true)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            getUsers(since: lastUserID)
        }
    }
}
