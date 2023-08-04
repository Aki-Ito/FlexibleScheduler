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
    
    public func addData(){
        do{
            let scheduleObj = ScheduleModel()
            let realm = try! Realm()
            try realm.write{
                realm.add(scheduleObj)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    public func editData(obj: ScheduleModel){
        
    }
}
