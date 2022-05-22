//
//  HistoryCollectionCell.swift
//  OSBC Test
//
//  Created by Frizar Fadilah on 05/05/22.
//

import UIKit

class HistoryCollectionCell: UICollectionViewCell {

    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var accountNoLabel: UILabel!
    @IBOutlet weak var accountHolderLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var transactionViewModel: TransactionViewModel! {
        didSet {
            self.balanceLabel.text = transactionViewModel.balance
            self.accountNoLabel.text = transactionViewModel.account
            self.accountHolderLabel.text = transactionViewModel.accountHolder
            self.timeLabel.text = transactionViewModel.time
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        self.layer.cornerRadius = 18
    }

}
