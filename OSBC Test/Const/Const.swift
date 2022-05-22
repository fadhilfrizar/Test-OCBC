//
//  Const.swift
//  OSBC Test
//
//  Created by frizar fadilah on 20/05/22.
//

import Foundation


struct Const {
 
    static let Base_Api = "https://green-thumb-64168.uc.r.appspot.com/"
    
    
    
    
    //MARK: access token
    static let PREF_ACCESS_TOKEN = "pref_access_token"
    
    //MARK: user
    static let PREF_USERNAME = "pref_username"
    static let PREF_ACCOUNT_NO = "pref_account_no"
    
    enum ApiError: Error {
        case session //Status code 401
        case forbidden //Status code 403
        case notFound //Status code 404
        case conflict //Status code 409
        case responseValidationFailed //Status code 422
        case internalServalError //Status code 500
        case serviceUnavailable // Status code 503
        case badRequest //Status code 400
        case lostConnection //Status code nil
        case tooManyRequest //Status code 429
    }
}
