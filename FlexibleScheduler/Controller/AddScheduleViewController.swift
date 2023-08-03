//
//  AddScheduleViewController.swift
//  FlexibleScheduler
//
//  Created by 伊藤明孝 on 2023/08/02.
//

import UIKit

final class AddScheduleViewController: UIViewController {
    
    private var addScheduleView: AddScheduleView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func registerSettings(){
        addScheduleView?.FirstPlanTextField.delegate = self
        addScheduleView?.SecondPlanTextField.delegate = self
        addScheduleView?.ThirdPlanTextField.delegate = self
    }
    
    @IBAction func tappedSaveButton(){
        
    }
    
    
}

extension AddScheduleViewController: UITextFieldDelegate{
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        true
    }
}
