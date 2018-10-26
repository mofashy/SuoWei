//
//  BagsCell.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/20.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit
import SwipeCellKit

class BagsCell: SwipeCollectionViewCell {
    
    //MARK:- Members
    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var specsLabel: UILabel!
    private var priceLabel: UILabel!
    private var quantiyLabel: UILabel!
    
    //MARK:- Configure
    func configure(with interface: BagsViewModelProtocol?) {
        guard let interface = interface else {
            clear()
            return
        }
        
        titleLabel.text = interface.title
        specsLabel.text = interface.specs
        priceLabel.text = interface.price
        quantiyLabel.text = interface.quantity
    }
    
    func clear() {
        titleLabel.text = ""
        specsLabel.text = ""
        priceLabel.text = ""
        quantiyLabel.text = ""
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
        contentView.addSubview(imageView)
        
        titleLabel = UILabel()
        titleLabel.font = suowei_mediumFont(14)
        titleLabel.textColor = suowei_color_black
        contentView.addSubview(titleLabel)
        
        specsLabel = UILabel()
        specsLabel.font = suowei_mediumFont(12)
        specsLabel.textColor = suowei_color_lightGray
        contentView.addSubview(specsLabel)
        
        priceLabel = UILabel()
        priceLabel.font = suowei_mediumFont(12)
        priceLabel.textColor = suowei_color_lightGray
        contentView.addSubview(priceLabel)
        
        quantiyLabel = UILabel()
        quantiyLabel.font = suowei_mediumFont(12)
        quantiyLabel.textColor = suowei_color_darkGray
        contentView.addSubview(quantiyLabel)
    }
    
    //MARK:- Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 10, y: 0, width: bounds.height, height: bounds.height)
        
        var size = titleLabel.sizeThatFits(.zero)
        titleLabel.frame = CGRect(x: imageView.frame.maxX + 30, y: 5, width: size.width, height: size.height)
        
        size = specsLabel.sizeThatFits(.zero)
        specsLabel.frame = CGRect(x: titleLabel.frame.minX, y: titleLabel.frame.maxY + 5, width: size.width, height: size.height)
        
        size = priceLabel.sizeThatFits(.zero)
        priceLabel.frame = CGRect(x: specsLabel.frame.minX, y: bounds.height - size.height - 10, width: size.width, height: size.height)
        
        size = quantiyLabel.sizeThatFits(.zero)
        quantiyLabel.frame = CGRect(x: bounds.width - size.width - 5, y: (bounds.height - size.height) / 2, width: size.width, height: size.height)
    }
    
}
