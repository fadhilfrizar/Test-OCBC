//
//  RegisterService.swift
//  OSBC Test
//
//  Created by frizar fadilah on 20/05/22.
//

import Foundation
import RxSwift
import Alamofire

class RegisterService: NSObject {
    
    static let shared = RegisterService()
    
    func register(username: String, password: String) -> Observable<RegisterModel> {

        // Build URL
        let url = Const.Base_Api + "register"

        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]

        let param: [String : String] = [
            "username": username,
            "password": password
        ]
        // Call API from base api manager
        return BaseApiManager.instance.apiGetRequest(url: url, method: .post, headers: header, parameters: param, encoding: JSONEncoding.init(options: .fragmentsAllowed))
    }
    
}
