//
//  ScheduleCollectionViewCell.swift
//  FlexibleScheduler
//
//  Created by 伊藤明孝 on 2023/07/22.
//

import UIKit

class ScheduleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI(){
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .gray
    }
    
    

}

