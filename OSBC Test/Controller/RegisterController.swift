//
//  RegisterController.swift
//  OSBC Test
//
//  Created by Frizar Fadilah on 05/05/22.
//

import UIKit
import RxSwift

class RegisterController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView! {
        didSet {
            indicator.isHidden = true
        }
    }
    @IBOutlet weak var registerButton: UIButton! {
        didSet {
            registerButton.clipsToBounds = true
            registerButton.layer.cornerRadius = registerButton.frame.height / 2
            registerButton.backgroundColor = .black
            registerButton.setTitleColor(UIColor.white, for: .normal)
            registerButton.setTitle("REGISTER", for: .normal)
            
            registerButton.addTarget(self, action: #selector(registerButtonAction), for: .touchUpInside)
        }
    }
    @IBOutlet weak var confirmPasswordErrorMessageLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: UITextField! {
        didSet {
            confirmPasswordTextField.layer.borderWidth = 2.0
            confirmPasswordTextField.layer.borderColor = UIColor.black.cgColor
            confirmPasswordTextField.attributedPlaceholder = NSAttributedString(
                string: "confirm password",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
            )
            confirmPasswordTextField.setLeftPaddingPoints(10)
            confirmPasswordTextField.setRightPaddingPoints(10)
        }
    }
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
    
    private var disposeBag = DisposeBag()
    
    @IBOutlet weak var registerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension RegisterController {
    @objc func registerButtonAction(_ sender: UIButton) {
        
        let username = self.usernameTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        let confirmPassword = self.confirmPasswordTextField.text ?? ""
        
        RegisterViewModel.shared.register(username: username, password: password, confirmPassword: confirmPassword, indicator: indicator, view: self.view, viewController: self, confirmPasswordValidation: confirmPasswordErrorMessageLabel)
        
    }
}
