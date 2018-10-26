//
//  TypeListViewModelProtocol.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/21.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

protocol TypeListViewModelDelegate: NSObjectProtocol {
    
}


protocol TypeListViewModelProtocol: NSObjectProtocol {
    var delegate: TypeListViewModelDelegate? { get set }
    var cell: TypeListCell? { get set }
    
    var title: String { get }
    var price: String { get }
    var url: String { get }
}
