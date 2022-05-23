//
//  TransactionService.swift
//  OSBC Test
//
//  Created by frizar fadilah on 20/05/22.
//

import Foundation
import RxSwift
import Alamofire

class TransactionService: NSObject {
    
    static let shared = TransactionService()
    
    func transaction() -> Observable<TransactionModel> {

        let accessToken = UserDefaults.standard.string(forKey: Const.PREF_ACCESS_TOKEN)
        // Build URL
        let url = Const.Base_Api + "transactions"

        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": accessToken ?? ""
        ]
        print("access token", accessToken ?? "")

        // Call API from base api manager
        return BaseApiManager.instance.apiGetRequest(url: url,
                                            method: .get,
                                            headers: header,
                                                     parameters: nil, encoding: JSONEncoding.init(options: .prettyPrinted))
            .observeOn(MainScheduler.instance)
    }
    
}

