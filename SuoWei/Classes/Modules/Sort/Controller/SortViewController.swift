//
//  SortViewController.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/20.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class SortViewController: BaseViewController {
    
    //MARK:- Members
    var topView: SortTopView!
    var bottomView: SortBottomView!
    var footView: SortFootView!
    var sorts: [SortViewModel]?
    var finished: Bool = false

    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Sort"
        
        setupSubviews()
        
        debugData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard !finished else { return }
        finished = true
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1 / 0.7, options: .curveEaseIn, animations: {
            self.topView.transform = CGAffineTransform.identity
            self.bottomView.transform = CGAffineTransform.identity
            self.footView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    //MARK:- Setup
    func setupSubviews() {
        topView = SortView.view(with: .top, viewController: self) as? SortTopView
        topView.backgroundColor = suowei_color_yellow
        
        bottomView = SortView.view(with: .bottom, viewController: self) as? SortBottomView
        bottomView.backgroundColor = suowei_color_blue
        
        footView = SortView.view(with: .foot, viewController: self) as? SortFootView
        footView.backgroundColor = suowei_color_pink
        
        topView.frame.origin.y = 0
        view.addSubview(topView)
        
        bottomView.frame.origin.y = topView.frame.maxY - (topView.maxH - topView.minH)
        view.addSubview(bottomView)
        
        footView.frame.origin.y = bottomView.frame.maxY - (topView.maxH - topView.minH)
        view.addSubview(footView)
        
        topView.transform = CGAffineTransform.init(translationX: 0, y: view.bounds.height)
        bottomView.transform = CGAffineTransform.init(translationX: 0, y: view.bounds.height + bottomView.frame.height)
        footView.transform = CGAffineTransform.init(translationX: 0, y: view.bounds.height + bottomView.frame.height * 3)
    }
    
    //MARK:- Debug
    func debugData() {
        let path = Bundle.main.path(forResource: "sorts", ofType: "json")!
        let data = try! Data(contentsOf: URL.init(fileURLWithPath: path))
        if let sorts = try? JSONDecoder().decode([SortModel].self, from: data) {
            self.sorts = sorts.map { return SortViewModel(with: $0) }
            
            topView.configure(with: self.sorts?[0], delegate: self)
            bottomView.configure(with: self.sorts?[1], delegate: self)
            footView.configure(with: self.sorts?[2], delegate: self)
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


extension SortViewController: SortViewModelDelegate {
    func navigate(with alignment: SortViewAlignment) {
        let typeListVC = TypeListViewController()
        typeListVC.title = alignment == .top ? "Top" : alignment == .bottom ? "Bottom" : "Foot"
        self.navigationController?.pushViewController(typeListVC, animated: true)
    }
    
    
}
