//
//  AppDelegate.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/20.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        configTheme()
        configRootVC()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

//    func configRootVC() {
//        let saleVCWithNav = BaseNavigationController(rootViewController: SaleViewController())
//        saleVCWithNav.tabBarItem = UITabBarItem(title: suowei_localized("suowei_tab_title_sale"), image: UIImage(named: "tabbar_home"), selectedImage: nil)
//        let sortVCWithNav = BaseNavigationController(rootViewController: SortViewController())
//        sortVCWithNav.tabBarItem = UITabBarItem(title: suowei_localized("suowei_tab_title_sort"), image: UIImage(named: "tabbar_drink"), selectedImage: nil)
//        let bagsVCWithNav = BaseNavigationController(rootViewController: BagsViewController())
//        bagsVCWithNav.tabBarItem = UITabBarItem(title: suowei_localized("suowei_tab_title_bags"), image: UIImage(named: "tabbar_cart"), selectedImage: nil)
        
//        let tabBarVC = BaseTabBarController()
//        tabBarVC.viewControllers = [saleVCWithNav, sortVCWithNav, bagsVCWithNav]
//        window = UIWindow()
//        window?.frame = suowei_screen_bounds
//        window?.rootViewController = SlidesViewController(withMenuViewController: SlideContentViewController(), mainViewController: SlideContentViewController())
//        window?.makeKeyAndVisible()
//    }
    
    //MARK:- Appearance
    func configTheme() {
        //        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: suowei_color_darkGray], for: .normal)
        //        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: suowei_color_darkPink], for: .selected)
        //        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: suowei_color_lightGray], for: .disabled)
        UITabBar.appearance().tintColor = suowei_color_black
        
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = false
        
    }
}


extension AppDelegate {
    func configRootVC() {
        let menuVC = UserViewController()
        let mainVC = BaseTabBarController()
        
        let saleVCWithNav = BaseNavigationController(rootViewController: SaleViewController())
        saleVCWithNav.tabBarItem = UITabBarItem(title: suowei_localized("suowei_tab_title_sale"), image: UIImage(named: "tabbar_home"), selectedImage: nil)
        let sortVCWithNav = BaseNavigationController(rootViewController: SortViewController())
        sortVCWithNav.tabBarItem = UITabBarItem(title: suowei_localized("suowei_tab_title_sort"), image: UIImage(named: "tabbar_drink"), selectedImage: nil)
        let bagsVCWithNav = BaseNavigationController(rootViewController: BagsViewController())
        bagsVCWithNav.tabBarItem = UITabBarItem(title: suowei_localized("suowei_tab_title_bags"), image: UIImage(named: "tabbar_cart"), selectedImage: nil)
        
        mainVC.viewControllers = [saleVCWithNav, sortVCWithNav, bagsVCWithNav]
        
        window = UIWindow()
        window?.frame = suowei_screen_bounds
        window?.rootViewController = SlidesViewController(withMenuViewController: menuVC, mainViewController: mainVC)
        window?.makeKeyAndVisible()
    }
}
