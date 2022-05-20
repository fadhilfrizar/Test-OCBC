//
//  LoginService.swift
//  OSBC Test
//
//  Created by Frizar Fadilah on 05/05/22.
//

import Foundation
import RxSwift
import Alamofire

class LoginService: NSObject {
    
    static let shared = LoginService()
    
    func login(username: String, password: String) -> Observable<LoginModel> {

        // Build URL
        let url = Const.Base_Api + "login"

        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]

        let param: [String : String] = [
            "username": username,
            "password": password
        ]
        // Call API from base api manager
        return RevampBaseApiManager.instance.apiGetRequest(url: url, method: .post, headers: header, parameters: param, encoding: JSONEncoding.init(options: .fragmentsAllowed))
    }
    
}
