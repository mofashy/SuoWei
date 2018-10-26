//
//  SortView.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/20.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

enum SortViewAlignment {
    case top
    case bottom
    case foot
}

class SortView: UIView {
    
    //MARK:- Members
    var minH: CGFloat = 0
    var maxH: CGFloat = 0
    
    fileprivate var width: CGFloat = 0
    fileprivate var maskLayer: CAShapeLayer!
    fileprivate var alignment: SortViewAlignment = .top
    fileprivate var viewModel: SortViewModel?
    
    fileprivate var contentView: UIView!
    fileprivate var titleLabel: UILabel!
    fileprivate var totalLabel: UILabel!
    fileprivate var imageView: UIImageView!
    
    //MARK:- Configure
    func configure(with interface: SortViewModelProtocol?, delegate: SortViewModelDelegate?) {
        guard let interface = interface else {
            clear()
            return;
        }
        
        viewModel = interface as? SortViewModel
        viewModel?.delegate = delegate
        
        titleLabel.text = interface.title
        totalLabel.text = interface.total
    }
    
    func clear() {
        
    }
    
    //MARK:- Life cycle
    class func view(with alignment: SortViewAlignment, viewController: UIViewController?) -> SortView {
        var sortView: SortView!
        switch alignment {
        case .top:
            sortView = SortTopView.init(with: viewController)
        case .bottom:
            sortView = SortBottomView.init(with: viewController)
        case .foot:
            sortView = SortFootView.init(with: viewController)
        }
        
        sortView.alignment = alignment
        return sortView
    }
    
    init(with viewController: UIViewController?) {
        super.init(frame: .zero)
        
        let startY = viewController?.navigationController?.navigationBar.frame.maxY ?? UIApplication.shared.statusBarFrame.maxY
        let endY = viewController?.tabBarController?.tabBar.frame.minY ?? suowei_screen_bounds.maxY
        width = suowei_screen_width
        let height = endY - startY
        
        minH = 3 / 10 * height
        maxH = 4 / 10 * height
        
        frame = CGRect(x: 0, y: 0, width: width, height: maxH)
        clipsToBounds = true
        
        maskLayer = CAShapeLayer()
        maskLayer.fillColor = UIColor.white.cgColor
        maskLayer.strokeColor = UIColor.white.cgColor
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        isExclusiveTouch = true
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup
    func setupSubviews() {
        contentView = UIView()
        contentView.backgroundColor = UIColor.clear
        addSubview(contentView)
        
        titleLabel = UILabel()
        titleLabel.font = suowei_mediumFont(18)
        titleLabel.textColor = suowei_color_darkGray
        contentView.addSubview(titleLabel)
        
        totalLabel = UILabel()
        totalLabel.font = suowei_mediumFont(14)
        totalLabel.textColor = suowei_color_darkGray
        contentView.addSubview(totalLabel)
        
        imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        addSubview(imageView)
    }
    
    //MARK:- Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let maxW = bounds.width / 2
        var size = titleLabel.sizeThatFits(CGSize(width: maxW, height: 0))
        titleLabel.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        contentView.frame = CGRect(x: 0, y: 0, width: size.width, height: 0)
        
        size = totalLabel.sizeThatFits(.zero)
        totalLabel.frame = CGRect(x: (contentView.frame.width - size.width) / 2, y: titleLabel.frame.maxY, width: size.width, height: size.height)
        
        contentView.frame.size.height = totalLabel.frame.maxY
        
        if alignment == .bottom {
            contentView.frame.origin.x = (maxW - contentView.frame.width) / 2
            contentView.center.y = maxH / 2 + (maxH - minH) / 2
            imageView.frame = CGRect(x: maxW, y: 0, width: maxW, height: maxH)
        } else {
            contentView.frame.origin.x = maxW + (maxW - contentView.frame.width) / 2
            imageView.frame = CGRect(x: 0, y: 0, width: maxW, height: maxH)
            
            if alignment == .top {
                contentView.center.y = center.y - (maxH - minH) / 2
            } else {
                contentView.center.y = maxH / 2
            }
        }
    }
    
    //MARK:- Action
    @objc func tap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: gesture.view)
        switch gesture.state {
        case .ended:
            if !maskLayer.path!.contains(location) {
                guard let views = superview?.subviews as! [SortView]? else { return }
                for sortView in views {
                    // 关键在于这里的坐标映射
                    let point = gesture.view!.convert(location, to: sortView)
                    if sortView.maskLayer.path!.contains(point) {
                        viewModel?.delegate?.navigate(with: sortView.alignment)
                        break
                    }
                }
            } else {
                viewModel?.delegate?.navigate(with: alignment)
            }
        default: break
        }
    }
}


//MARK:- SortTopView
class SortTopView: SortView {
    override init(with viewController: UIViewController?) {
        super.init(with: viewController)
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: minH))
        path.addLine(to: CGPoint(x: 0, y: maxH))
        path.close()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
        
        totalLabel.textColor = UIColor(hex: 0xC9A63F)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK:- SortBottomView
class SortBottomView: SortView {
    override init(with viewController: UIViewController?) {
        super.init(with: viewController)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: maxH - minH))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: minH))
        path.addLine(to: CGPoint(x: 0, y: maxH))
        path.close()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
        
        totalLabel.textColor = UIColor(hex: 0x6883AC)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK:- SortFootView
class SortFootView: SortView {
    override init(with viewController: UIViewController?) {
        super.init(with: viewController)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: maxH - minH))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: maxH))
        path.addLine(to: CGPoint(x: 0, y: maxH))
        path.close()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
        
        totalLabel.textColor = UIColor(hex: 0xC77473)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
