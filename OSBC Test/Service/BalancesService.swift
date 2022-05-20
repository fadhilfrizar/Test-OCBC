//
//  BalancesService.swift
//  OSBC Test
//
//  Created by frizar fadilah on 20/05/22.
//

import Foundation
import RxSwift
import Alamofire

class BalancesService: NSObject {
    
    static let shared = BalancesService()
    
    func balance() -> Observable<BalancesModel> {

        let accessToken = UserDefaults.standard.string(forKey: Const.PREF_ACCESS_TOKEN)
        // Build URL
        let url = Const.Base_Api + "balance"

        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": accessToken ?? ""
        ]

        // Call API from base api manager
        return BaseApiManager.instance.apiGetRequest(url: url,
                                            method: .get,
                                            headers: header,
                                            parameters: nil)
            .observeOn(MainScheduler.instance)
    }
    
}
