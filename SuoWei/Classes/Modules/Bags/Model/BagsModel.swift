//
//  BagsModel.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/20.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

struct BagsModel: Codable {
    var url: String?
    var title: String?
    var specs: String?
    var price: Double = 0
    var quantity: Int = 0
}
