//
//  BalancesModel.swift
//  OSBC Test
//
//  Created by frizar fadilah on 20/05/22.
//

import Foundation

struct BalancesModel: Decodable {
    
    var status: String?
    var accountNo: String?
    var balance: Int?
    
    init(status: String?, accountNo: String?, balance: Int?) {
        self.status = status
        self.accountNo = accountNo
        self.balance = balance
    }
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case accountNo = "accountNo"
        case balance = "balance"
    }
//    {
//        "status": "success",
//        "accountNo": "2970-111-3648",
//        "balance": 0
//    }
}
