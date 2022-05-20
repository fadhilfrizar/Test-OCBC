//
//  RegisterModel.swift
//  OSBC Test
//
//  Created by frizar fadilah on 20/05/22.
//

import Foundation

struct RegisterModel: Decodable {
    
    var status: String?
    var token: String?
    
    init(status: String?,token: String?) {
        self.status = status
        self.token = token
    }
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case token = "token"
    }
    
}
