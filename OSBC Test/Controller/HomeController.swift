//
//  HomeController.swift
//  OSBC Test
//
//  Created by Frizar Fadilah on 05/05/22.
//

import UIKit
import RxSwift

class HomeController: UIViewController {

    @IBOutlet weak var heightCollectionViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var indicator: UIActivityIndicatorView! {
        didSet {
            indicator.isHidden = true
        }
    }
    @IBOutlet weak var transferButton: UIButton! {
        didSet {
            transferButton.clipsToBounds = true
            transferButton.layer.cornerRadius = transferButton.frame.height / 2
            transferButton.backgroundColor = .black
            transferButton.setTitleColor(UIColor.white, for: .normal)
            transferButton.setTitle("TRANSFER", for: .normal)
            
            transferButton.addTarget(self, action: #selector(transferButtonAction), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var transactionCollectionView: UICollectionView! {
        didSet {
            transactionCollectionView.delegate = self
            transactionCollectionView.dataSource = self
            
            transactionCollectionView.register(UINib(nibName: "HistoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "historyCollectionCell")
        }
    }
    
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
    
    var transactionViewModel = [TransactionViewModel]()
    
    var transactionDataModel = [TransactionDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBalance()
        getTransaction()
    }
    
    override func viewWillLayoutSubviews() {
        self.transactionCollectionView.layoutIfNeeded()
        self.transactionCollectionView.reloadData()
        self.heightCollectionViewConstraint.constant = self.transactionCollectionView.contentSize.height
        
        self.topContainerView.roundCorners([.topRight, .bottomRight], radius: 18)
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
                
                let filteredItems = items.data?.filter { $0.transactionDate == $0.transactionDate }
                self.transactionViewModel = filteredItems?.map({return TransactionViewModel(transaction: $0)}) ?? []
                                
                self.transactionCollectionView.reloadData()
                self.viewWillLayoutSubviews()
                
                self.indicator.stopAnimating()
                self.indicator.isHidden = true
                
            }, onError: {error in
//                TransactionViewModel.shared.onErrorLogin(error: error)
                
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
    
    @objc func transferButtonAction(_ sender: UIButton) {
        
    }
    
    func formatDate(date: String) -> String {
       let dateFormatterGet = DateFormatter()
       dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

       let dateFormatter = DateFormatter()
       dateFormatter.dateStyle = .medium
       dateFormatter.timeStyle = .none

       let dateObj: Date? = dateFormatterGet.date(from: date)

       return dateFormatter.string(from: dateObj!)
    }
}


extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return transactionViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "historyCollectionCell", for: indexPath) as! HistoryCollectionCell
        let transactionViewModel = transactionViewModel[indexPath.row]
        cell.transactionViewModel = transactionViewModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 32, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(12312312)
    }
    
    
}
