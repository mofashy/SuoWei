//
//  UserHeaderView.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/26.
//  Copyright © 2018 沈永聪. All rights reserved.
//

import UIKit

class UserHeaderView: UIView {
    
    //MARK:- Members
    private var avatarView: UIImageView!
    private var nameLabel: UILabel!
    private var descLabel: UILabel!
    
    //MARK:- Configure
    func configure(with interface: UserViewModelProtocol?) {
        guard let interface = interface else {
            clear()
            return
        }
        
        nameLabel.text = interface.name
        descLabel.text = interface.desc
    }
    
    func clear() {
        nameLabel.text = ""
        descLabel.text = ""
        avatarView.image = nil
    }
    
    //MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup
    private func setupSubviews() {
        avatarView = UIImageView()
        avatarView.layer.cornerRadius = 35
        avatarView.layer.masksToBounds = true
        self.addSubview(avatarView)
        #if DEBUG
        avatarView.backgroundColor = suowei_color_lightGray
        #endif
        
        nameLabel = UILabel()
        nameLabel.font = suowei_mediumFont(17)
        nameLabel.textColor = suowei_color_black
        self.addSubview(nameLabel)
        
        descLabel = UILabel()
        descLabel.font = suowei_regularFont(15)
        descLabel.textColor = suowei_color_lightGray
        self.addSubview(descLabel)
    }
    
    //MARK:- Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarView.frame = CGRect(x: 25, y: 25, width: 70, height: 70)
        
        let x = avatarView.frame.maxX + 20
        let maxW = suowei_screen_width * 0.8 - 20 - x
        var size = nameLabel.sizeThatFits(CGSize(width: maxW, height: 0))
        nameLabel.frame = CGRect(x: x, y: avatarView.frame.minY + 10, width: size.width, height: size.height)
        
        size = descLabel.sizeThatFits(CGSize(width: maxW, height: 0))
        descLabel.frame = CGRect(x: x, y: nameLabel.frame.maxY + 5, width: size.width, height: size.height)
    }
    
}
