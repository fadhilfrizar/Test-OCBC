//
//  HomeController.swift
//  OSBC Test
//
//  Created by Frizar Fadilah on 05/05/22.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet weak var transferButton: UIButton!
    @IBOutlet weak var transactionCollectionView: UICollectionView!
    @IBOutlet weak var transactionHistoryLabel: UILabel!
    @IBOutlet weak var holderLabel: UILabel!
    @IBOutlet weak var accountHolderLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension HomeController {
    @objc func logoutButtonAction(_ sender: UIButton) {
        LogoutHelper.shared.logoutCredentials()
        let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginController") as! LoginController
        self.view.window?.rootViewController = loginController

        self.view.window?.makeKeyAndVisible()
    }
}
