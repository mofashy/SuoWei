//
//  Defines.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/20.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit


//MARK:- Color
let suowei_color_theme = UIColor(hex: 0xE2B95C)
let suowei_color_black = UIColor(hex: 0x333333)
let suowei_color_darkGray = UIColor(hex: 0x666666)
let suowei_color_lightGray = UIColor(hex: 0x999999)
let suowei_color_whiteGray = UIColor(hex: 0xEEEEEE)
let suowei_color_yellow = UIColor(hex: 0xFBF4E1)
let suowei_color_blue = UIColor(hex: 0xD2E2F6)
let suowei_color_pink = UIColor(hex: 0xFBE3E2)

//MARK:- Frame
let suowei_screen_bounds = UIScreen.main.bounds
let suowei_screen_size = suowei_screen_bounds.size
let suowei_screen_width = suowei_screen_size.width
let suowei_screen_height = suowei_screen_size.height

//MARK:- Font
func suowei_regularFont(_ size: CGFloat) -> UIFont? {
    return UIFont(name: "PingFangSC-Regular", size: size)
}

func suowei_mediumFont(_ size: CGFloat) -> UIFont? {
    return UIFont(name: "PingFangSC-Medium", size: size)
}

//MARK:- NotificationName

//MARK:- Alias
func suowei_localized(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

//MARK:- Extension
extension UIColor {
    convenience init(hex: Int) {
        self.init(red: (CGFloat)((hex & 0xFF0000) >> 16) / 255.0, green: (CGFloat)((hex & 0x00FF00) >> 8) / 255.0, blue: (CGFloat)(hex & 0x0000FF) / 255.0, alpha: 1.0)
    }
}
