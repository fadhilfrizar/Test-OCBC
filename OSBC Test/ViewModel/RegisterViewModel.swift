//
//  RegisterViewModel.swift
//  OSBC Test
//
//  Created by frizar fadilah on 20/05/22.
//

import Foundation
import UIKit

class RegisterViewModel {
    
    static let shared = RegisterViewModel()
    
    func onSuccessRegister(view: RegisterController) {
        
        view.navigationController?.popViewController(animated: true)
//        UserDefaults.standard.set(accessToken, forKey: Const.PREF_ACCESS_TOKEN)
//        UserDefaults.standard.set(username, forKey: Const.PREF_USERNAME)
//        UserDefaults.standard.set(accountNo, forKey: Const.PREF_ACCOUNT_NO)
//        
//        UserDefaults.standard.synchronize()
//        
//        DispatchQueue.main.async {
//            let homeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeController") as! HomeController
//            view.window?.rootViewController = homeController
//        }
    }
    
    func onErrorLogin(error: Error) {
        print(error.localizedDescription)
    }
    
}
