//
//  Transaction.swift
//  currency-exchange
//
//  Created by Sergey Lomakin on 12/05/2019.
//  Copyright © 2019 Sergey Lomakin. All rights reserved.
//

import Foundation

class Transaction {
    var sourceAccount: Account
    var destinationAccount: Account
    var amount: Double
    
    init(sourceAccount: Account, destinationAccount: Account, amount: Double) {
        self.sourceAccount = sourceAccount
        self.destinationAccount = destinationAccount
        self.amount = amount
    }
}
