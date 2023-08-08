//
//  ActionSheetHelper.swift
//  FlexibleScheduler
//
//  Created by 伊藤明孝 on 2023/08/08.
//

import Foundation
import UIKit

struct ActionSheetHelper{
    static let shared = ActionSheetHelper()
    
    public func showActionSheet(controller: UIViewController, changePriority: @escaping() -> Void, changeSchedule: @escaping() -> Void, deleteSchedule: @escaping() -> Void ){
        let alert: UIAlertController = UIAlertController(title: "アクション選択", message: "スケジュールに対するアクションを選択してください", preferredStyle:  UIAlertController.Style.actionSheet)
        
        let defaultAction_1: UIAlertAction = UIAlertAction(title: "プライオリティ変更", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            changePriority()
        })
        
        let defaultAction_2: UIAlertAction = UIAlertAction(title: "スケジュール変更", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            changeSchedule()
        })
        
        let defaultAction_3: UIAlertAction = UIAlertAction(title: "データ削除", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            deleteSchedule()
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        alert.addAction(defaultAction_1)
        alert.addAction(defaultAction_2)
        alert.addAction(defaultAction_3)
        alert.addAction(cancelAction)
        controller.present(alert, animated: true)
    }
}
