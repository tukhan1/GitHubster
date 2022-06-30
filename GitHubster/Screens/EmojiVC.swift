//
//  EmojiVC.swift
//  GitHubster
//
//  Created by Egor Tushev on 29.06.2022.
//

import UIKit

class EmojiVC: UIViewController {

    private var emojis: [Emoji] = []
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeConstraints()
        getEmoji()
    }

    private func getEmoji() {

        showLoadingView()

        NetworkManager.shared.getEmoji { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case.success(let emojis):
                DispatchQueue.main.async {
                    self.emojis = emojis
                    self.collectionView.reloadData()
                }
            case.failure(let error):
                print(error)
            }
        }
    }

    private func configure() {
        configureCollectionView()

        view.backgroundColor = .mySystemBackground
        view.addSubview(collectionView)
    }

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout:UIHelper.createTenColumnFlowLayout(in: view))

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: EmojiCell.identifire)
        collectionView.dataSource = self
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension EmojiVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.identifire, for: indexPath) as! EmojiCell
        cell.configureElements(with: emojis[indexPath.row].emojiURL)
        return cell
    }
}
