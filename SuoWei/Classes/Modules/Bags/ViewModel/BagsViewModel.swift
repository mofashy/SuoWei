//
//  BagsViewModel.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/21.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class BagsViewModel: NSObject, BagsViewModelProtocol {
    weak var delegate: BagsViewModelDelegate?
    weak var cell: BagsCell?
    private var model: BagsModel?
    
    init(with model: BagsModel?) {
        self.model = model
    }
    
    var title: String {
        return self.model?.title ?? ""
    }
    
    var specs: String {
        return self.model?.specs ?? ""
    }
    
    var price: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber.init(value: model?.price ?? 0)) ?? ""
    }
    
    var quantity: String {
        guard let model = self.model else { return "" }
        return "\(String(describing: model.quantity))x"
    }
    
    var url: String {
        return self.model?.url ?? ""
    }
    
    
}
