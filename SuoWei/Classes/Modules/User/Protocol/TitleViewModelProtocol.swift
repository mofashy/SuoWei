//
//  TitleViewModelProtocol.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/26.
//  Copyright © 2018 沈永聪. All rights reserved.
//

import UIKit

protocol TitleViewModelDelegate: NSObjectProtocol {
    
}


protocol TitleViewModelProtocol: NSObjectProtocol {
    var delegate: TitleViewModelDelegate? { get set }
    
    var title: String { get }
    var badge: Int { get }
}
