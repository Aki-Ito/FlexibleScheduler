//
//  DateFormatUtil.swift
//  FlexibleScheduler
//
//  Created by 伊藤明孝 on 2023/08/05.
//

import Foundation
struct DateFormatUtil{
    static let shared = DateFormatUtil()
    
    func dateFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}
