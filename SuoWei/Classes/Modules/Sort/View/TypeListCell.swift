//
//  TypeListCell.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/21.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class TypeListCell: UICollectionViewCell {
    
    //Members
    var imageView: UIImageView!
    var titleLabel: UILabel!
    var priceLabel: UILabel!
    
    //MARK:- Configure
    func configure(with interface: TypeListViewModelProtocol?) {
        guard let interface = interface else {
            clear()
            return
        }
        
        titleLabel.text = interface.title
        priceLabel.text = interface.price
    }
    
    func clear() {
        titleLabel.text = ""
        priceLabel.text = ""
        imageView.image = nil
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
    func setupSubviews() {
        imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = suowei_color_whiteGray
        contentView.addSubview(imageView)
        
        titleLabel = UILabel()
        titleLabel.font = suowei_mediumFont(14)
        titleLabel.textColor = suowei_color_black
        contentView.addSubview(titleLabel)
        
        priceLabel = UILabel()
        priceLabel.font = suowei_mediumFont(12)
        priceLabel.textColor = UIColor(hex: 0x8A96A1)
        contentView.addSubview(priceLabel)
    }
    
    //MARK:- Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height - 40)
        
        var size = priceLabel.sizeThatFits(.zero)
        priceLabel.frame = CGRect(x: 0, y: bounds.height - size.height, width: size.width, height: size.height)
        
        size = titleLabel.sizeThatFits(.zero)
        titleLabel.frame = CGRect(x: 0, y: priceLabel.frame.minY - size.height, width: size.width, height: size.height)
    }
}


class TypeListSectionHeaderView: UICollectionReusableView {
    
    //MARK:- Members
    var imageView: UIImageView!
    
    //MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Setup
    func setupSubviews() {
        imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = suowei_color_whiteGray
        addSubview(imageView)
    }
    
    //MARK:- Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = bounds
    }
}
