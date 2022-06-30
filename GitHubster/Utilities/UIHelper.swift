//
//  UIHelper.swift
//  GitHubster
//
//  Created by Egor Tushev on 29.06.2022.
//

import UIKit

struct UIHelper {
    static func createTenColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let widht = view.bounds.width
        let padding: CGFloat = 10
        let minimumItemSpacing: CGFloat = 10
        let avalibleWidth = widht - (padding * 2) - (minimumItemSpacing * 9)
        let itemWidht = avalibleWidth / 10

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidht, height: itemWidht)

        return flowLayout
    }
}
