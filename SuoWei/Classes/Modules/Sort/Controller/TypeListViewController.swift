//
//  TypeListViewController.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/20.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class TypeListViewController: BaseViewController {
    
    //MARK:- Members
    private let cell_reuseIdentifier = "TypeListCell"
    private let header_reuseIdentifier = "TypeListSectionHeaderView"
    
    var collectionView: UICollectionView!
    var types: [TypeListViewModel]?
    var animated = false

    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        hidesBottomBarWhenPushed = false
        
        setupCollectionView()
        
        debugData()
    }
    
    //MARK:- Setup
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.bounds.width - 30) / 2, height: 250)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.headerReferenceSize = CGSize(width: view.bounds.width, height: (tabBarController!.tabBar.frame.minY - navigationController!.navigationBar.frame.maxY) / 3)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: tabBarController!.tabBar.frame.minY - navigationController!.navigationBar.frame.maxY), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)
        
        collectionView.register(TypeListCell.self, forCellWithReuseIdentifier: cell_reuseIdentifier)
        collectionView.register(TypeListSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: header_reuseIdentifier)
    }
    
    //MARK:- Debug
    func debugData() {
        let path = Bundle.main.path(forResource: "types", ofType: "json")!
        let data = try! Data(contentsOf: URL.init(fileURLWithPath: path))
        if let types = try? JSONDecoder().decode([TypeListModel].self, from: data) {
            self.types = types.map { return TypeListViewModel(with: $0) }
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
extension TypeListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return types?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_reuseIdentifier, for: indexPath) as! TypeListCell
        cell.configure(with: types?[indexPath.item])
        
        return cell
    }
}


//MARK:- UICollectionViewDelegate
extension TypeListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard !animated else { return }
        if (cell.frame.maxY + 20 > collectionView.frame.height && indexPath.item % 2 == 1) || indexPath.item + 1 == types?.count { animated = true }
        cell.transform = CGAffineTransform.init(translationX: 0, y: collectionView.frame.height + cell.frame.height * CGFloat(max(0, indexPath.item * 2 - 1)))
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1 / 0.7, options: .curveEaseIn, animations: {
            cell.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: header_reuseIdentifier, for: indexPath)
        
        return headerView
    }
}
