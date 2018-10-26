//
//  UserCell.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/21.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    //MARK:- Members
    private var titleLabel: UILabel!
    private var badgeLabel: UILabel!
    
    //MARK:- Configure
    func configure(with interface: TitleViewModelProtocol?) {
        guard let interface = interface else {
            clear()
            return
        }
        
        titleLabel.text = interface.title
        badgeLabel.text = "\(interface.badge)"
        badgeLabel.isHidden = interface.badge == 0
    }
    
    func clear() {
        titleLabel.text = ""
        badgeLabel.text = ""
    }
    
    //MARK:- Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup
    func setupSubviews() {
        titleLabel = UILabel()
        titleLabel.font = suowei_mediumFont(16)
        titleLabel.textColor = suowei_color_darkGray
        contentView.addSubview(titleLabel)
        
        badgeLabel = UILabel()
        badgeLabel.font = suowei_regularFont(12)
        badgeLabel.backgroundColor = suowei_color_darkGray
        badgeLabel.textColor = UIColor.white
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 10
        badgeLabel.layer.masksToBounds = true
        contentView.addSubview(badgeLabel)
    }
    
    //MARK:- Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var size = titleLabel.sizeThatFits(.zero)
        titleLabel.frame = CGRect(x: 30, y: (bounds.height - size.height) / 2, width: size.width, height: size.height)
        
        size = badgeLabel.sizeThatFits(.zero)
        badgeLabel.frame = CGRect(x: bounds.width * 0.6, y: (bounds.height - 20) / 2, width: max(size.width, 32), height: 20)
    }
}
