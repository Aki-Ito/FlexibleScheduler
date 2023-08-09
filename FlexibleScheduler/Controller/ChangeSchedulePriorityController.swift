//
//  ChangeSchedulePriorityController.swift
//  FlexibleScheduler
//
//  Created by 伊藤明孝 on 2023/08/08.
//

import UIKit

class ChangeSchedulePriorityController: UIViewController {

    lazy var priorityView = SchedulePriorityView()
    var displayedSchedule = ScheduleModel()
    private let numberOfCells = 3
    private var cellHeight: CGFloat = 72
    private var cellWidth: CGFloat = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = priorityView
        registerSettings()
    }
    
    private func registerSettings(){
        guard let collectionView = priorityView.collectionView else {
            return
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PriorityCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "priorityCell")
        
        //MARK: layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    @IBAction func tappedSaveButton(_ sender: Any) {
        
    }
    
}

extension ChangeSchedulePriorityController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "priorityCell", for: indexPath) as! PriorityCollectionViewCell
        let scheduleArray = ScheduleModel.summarizeSchedule(first: displayedSchedule.firstSchedule, second: displayedSchedule.secondSchedule, third: displayedSchedule.thirdSchedule)
        cell.scheduleLabel.text = scheduleArray[indexPath.row]
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
}

extension ChangeSchedulePriorityController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth*0.8, height: cellHeight)
    }
}
