//
//  Date+Ext.swift
//  GitHubster
//
//  Created by Egor Tushev on 30.06.2022.
//

import Foundation

extension Date {

    func convertToMonthYearFotmat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current

        return dateFormatter.string(from: self)
    }
}
