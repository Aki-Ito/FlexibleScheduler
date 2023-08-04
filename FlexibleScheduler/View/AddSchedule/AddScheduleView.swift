//
//  AddScheduleView.swift
//  FlexibleScheduler
//
//  Created by 伊藤明孝 on 2023/08/02.
//

import UIKit

class AddScheduleView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var FirstPlanTextField: UITextField!
    @IBOutlet weak var SecondPlanTextField: UITextField!
    @IBOutlet weak var ThirdPlanTextField: UITextField!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var limitTimeDatePicker: UIDatePicker!
    
    @IBOutlet weak var startTimeDatePicker: UIDatePicker!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }
    
    private func setupUI(){
        limitTimeDatePicker.datePickerMode = .countDownTimer
        backgroundView.layer.cornerRadius = 10
    }
    
    func loadNib() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
}
