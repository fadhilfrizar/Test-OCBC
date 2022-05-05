//
//  LoginModel.swift
//  OSBC Test
//
//  Created by Frizar Fadilah on 05/05/22.
//

import Foundation

struct LoginModel: Decodable {
    
    var status: String?
    var token: String?
    var username: String?
    var accountNo: String?
    
    init(status: String?,token: String?,username: String?,accountNo: String?) {
        self.status = status
        self.token = token
        self.username = username
        self.accountNo = accountNo
    }
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case token = "token"
        case username = "username"
        case accountNo = "accountNo"
    }
    
}
