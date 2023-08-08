//
//  ScheduleModel.swift
//  FlexibleScheduler
//
//  Created by 伊藤明孝 on 2023/07/21.
//

import Foundation
import Realm
import RealmSwift

class ScheduleModel: Object,ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id:UUID = UUID()
    @Persisted var firstSchedule: String
    @Persisted var secondSchedule: String
    @Persisted var thirdSchedule: String
    @Persisted var limitTime: Double
    @Persisted var startTime: Date
}

extension ScheduleModel{
    static let dateFormatUtil = DateFormatUtil.shared
    //MARK: 始まりから終わりの時間を計算しておく
    static func caluculateTime(startTime: Date, limit: TimeInterval) -> String{
        let endTime: Date = Date(timeInterval: limit, since: startTime)
        let formatedEndTime: String = dateFormatUtil.dateFormat(date: endTime)
        return formatedEndTime
    }
}
