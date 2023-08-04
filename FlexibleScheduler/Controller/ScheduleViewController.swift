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
    
    @IBAction func tappedDeleteAllButton(_ sender: Any) {
        realmUtil.deleteAllData()
        self.reloadData()
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
        cell.scheduleLabel.text = fetchedData?[indexPath.row].firstSchedule
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
