//
//  TitleViewModel.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/26.
//  Copyright © 2018 沈永聪. All rights reserved.
//

import UIKit

class TitleViewModel: NSObject, TitleViewModelProtocol {
    var delegate: TitleViewModelDelegate?
    var model: TitleModel?
    
    init(with model: TitleModel?) {
        self.model = model
    }
    
    var title: String {
        guard let title = self.model?.title else { return "" }
        return suowei_localized(title)
    }
    
    var badge: Int {
        return self.model?.badge ?? 0
    }
    

}
