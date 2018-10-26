//
//  SortViewModelProtocol.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/21.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

protocol SortViewModelDelegate: NSObjectProtocol {
    func navigate(with alignment: SortViewAlignment)
}


protocol SortViewModelProtocol: NSObjectProtocol {
    var delegate: SortViewModelDelegate? { get set }
    var view: SortView? { get set }
    
    var title: String { get }
    var total: String { get }
    var url: String { get }
}
