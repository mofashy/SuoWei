//
//  UserModel.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/26.
//  Copyright © 2018 沈永聪. All rights reserved.
//

import UIKit

enum Gender: Int8, Codable {
    case male = 0
    case female = 1
    case unknown = 2
}

struct UserModel: Codable {
    var name: String?
    var gender: Gender = .unknown
    var birthday: Int32 = 0
    var desc: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case gender
        case birthday
        case desc
        case url
    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//        gender = try container.decode(Gender.self, forKey: .gender)
//        birthday = try container.decode(Int32.self, forKey: .birthday)
//        desc = try container.decode(String.self, forKey: .desc)
//        url = try container.decode(String.self, forKey: .url)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        fatalError("encode(to:) has not been implemented")
//    }
}
