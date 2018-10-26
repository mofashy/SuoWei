//
//  SlidesViewController.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/25.
//  Copyright © 2018 沈永聪. All rights reserved.
//

import UIKit

protocol SlidesContentViewControllerProtocol {
    var slidesVC: SlidesViewController? { get set }
}

enum SlidesState {
    case menu
    case main
}

class SlidesViewController: UIViewController {

    //MARK:- Members
    var menuVC: UIViewController!
    var mainVC: UIViewController!
    var overlayView: UIView!
    var startPoint: CGPoint = .zero
    var state: SlidesState = .main
    
    //MARK:- Life cycle
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init?(withMenuViewController menuVC: SlidesContentViewControllerProtocol?, mainViewController mainVC: SlidesContentViewControllerProtocol?) {
        super.init(nibName: nil, bundle: nil)
        
        guard var menuVC = menuVC, var mainVC = mainVC else { return nil }
        
        self.menuVC = menuVC as? UIViewController
        self.mainVC = mainVC as? UIViewController

        weak var weakSelf = self
        menuVC.slidesVC = weakSelf
        mainVC.slidesVC = weakSelf
        
        addChild(self.menuVC)
        addChild(self.mainVC)
        view.addSubview(self.menuVC.view)
        view.addSubview(self.mainVC.view)
        
        self.menuVC.view.frame = CGRect(x: -view.frame.width * 0.8, y: 0, width: view.frame.width * 0.8, height: view.frame.height)
        
        overlayView = UIView(frame: self.mainVC.view.frame)
        overlayView.backgroundColor = UIColor.black
        overlayView.alpha = 0
        overlayView.isHidden = true
        overlayView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOverlayView)))
        view.addSubview(overlayView)
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(pan(_:))))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    public func toggleMenu() {
        switch state {
        case .menu:
            hideMenu()
        default:
            showMenu()
        }
    }
    
    private func showMenu() {
        state = .menu
        overlayView.isHidden = false
        var duration: TimeInterval = TimeInterval(0.25 * mainVC.view.frame.minX / (view.bounds.width * 0.8))
        if duration == 0 { duration = 0.25 }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            self.menuVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width * 0.8, height: self.view.frame.height)
            self.mainVC.view.frame = CGRect(x: self.view.frame.width * 0.8, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.overlayView.frame = self.mainVC.view.frame
            self.overlayView.alpha = 0.3
        }) { (finished) in
            
        }
    }
    
    private func hideMenu() {
        state = .main
        var duration: TimeInterval = TimeInterval(0.25 * mainVC.view.frame.minX / (view.bounds.width * 0.8))
        if duration == 0 { duration = 0.25 }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            self.menuVC.view.frame = CGRect(x: -self.view.frame.width * 0.8, y: 0, width: self.view.frame.width * 0.8, height: self.view.frame.height)
            self.mainVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.overlayView.frame = self.mainVC.view.frame
            self.overlayView.alpha = 0
        }) { (finished) in
            if finished {
                self.overlayView.isHidden = true
            }
        }
    }
    
    @objc private func pan(_ gesture: UIPanGestureRecognizer) {
        let middleOffset = view.frame.width * 0.8 * 0.5
        switch gesture.state {
        case .began:
            startPoint = gesture.location(in: view)
        case .changed:
            let location = gesture.location(in: view)
            let distance = startPoint.x - location.x
            translate(distance: distance)
        case .ended:
            fallthrough
        case .failed:
            fallthrough
        case .cancelled:
            let distance = mainVC.view.frame.minX
            if abs(distance) <= middleOffset {
                hideMenu()
            } else {
                showMenu()
            }
        default: break
        }
    }
    
    @objc private func tapOverlayView() {
        hideMenu()
    }
    
    private func translate(distance: CGFloat) {
        if state == .main && distance > 0 || state == .menu && distance < 0 {
            view.resignFirstResponder()
            return
        }
        let isMenu = distance < 0 ? true : false
        let maxDistance = view.frame.width * 0.8
        var distance = distance
        if distance > maxDistance { distance = maxDistance }
        if distance < -maxDistance { distance = -maxDistance }
        var frame = menuVC.view.frame
        frame.origin.x = isMenu ? -frame.width - distance : 0 - distance
        menuVC.view.frame = frame
        
        frame = mainVC.view.frame
        frame.origin.x = menuVC.view.frame.maxX
        mainVC.view.frame = frame
        
        overlayView.isHidden = false;
        overlayView.frame = mainVC.view.frame
        overlayView.alpha = 0.3 * abs(overlayView.frame.minX) / maxDistance
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


//MARK:- Appearance
extension SlidesViewController {
    override var prefersStatusBarHidden: Bool {
        return mainVC.prefersStatusBarHidden
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return mainVC.preferredStatusBarStyle
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return mainVC.preferredStatusBarUpdateAnimation
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return mainVC.supportedInterfaceOrientations
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return mainVC.preferredInterfaceOrientationForPresentation
    }
}
