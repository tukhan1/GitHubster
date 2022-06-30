//
//  UIViewController+Ext.swift
//  GitHubster
//
//  Created by Egor Tushev on 29.06.2022.
//

import UIKit

fileprivate var containerView: UIView = UIView(frame: .zero)

extension UIViewController {

    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = UIColor.mySystemBackground
        containerView.alpha = 0

        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }

        let activityIndicator = UIActivityIndicatorView()
        containerView.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])

        activityIndicator.startAnimating()
    }

    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
        }
    }

    func presentAlertVC(title: String?, message: String?) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel) { action in
                alertVC.dismiss(animated: true)
            }
            alertVC.addAction(action)

            self.present(alertVC, animated: true)
        }
    }
}
