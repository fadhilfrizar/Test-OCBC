//
//  ViewController.swift
//  OSBC Test
//
//  Created by Frizar Fadilah on 05/05/22.
//

import UIKit
import RxSwift

class LoginController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.clipsToBounds = true
            loginButton.layer.cornerRadius = loginButton.frame.height / 2
            loginButton.backgroundColor = .black
            loginButton.setTitleColor(UIColor.white, for: .normal)
            loginButton.setTitle("LOGIN", for: .normal)
            
            loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        }
    }
    @IBOutlet weak var registerButton: UIButton! {
        didSet {
            registerButton.clipsToBounds = true
            registerButton.layer.cornerRadius = registerButton.frame.height / 2
            registerButton.layer.borderColor = UIColor.black.cgColor
            registerButton.layer.borderWidth = 1
            
            registerButton.backgroundColor = .white
            registerButton.setTitleColor(UIColor.black, for: .normal)
            registerButton.setTitle("REGISTER", for: .normal)
            
            registerButton.addTarget(self, action: #selector(registerButtonAction), for: .touchUpInside)
            
        }
    }
    
    @IBOutlet weak var passwordErrorMessageLabel: UILabel!
    @IBOutlet weak var usernameErrorMessageLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var loginLabel: UILabel!
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}


extension LoginController {
    @objc func loginButtonAction(_ sender: UIButton) {
        
        let username = self.usernameTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        
        LoginService.shared.login(username: username, password: password)
            .subscribe(onNext: { items in
                
                LoginViewModel.shared.onSuccessLogin(accessToken: items.token ?? "", username: items.username ?? "", accountNo: items.accountNo ?? "", view: self.view)
                
            }, onError: {error in
                
                LoginViewModel.shared.onErrorLogin(error: error)
                
        }).disposed(by: disposeBag)
    }
    
    @objc func registerButtonAction(_ sender: UIButton) {
        
    }
}
