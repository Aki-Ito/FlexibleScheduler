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
