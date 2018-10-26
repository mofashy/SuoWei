//
//  BaseViewController.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/20.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, SlidesContentViewControllerProtocol {
    var slidesVC: SlidesViewController?
    
    //MARK:- Appearance
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        if let navigationController = navigationController {
            if navigationController.viewControllers.count > 1 {
                hidesBottomBarWhenPushed = true
            }
        }
        view.backgroundColor = UIColor.white
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "left_90"), style: .plain, target: self, action: #selector(backAction(_:)))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backAction(_:)))
        navigationController?.navigationBar.tintColor = suowei_color_black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    deinit {
        print("\(type(of: self)) deinit")
    }
    
    //MARK:- Setup
    func setupNavItems(title: String?) {
        let label = UILabel()
        label.text = title
        label.textColor = suowei_color_black
        label.font = suowei_mediumFont(18)
        label.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: label)
    }
    
    func setupLeftButtonItems(titles: String?...) {
        var items = [UIBarButtonItem]()
        for title in titles {
            let item = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(leftBarButtonItemAction(_:)))
            items.append(item)
        }
        
        navigationItem.leftBarButtonItems = items
    }
    
    func setupLeftButtonItems(images: UIImage?...) {
        var items = [UIBarButtonItem]()
        for image in images {
            let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(leftBarButtonItemAction(_:)))
            items.append(item)
        }
        
        navigationItem.leftBarButtonItems = items
    }
    
    //MARK:- Action
    @objc func backAction(_ barButtonItem: UIBarButtonItem) {
        if let naviVC = navigationController {
            naviVC.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func leftBarButtonItemAction(_ item: UIBarButtonItem) {
        
    }

}
