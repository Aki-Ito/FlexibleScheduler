//
//  ScheduleCollectionViewCell.swift
//  FlexibleScheduler
//
//  Created by 伊藤明孝 on 2023/07/22.
//

import UIKit

protocol DetailActionDelegate: AnyObject{
    func tappedDetail(cell: ScheduleCollectionViewCell)
}

class ScheduleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    var realmUtil = RealmUtil.shared
    var correspondingData: ScheduleModel?
    weak var delegate: DetailActionDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI(){
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .gray
    }
    
    
    @IBAction func tappedDetailButton(_ sender: Any) {
        delegate?.tappedDetail(cell: self)
    }
    
    @IBAction func pageControl(_ sender: Any) {
        guard let correspondingData = correspondingData else {return}
        switch pageControl.currentPage{
        case 0: scheduleLabel.text = correspondingData.firstSchedule
        case 1: scheduleLabel.text = correspondingData.secondSchedule
        case 2: scheduleLabel.text = correspondingData.thirdSchedule
        default: break
        }
    }
}

