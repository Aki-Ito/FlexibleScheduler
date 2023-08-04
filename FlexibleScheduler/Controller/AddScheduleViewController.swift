//
//  AddScheduleViewController.swift
//  FlexibleScheduler
//
//  Created by 伊藤明孝 on 2023/08/02.
//

import UIKit

final class AddScheduleViewController: UIViewController {
    
    private lazy var addScheduleView = AddScheduleView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = addScheduleView
        registerSettings()
    }
    
    override func loadView() {
        super.loadView()
        
        
    }
    
    private func registerSettings(){
        addScheduleView.FirstPlanTextField.delegate = self
        addScheduleView.SecondPlanTextField.delegate = self
        addScheduleView.ThirdPlanTextField.delegate = self
    }
    
    @IBAction func tappedSaveButton(){
        
    }
    
    
}

extension AddScheduleViewController: UITextFieldDelegate{
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        true
    }
}
