//
//  UIColor+Ext.swift
//  GitHubster
//
//  Created by Egor Tushev on 29.06.2022.
//

import UIKit

extension UIColor {
    class var mySystemBackground: UIColor {
        if #available(iOS 13, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
}
