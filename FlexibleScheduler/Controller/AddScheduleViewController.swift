//
//  AddScheduleViewController.swift
//  FlexibleScheduler
//
//  Created by 伊藤明孝 on 2023/08/02.
//

import UIKit

final class AddScheduleViewController: UIViewController {
    
    private lazy var addScheduleView = AddScheduleView()
    private var realmUtil = RealmUtil.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        registerSettings()
    }
    
    override func loadView() {
        super.loadView()
        view = addScheduleView
    }
    
    private func registerSettings(){
        addScheduleView.FirstPlanTextField.delegate = self
        addScheduleView.SecondPlanTextField.delegate = self
        addScheduleView.ThirdPlanTextField.delegate = self
    }
    
    @IBAction func tappedSaveButton(){
        let firstPlan: String = addScheduleView.FirstPlanTextField.text!
        let secondPlan: String = addScheduleView.SecondPlanTextField.text!
        let thirdPlan: String = addScheduleView.ThirdPlanTextField.text!
        let limit: TimeInterval = addScheduleView.limitTimeDatePicker.countDownDuration
        let startTime: Date = addScheduleView.startTimeDatePicker.date
        
        realmUtil.addData(firstPlan: firstPlan, secondPlan: secondPlan, thirdPlan: thirdPlan, limit: limit, startTime: startTime)
    }
    
    
}

extension AddScheduleViewController: UITextFieldDelegate{
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        true
    }
}
