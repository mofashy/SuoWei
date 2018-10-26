//
//  BaseTabBarController.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/20.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController, SlidesContentViewControllerProtocol {
    var slidesVC: SlidesViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isTranslucent = false
    }
    
    override var prefersStatusBarHidden: Bool {
        return selectedViewController!.prefersStatusBarHidden
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return selectedViewController!.preferredStatusBarStyle
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return selectedViewController!.preferredStatusBarUpdateAnimation
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return selectedViewController!.supportedInterfaceOrientations
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return selectedViewController!.preferredInterfaceOrientationForPresentation
    }

}
