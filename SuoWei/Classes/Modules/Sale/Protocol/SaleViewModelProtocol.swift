//
//  SaleViewModelProtocol.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/21.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

protocol SaleViewModelDelegate: NSObjectProtocol {
    
}


protocol SaleViewModelProtocol: NSObjectProtocol {
    var delegate: SaleViewModelDelegate? { get set }
    var cell: SaleCell? { get set }
    
    var title: String { get }
    var price: String { get }
    var url: String { get}
}
