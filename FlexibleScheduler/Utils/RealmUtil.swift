//
//  RealmUtil.swift
//  FlexibleScheduler
//
//  Created by 伊藤明孝 on 2023/08/02.
//

import Foundation
import Realm
import RealmSwift

class RealmUtil{
    static let shared = RealmUtil()
    
    public func addData(firstPlan: String, secondPlan:String, thirdPlan: String, limit: Double, startTime: Date){
        do{
            let scheduleObj = ScheduleModel()
            scheduleObj.firstSchedule = firstPlan
            scheduleObj.secondSchedule = secondPlan
            scheduleObj.thirdSchedule = thirdPlan
            scheduleObj.limitTime = limit
            scheduleObj.startTime = startTime
            let realm = try! Realm()
            try realm.write{
                realm.add(scheduleObj)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    public func editData(obj: ScheduleModel, firstPlan: String, secondPlan:String, thirdPlan: String, limit: Double, startTime: Date){
        do{
            let realm = try! Realm()
            try realm.write{
                obj.firstSchedule = firstPlan
                obj.secondSchedule = secondPlan
                obj.thirdSchedule = thirdPlan
                obj.limitTime = limit
                obj.startTime = startTime
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    public func deleteData(obj: ScheduleModel){
        do{
            let realm = try! Realm()
            try realm.write{
                realm.delete(obj)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    public func deleteAllData(){
        do{
            let realm = try! Realm()
            try realm.write{
                realm.deleteAll()
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    public func fetchData() -> Results<ScheduleModel>?{
        do{
            let realm = try Realm()
            let allData = realm.objects(ScheduleModel.self).sorted(byKeyPath: "startTime", ascending: true)
            return allData
        }catch{
            print(error.localizedDescription)
            return nil
        }
    }
}
