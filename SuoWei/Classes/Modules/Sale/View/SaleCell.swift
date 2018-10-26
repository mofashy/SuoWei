//
//  SaleCell.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/20.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class SaleCell: UICollectionViewCell {
    
    //MARK:- Members
    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var priceLabel: UILabel!
    
    //MARK:- Configure
    func configure(with interface: SaleViewModelProtocol?) {
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
        contentView.backgroundColor = UIColor.white
        
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
        contentView.addSubview(imageView);
        
        titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.textColor = suowei_color_black
        titleLabel.font = suowei_mediumFont(20)
        contentView.addSubview(titleLabel)
        
        priceLabel = UILabel()
        priceLabel.font = suowei_mediumFont(14)
        priceLabel.textColor = suowei_color_black
        contentView.addSubview(priceLabel)
    }
    
    //MARK:- Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 0, y: 15, width: bounds.width, height: bounds.height - 15)
        
        let maxW = (bounds.width - 30) * 0.4
        var size = titleLabel.sizeThatFits(CGSize(width: maxW, height: 0))
        titleLabel.frame = CGRect(x: 15, y: 0, width: size.width, height: size.height)
        
        size = priceLabel.sizeThatFits(.zero)
        priceLabel.frame = CGRect(x: 15, y: titleLabel.frame.maxY + 20, width: size.width, height: size.height)
    }
    
}
