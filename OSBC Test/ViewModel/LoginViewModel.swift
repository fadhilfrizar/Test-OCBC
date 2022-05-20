//
//  LoginViewModel.swift
//  OSBC Test
//
//  Created by Frizar Fadilah on 05/05/22.
//

import Foundation
import UIKit

class LoginViewModel {
    
    static let shared = LoginViewModel()
    
    func onSuccessLogin(accessToken: String, username: String, accountNo: String, view: UIView) {
        
        UserDefaults.standard.set(accessToken, forKey: Const.PREF_ACCESS_TOKEN)
        UserDefaults.standard.set(username, forKey: Const.PREF_USERNAME)
        UserDefaults.standard.set(accountNo, forKey: Const.PREF_ACCOUNT_NO)
        
        UserDefaults.standard.synchronize()
        
        DispatchQueue.main.async {
            let homeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeController") as! HomeController
            view.window?.rootViewController = homeController
        }
    }
    
    func onErrorLogin(error: Error) {
        print(error.localizedDescription)
    }
    
}
