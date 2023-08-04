//
//  AlertHelper.swift
//  FlexibleScheduler
//
//  Created by 伊藤明孝 on 2023/08/05.
//

import Foundation
import UIKit
struct AlertHelper{
    static let shared = AlertHelper()
    
    func showSingleAlert(title: String, message: String, viewController: UIViewController, completion: @escaping() -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            completion()
        }
        alert.addAction(ok)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithCancel(title: String, message: String, viewController: UIViewController, completion: @escaping() -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            completion()
        }
        let cancel: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        alert.addAction(ok)
        alert.addAction(cancel)
        viewController.present(alert, animated: true, completion: nil)
    }
}
