//
//  BagsViewModelProtocol.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/21.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

protocol BagsViewModelDelegate: NSObjectProtocol {
    
}


protocol BagsViewModelProtocol: NSObjectProtocol {
    var delegate: BagsViewModelDelegate? { get set }
    var cell: BagsCell? { get set }
    
    var title: String { get }
    var specs: String { get }
    var price: String { get }
    var quantity: String { get }
    var url: String { get }
}
