//
//  LoginViewModel.swift
//  OSBC Test
//
//  Created by Frizar Fadilah on 05/05/22.
//

import Foundation
import UIKit
import RxSwift

class LoginViewModel {
    
    static let shared = LoginViewModel()
    private var disposeBag = DisposeBag()
    
    var viewController: LoginController?
    
    func login(username: String, password: String, indicator: UIActivityIndicatorView, view: UIView, viewController: LoginController, emptyValidationUsername: UILabel, emptyValidationPassword: UILabel, loginButton: UIButton) {
        
        self.viewController = viewController
        
        if username.isEmpty && password.isEmpty {
            emptyValidationUsername.isHidden = false
            emptyValidationPassword.isHidden = false
        } else if username.isEmpty && !password.isEmpty {
            emptyValidationUsername.isHidden = false
            emptyValidationPassword.isHidden = true
        } else if password.isEmpty && !username.isEmpty {
            emptyValidationPassword.isHidden = false
            emptyValidationUsername.isHidden = true
        } else {
            indicator.isHidden = false
            indicator.startAnimating()
            
            emptyValidationUsername.isHidden = true
            emptyValidationPassword.isHidden = true
            
            LoginService.shared.login(username: username, password: password)
                .subscribe(onNext: { items in
                    
                    self.onSuccessLogin(accessToken: items.token ?? "", username: items.username ?? "", accountNo: items.accountNo ?? "", view: view)
                    
                    indicator.stopAnimating()
                    indicator.hidesWhenStopped = true
                    
                }, onError: {error in
                    
                    self.mapError(error: error)
                    
                    indicator.stopAnimating()
                    indicator.hidesWhenStopped = true
                    
                }).disposed(by: disposeBag)
        }
    }
    
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
    
    func mapError(error: Error) {
        switch error {
        case Const.ApiError.session:
            self.viewController?.showToast(message: "Unauthorized", font: .systemFont(ofSize: 12.0))
        case Const.ApiError.conflict:
            self.viewController?.showToast(message: "Conflict", font: .systemFont(ofSize: 12.0))
        case Const.ApiError.forbidden:
            self.viewController?.showToast(message: "Forbidden", font: .systemFont(ofSize: 12.0))
        case Const.ApiError.notFound:
            self.viewController?.showToast(message: "Not found", font: .systemFont(ofSize: 12.0))
        case Const.ApiError.internalServalError:
            self.viewController?.showToast(message: "Internal server error", font: .systemFont(ofSize: 12.0))
        case Const.ApiError.lostConnection:
            self.viewController?.showToast(message: "Lost connection", font: .systemFont(ofSize: 12.0))
        default:
            self.viewController?.showToast(message: "Internal server error", font: .systemFont(ofSize: 12.0))
        }
    }
    
}
