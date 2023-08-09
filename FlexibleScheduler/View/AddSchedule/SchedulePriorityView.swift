//
//  SchedulePriorityView.swift
//  FlexibleScheduler
//
//  Created by 伊藤明孝 on 2023/08/08.
//

import UIKit
class SchedulePriorityView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
//        configureLayout(to: collectionView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }
    
    func loadNib() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
}
