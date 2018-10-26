//
//  BagsViewController.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/20.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit
import SwipeCellKit

class BagsViewController: BaseViewController {
    
    //MARK:- Members
    fileprivate let cell_reuseIdentifier = "BagsCell"
    
    var collectionView: UICollectionView!
    var bags: [BagsViewModel]?
    var animated = false

    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Bags"
        
        setupCollectionView()
        
        debugData()
    }
    
    
    //MARK:- Setup
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width, height: 90)
        layout.minimumLineSpacing = 20
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: tabBarController!.tabBar.frame.minY - navigationController!.navigationBar.frame.maxY), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)
        
        collectionView.register(BagsCell.self, forCellWithReuseIdentifier: cell_reuseIdentifier)
    }
    
    //MARK:- Debug
    func debugData() {
        let path = Bundle.main.path(forResource: "bags", ofType: "json")!
        let data = try! Data(contentsOf: URL.init(fileURLWithPath: path))
        if let bags = try? JSONDecoder().decode([BagsModel].self, from: data) {
            self.bags = bags.map { return BagsViewModel(with: $0) }
            collectionView.reloadData()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


//MARK:- UICollectionViewDataSource
extension BagsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bags?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_reuseIdentifier, for: indexPath) as! BagsCell
        cell.delegate = self
        cell.configure(with: bags?[indexPath.item])
        
        return cell
    }
}


//MARK:- UICollectionViewDelegate
extension BagsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard !animated else { return }
        if cell.frame.maxY + 20 > collectionView.frame.height || indexPath.item + 1 == bags?.count { animated = true }
        cell.transform = CGAffineTransform.init(translationX: 0, y: collectionView.frame.height + cell.frame.height * CGFloat(max(0, indexPath.item * 2 - 1)))
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1 / 0.7, options: .curveEaseIn, animations: {
            cell.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}


//MARK:- SwipeCollectionViewCellDelegate
extension BagsViewController: SwipeCollectionViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        if orientation == .left {
            let checkAction = SwipeAction(style: .default, title: "check") { action, indexPath in
                // handle action by updating model with deletion
            }
            
            // customize the action appearance
            checkAction.image = UIImage(named: "check")
            checkAction.backgroundColor = UIColor.white
            
            return [checkAction]
        } else {
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                // handle action by updating model with deletion
            }
            
            // customize the action appearance
            deleteAction.image = UIImage(named: "delete")
            
            return [deleteAction]
        }
    }
}
