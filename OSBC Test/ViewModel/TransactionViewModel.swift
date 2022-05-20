//
//  TransactionViewModel.swift
//  OSBC Test
//
//  Created by frizar fadilah on 20/05/22.
//

import Foundation
import UIKit

class TransactionViewModel {
    
    static let shared = TransactionViewModel()
    
    func onSuccessGetTransaction(transaction: TransactionModel) {

    }
    
    func onErrorLogin(error: Error) {
        print(error.localizedDescription)
    }
    
}

