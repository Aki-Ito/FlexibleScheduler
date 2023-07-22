//
//  ScheduleViewController.swift
//  FlexibleScheduler
//
//  Created by 伊藤明孝 on 2023/07/21.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    var scheduleView: ScheduleView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scheduleView = ScheduleView(frame: view.bounds)
        self.view.addSubview(scheduleView!)
    }
    
    private func registerSettings(){
        guard let collectionView = scheduleView?.collectionView else {
            return
        }
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

extension ScheduleViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}
