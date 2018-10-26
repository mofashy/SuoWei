//
//  SaleViewModel.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/20.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class SaleViewModel: NSObject, SaleViewModelProtocol {
    weak var delegate: SaleViewModelDelegate?
    weak var cell: SaleCell?
    private var model: SaleModel?
    
    init(with model: SaleModel?) {
        self.model = model
    }
    
    var title: String {
        return self.model?.title ?? ""
    }
    
    var price: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber.init(value: model?.price ?? 0)) ?? ""
    }
    
    var url: String {
        return self.model?.url ?? ""
    }
}
