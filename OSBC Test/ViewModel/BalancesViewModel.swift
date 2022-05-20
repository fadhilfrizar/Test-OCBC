//
//  BalancesViewModel.swift
//  OSBC Test
//
//  Created by frizar fadilah on 20/05/22.
//

import Foundation
import UIKit

class BalancesViewModel {
    
    static let shared = BalancesViewModel()
    var balance: String = ""
    
    func onSuccessGetBalance(balances: String) {
        self.balance = balances
    }
    
    func onErrorLogin(error: Error) {
        print(error.localizedDescription)
    }
    
}
