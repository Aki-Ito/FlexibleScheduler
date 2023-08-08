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
    private var alertHelper = AlertHelper.shared
    var editingData: ScheduleModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerSettings()
        render()
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
    
    private func render(){
        guard let schedule = editingData else {return}
        addScheduleView.render(schedule: schedule)
    }
    
    @IBAction func tappedSaveButton(){
        alertHelper.showAlertWithCancel(title: "保存しますか?", message: "選択してください", viewController: self) { [self] in
            let firstPlan: String = self.addScheduleView.FirstPlanTextField.text!
            let secondPlan: String = self.addScheduleView.SecondPlanTextField.text!
            let thirdPlan: String = self.addScheduleView.ThirdPlanTextField.text!
            let limit: TimeInterval = self.addScheduleView.limitTimeDatePicker.countDownDuration
            let startTime: Date = self.addScheduleView.startTimeDatePicker.date
            
            if editingData == nil{
                self.realmUtil.addData(firstPlan: firstPlan, secondPlan: secondPlan, thirdPlan: thirdPlan, limit: limit, startTime: startTime)
            }else{
                self.realmUtil.editData(obj: editingData!, firstPlan: firstPlan, secondPlan: secondPlan, thirdPlan: thirdPlan, limit: limit, startTime: startTime)
            }
            
            let previousNC = self.presentingViewController as! UINavigationController
            let previousController = previousNC.viewControllers[previousNC.viewControllers.count - 1] as! ScheduleViewController
            previousController.scheduleView.collectionView.reloadData()
        }
    }
}

extension AddScheduleViewController: UITextFieldDelegate{
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        true
    }
}
