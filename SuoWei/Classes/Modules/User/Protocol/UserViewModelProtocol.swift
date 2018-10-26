//
//  UserViewModelProtocol.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/26.
//  Copyright © 2018 沈永聪. All rights reserved.
//

import UIKit

protocol UserViewModelDelegate: NSObjectProtocol {
    
}


protocol UserViewModelProtocol: NSObjectProtocol {
    var delegate: UserViewModelDelegate? { get set }
    
    var name: String { get }
    var desc: String { get }
    var url: String { get}
}
