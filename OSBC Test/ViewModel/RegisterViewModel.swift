//
//  RegisterViewModel.swift
//  OSBC Test
//
//  Created by frizar fadilah on 20/05/22.
//

import Foundation
import UIKit
import RxSwift

class RegisterViewModel {
    
    static let shared = RegisterViewModel()
    private var disposeBag = DisposeBag()
    
    var viewController: RegisterController?
    
    var flagPassword = false
    var flagConfirmPassword = false
    
    func register(username: String, password: String, confirmPassword: String, indicator: UIActivityIndicatorView, view: UIView, viewController: RegisterController, confirmPasswordValidation: UILabel) {
        
        if password != confirmPassword {
            confirmPasswordValidation.isHidden = false
            confirmPasswordValidation.text = "Password does not match"
        } else {
            indicator.isHidden = false
            indicator.startAnimating()
            
            confirmPasswordValidation.isHidden = true
                        
            RegisterService.shared.register(username: username, password: password)
                .subscribe(onNext: { items in
                    
                    self.onSuccessRegister(view: viewController)
                    
                    indicator.stopAnimating()
                    indicator.isHidden = true
                    
                }, onError: {error in
                    
                    self.mapError(error: error)
                    
                    indicator.stopAnimating()
                    indicator.isHidden = true
                    
            }).disposed(by: disposeBag)
        }
    }
    
    func onSuccessRegister(view: RegisterController) {
        
        view.navigationController?.popViewController(animated: true)
        
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
