//
//  HomeController.swift
//  OSBC Test
//
//  Created by Frizar Fadilah on 05/05/22.
//

import UIKit
import RxSwift

class HomeController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView! {
        didSet {
            indicator.isHidden = true
        }
    }
    @IBOutlet weak var transferButton: UIButton!
    
    @IBOutlet weak var transactionCollectionView: UICollectionView!
    
    @IBOutlet weak var transactionHistoryLabel: UILabel!
    
    @IBOutlet weak var holderLabel: UILabel! {
        didSet {
            let username = UserDefaults.standard.string(forKey: Const.PREF_USERNAME)
            
            holderLabel.text = username

        }
    }
    
    @IBOutlet weak var accountHolderLabel: UILabel!
    
    @IBOutlet weak var accountLabel: UILabel! {
        didSet {
            let accountNo = UserDefaults.standard.string(forKey: Const.PREF_ACCOUNT_NO)

            accountLabel.text = accountNo
        }
    }
    
    @IBOutlet weak var accountNoLabel: UILabel!
    
    @IBOutlet weak var balanceLabel: UILabel!
    
    @IBOutlet weak var youHaveLabel: UILabel!
    
    @IBOutlet weak var topContainerView: UIView!
    
    @IBOutlet weak var logoutButton: UIButton! {
        didSet {
            logoutButton.setTitleColor(UIColor.black, for: .normal)
            logoutButton.setTitle("logout", for: .normal)
            logoutButton.addTarget(self, action: #selector(logoutButtonAction), for: .touchUpInside)
        }
    }
    
    private var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        getBalance()
        getTransaction()
    }
    
    func getBalance() {
        
        self.indicator.startAnimating()
        self.indicator.isHidden = false
        
        BalancesService.shared.balance()
            .subscribe(onNext: { items in
                
                BalancesViewModel.shared.onSuccessGetBalance(balances: "\(items.balance ?? 0)")
                self.balanceLabel.text = "SGD \(BalancesViewModel.shared.balance)"
                
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                
            }, onError: {error in
                BalancesViewModel.shared.onErrorLogin(error: error)
                
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                
        }).disposed(by: disposeBag)
    }
    
    func getTransaction() {
        
        self.indicator.startAnimating()
        self.indicator.isHidden = false
        
        TransactionService.shared.transaction()
            .subscribe(onNext: { items in
                
                TransactionViewModel.shared.onSuccessGetTransaction(transaction: items)
                
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                
            }, onError: {error in
                TransactionViewModel.shared.onErrorLogin(error: error)
                
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                
        }).disposed(by: disposeBag)
        
    }

}

extension HomeController {
    @objc func logoutButtonAction(_ sender: UIButton) {
        LogoutHelper.shared.logoutCredentials()
        let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginController") as! LoginController
        self.view.window?.rootViewController = loginController

        self.view.window?.makeKeyAndVisible()
    }
}
