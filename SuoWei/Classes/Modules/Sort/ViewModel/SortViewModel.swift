//
//  SortViewModel.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/21.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class SortViewModel: NSObject, SortViewModelProtocol {
    var delegate: SortViewModelDelegate?
    var view: SortView?
    private var model: SortModel?
    
    init(with model: SortModel?) {
        self.model = model
    }
    
    var title: String {
        return self.model?.title ?? ""
    }
    
    var total: String {
        guard let model = self.model else { return "" }
        return "\(String(describing: model.total)) ITEMS"
    }
    
    var url: String {
        return self.model?.url ?? ""
    }
    
    
}
