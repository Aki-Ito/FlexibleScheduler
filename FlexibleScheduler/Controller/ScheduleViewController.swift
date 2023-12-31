//
//  ScheduleViewController.swift
//  FlexibleScheduler
//
//  Created by 伊藤明孝 on 2023/07/21.
//

import UIKit
import Realm
import RealmSwift

final class ScheduleViewController: UIViewController {
    
    lazy var scheduleView =  ScheduleView()
    private var realmUtil = RealmUtil.shared
    private var dateFormatUtil = DateFormatUtil.shared
    private var alertHelper = AlertHelper.shared
    private var actionSheetHelper = ActionSheetHelper.shared
    private var fetchedData: Results<ScheduleModel>?
    private var cellHeight: CGFloat = 108
    let screenWidth = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerSettings()
        self.fetchedData = realmUtil.fetchData()
        self.reloadData()
    }
    
    override func loadView() {
        super.loadView()
        
        view = scheduleView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchedData = realmUtil.fetchData()
        self.reloadData()
    }
    
    private func reloadData(){
        guard let collectionView = scheduleView.collectionView else {
            return
        }
        collectionView.reloadData()
    }
    
    private func registerSettings(){
        guard let collectionView = scheduleView.collectionView else {
            return
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ScheduleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        //MARK: layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    @IBAction func tappedAddButton(_ sender: Any) {
        self.transferToAddView()
    }
    
    @IBAction func tappedDeleteAllButton(_ sender: Any) {
        alertHelper.showAlertWithCancel(title: "データを全て削除します", message: "次に進むとデータは全て消去されます", viewController: self) {
            self.realmUtil.deleteAllData()
            self.reloadData()
        }
    }
    
    private func transferToAddView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextController =  storyboard.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        if let sheet = nextController.sheetPresentationController{
            sheet.detents = [
                .custom(resolver: { context in
                    0.9 * context.maximumDetentValue
                })
            ]
        }
        present(nextController, animated: true)
    }
    
    private func transferToEditView(indexPath: IndexPath){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextController =  storyboard.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        if let sheet = nextController.sheetPresentationController{
            sheet.detents = [
                .custom(resolver: { context in
                    0.9 * context.maximumDetentValue
                })
            ]
        }
        //MARK: 値渡し
        let addController = nextController.viewControllers[0] as! AddScheduleViewController
        addController.editingData = fetchedData?[indexPath.row]
        present(nextController, animated: true)
    }
    
    private func transferToPriorityView(indexPath: IndexPath){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextController =  storyboard.instantiateViewController(withIdentifier: "SecondNavigationController") as! UINavigationController
        if let sheet = nextController.sheetPresentationController{
            sheet.detents = [
                .custom(resolver: { context in
                    0.4 * context.maximumDetentValue
                })
            ]
        }
        //MARK: 値渡し
        let priorityController = nextController.viewControllers[0] as! ChangeSchedulePriorityController
        if let data = fetchedData?[indexPath.row]{
            priorityController.displayedSchedule = data
        }
        present(nextController, animated: true)
    }
    
}

extension ScheduleViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let fetchedData = fetchedData else {return 0}
        return fetchedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ScheduleCollectionViewCell
        cell.layer.cornerRadius = 10
        let correspondingData = fetchedData?[indexPath.row]
        cell.correspondingData = correspondingData
        cell.scheduleLabel.text = correspondingData?.firstSchedule
        cell.delegate = self
        let startTime = dateFormatUtil.dateFormat(date: fetchedData?[indexPath.row].startTime ?? Date())
        let endTime = ScheduleModel.caluculateTime(startTime: fetchedData?[indexPath.row].startTime ?? Date(), limit: fetchedData?[indexPath.row].limitTime ?? 0)
        cell.timeLabel.text = "\(startTime)~\(endTime)"
        return cell
    }
}

extension ScheduleViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = screenWidth*0.8
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    //MARK: セル間の距離の調整
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    //MARK: paddingの調整
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
    }
}

extension ScheduleViewController: DetailActionDelegate{
    func tappedDetail(cell: ScheduleCollectionViewCell) {
        guard let collectionView = scheduleView.collectionView else {
            return
        }
        if let indexPath = collectionView.indexPath(for: cell){
            actionSheetHelper.showActionSheet(controller: self) {
                self.transferToPriorityView(indexPath: indexPath)
            } changeSchedule: {
                self.transferToEditView(indexPath: indexPath)
            } deleteSchedule: {
                self.alertHelper.showAlertWithCancel(title: "データ削除しますか", message: "元に戻せません", viewController: self) {
                    guard let data = self.fetchedData else {return}
                    self.realmUtil.deleteData(obj: data[indexPath.row])
                    self.reloadData()
                }
            }
        }
    }
}
