//
//  ViewController.swift
//  OSBC Test
//
//  Created by Frizar Fadilah on 05/05/22.
//

import UIKit
import RxSwift

class LoginController: UIViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView! {
        didSet {
            indicator.isHidden = true
        }
    }
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
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.layer.borderWidth = 2.0
            passwordTextField.layer.borderColor = UIColor.black.cgColor
            passwordTextField.attributedPlaceholder = NSAttributedString(
                string: "password",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
            )
            passwordTextField.setLeftPaddingPoints(10)
            passwordTextField.setRightPaddingPoints(10)
        }
    }
    @IBOutlet weak var usernameTextField: UITextField! {
        didSet {
            usernameTextField.layer.borderWidth = 2.0
            usernameTextField.layer.borderColor = UIColor.black.cgColor
            usernameTextField.attributedPlaceholder = NSAttributedString(
                string: "username",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
            )
            
            usernameTextField.setLeftPaddingPoints(10)
            usernameTextField.setRightPaddingPoints(10)
        }
    }
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
        
        self.indicator.startAnimating()
        self.indicator.isHidden = false
        
        LoginService.shared.login(username: username, password: password)
            .subscribe(onNext: { items in
                
                LoginViewModel.shared.onSuccessLogin(accessToken: items.token ?? "", username: items.username ?? "", accountNo: items.accountNo ?? "", view: self.view)
                
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                
            }, onError: {error in
                
                LoginViewModel.shared.onErrorLogin(error: error)
                
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                
        }).disposed(by: disposeBag)
    }
    
    @objc func registerButtonAction(_ sender: UIButton) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "registerController") as! RegisterController
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
