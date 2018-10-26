//
//  UserViewModel.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/26.
//  Copyright © 2018 沈永聪. All rights reserved.
//

import UIKit

class UserViewModel: NSObject, UserViewModelProtocol {
    var delegate: UserViewModelDelegate?
    var model: UserModel?
    
    init(with model: UserModel?) {
        self.model = model
    }
    
    var name: String {
        return self.model?.name ?? ""
    }
    
    var desc: String {
        return self.model?.desc ?? ""
    }
    
    var url: String {
        return self.model?.url ?? ""
    }
    

}
