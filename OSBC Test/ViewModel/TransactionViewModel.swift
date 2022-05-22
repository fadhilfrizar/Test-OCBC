//
//  TransactionViewModel.swift
//  OSBC Test
//
//  Created by frizar fadilah on 20/05/22.
//

import Foundation
import UIKit

class TransactionViewModel {
    
    var balance: String = ""
    var account: String = ""
    var accountHolder: String = ""
    var time: String = ""
    
    init(transaction: TransactionDataModel) {
        self.balance = "\(transaction.amount ?? 0)"
        self.account = transaction.receipient?.accountNo ?? ""
        self.accountHolder = transaction.receipient?.accountHolder ?? ""
        
        let newTime = formatDate(date: transaction.transactionDate ?? "")
        self.time = newTime
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
    //    static let shared = TransactionViewModel()
    //
    //    func onSuccessGetTransaction(transaction: TransactionModel) {
    //
    //    }
    //
    //    func onErrorLogin(error: Error) {
    //        print(error.localizedDescription)
    //    }
    //
    //MARK: dependency injection
    //    init(transaction: TransactionModel) {
    //
    //    }
}

