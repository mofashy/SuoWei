//
//  SaleViewController.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/20.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class SaleViewController: BaseViewController {
    
    //MARK:- Members
    fileprivate let cell_reuseIdentifier = "SaleCell"
    
    var collectionView: UICollectionView!
    var sales: [SaleViewModel]?
    var animated = false
//    var statusBarHidden = false
    
    //MARK:- Appearance
//    override var prefersStatusBarHidden: Bool {
//        return statusBarHidden
//    }
//
//    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
//        return .slide
//    }

    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Store"
        
        setupLeftButtonItems(titles: "User")
        setupCollectionView()
        debugData()
    }
    
    //MARK:- Setup
    func setupCollectionView() {
        // 667 => 2.5
        let lineSpacing: CGFloat = 25
        let contentH: CGFloat = 667 - 64 - 49 - lineSpacing * 2
        let itemH: CGFloat = contentH / 2.5
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width, height: itemH)
        layout.minimumLineSpacing = lineSpacing
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: tabBarController!.tabBar.frame.minY - navigationController!.navigationBar.frame.maxY), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView.register(SaleCell.self, forCellWithReuseIdentifier: cell_reuseIdentifier)
    }
    
    //MARK:- Debug
    func debugData() {
        let path = Bundle.main.path(forResource: "sales", ofType: "json")!
        let data = try! Data(contentsOf: URL.init(fileURLWithPath: path))
        if let sales = try? JSONDecoder().decode([SaleModel].self, from: data) {
            self.sales = sales.map { SaleViewModel.init(with: $0) }
            collectionView.reloadData()
        }
    }
    
    //MARK:- Action
    override func leftBarButtonItemAction(_ item: UIBarButtonItem) {
        let tabBarVC = tabBarController as? BaseTabBarController
        tabBarVC?.slidesVC?.toggleMenu()
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
extension SaleViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sales?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_reuseIdentifier, for: indexPath) as! SaleCell
        cell.configure(with: sales?[indexPath.item])
        
        return cell
    }
}


//MARK:- UICollectionViewDelegate
extension SaleViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard !animated else { return }
        if cell.frame.maxY + 20 > collectionView.frame.height || indexPath.item + 1 == sales?.count { animated = true }
        cell.transform = CGAffineTransform.init(translationX: 0, y: collectionView.frame.height + cell.frame.height * CGFloat(max(0, indexPath.item * 2 - 1)))
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1 / 0.7, options: .curveEaseIn, animations: {
            cell.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}


//MARK:- UIScrollViewDelegate
//extension SaleViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y > 0 {
//            statusBarHidden = true
//            setNeedsStatusBarAppearanceUpdate()
//            navigationController?.setNavigationBarHidden(true, animated: true)
//            tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: tabBarController!.tabBar.frame.height)
//        } else {
//            navigationController?.setNavigationBarHidden(false, animated: true)
//            statusBarHidden = false
//            setNeedsStatusBarAppearanceUpdate()
//            tabBarController?.tabBar.transform = .identity
//        }
//    }
//}
