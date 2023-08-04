//
//  ScheduleViewController.swift
//  FlexibleScheduler
//
//  Created by 伊藤明孝 on 2023/07/21.
//

import UIKit

final class ScheduleViewController: UIViewController {
    
    private lazy var scheduleView =  ScheduleView()
    private var scheduleData: [ScheduleModel] = []
    private var cellHeight: CGFloat = 108
    let screenWidth = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerSettings()
    }
    
    override func loadView() {
        super.loadView()
        
        view = scheduleView
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
                    0.8 * context.maximumDetentValue
                })
            ]
        }
        
        present(nextController, animated: true)
    }
    
    
    
    
}

extension ScheduleViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        scheduleData.count
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ScheduleCollectionViewCell
        cell.layer.cornerRadius = 10
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
