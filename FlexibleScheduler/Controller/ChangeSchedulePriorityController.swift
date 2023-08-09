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
    private var realmUtil = RealmUtil.shared
    private var alertHelper = AlertHelper.shared
    private var scheduleArray: [String] = []
    private let numberOfCells = 3
    private var cellHeight: CGFloat = 72
    private var cellWidth: CGFloat = UIScreen.main.bounds.width
    var celltoMove = PriorityCollectionViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = priorityView
        registerSettings()
        addEventListner()
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
        alertHelper.showAlertWithCancel(title: "保存しますか", message: "スケジュールの優先順位を入れ替えます", viewController: self) {
            self.realmUtil.editData(obj: self.displayedSchedule, firstPlan: self.scheduleArray[0], secondPlan: self.scheduleArray[1], thirdPlan: self.scheduleArray[2], limit: self.displayedSchedule.limitTime, startTime: self.displayedSchedule.startTime)
            
            let previousNC = self.presentingViewController as! UINavigationController
            let previousController = previousNC.viewControllers[previousNC.viewControllers.count - 1] as! ScheduleViewController
            previousController.scheduleView.collectionView.reloadData()
        }
    }
    
    private func addEventListner() {
        guard let collectionView = priorityView.collectionView else {
            return
        }
        let longPressGesture = UILongPressGestureRecognizer(target: self,
                                                            action: #selector(self.handleLongGesture(gesture:)))
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
    @objc private func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        guard let collectionView = priorityView.collectionView else {
            return
        }
        switch(gesture.state) {
            
        case UIGestureRecognizer.State.began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            
        case UIGestureRecognizer.State.changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
            
        case UIGestureRecognizer.State.ended:
            collectionView.endInteractiveMovement()
            
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
}

extension ChangeSchedulePriorityController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "priorityCell", for: indexPath) as! PriorityCollectionViewCell
        self.scheduleArray = ScheduleModel.summarizeSchedule(first: displayedSchedule.firstSchedule, second: displayedSchedule.secondSchedule, third: displayedSchedule.thirdSchedule)
        cell.scheduleLabel.text = scheduleArray[indexPath.row]
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tempSchedule = scheduleArray.remove(at: sourceIndexPath.item)
        scheduleArray.insert(tempSchedule, at: destinationIndexPath.item)
    }
}

extension ChangeSchedulePriorityController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth*0.8, height: cellHeight)
    }
}
